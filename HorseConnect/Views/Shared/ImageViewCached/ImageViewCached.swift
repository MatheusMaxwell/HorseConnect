import SwiftUI

struct ImageViewCached<Placeholder>: View where Placeholder: View {

    // MARK: - Value
    // MARK: Private
    @State private var image: Image? = nil
    @State private var task: Task<(), Never>? = nil
    @State private var isProgressing = false

    private let url: URL?
    private let placeholder: () -> Placeholder?


    // MARK: - Initializer
    init(url: URL?, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.url = url
        self.placeholder = placeholder
    }

    init(url: URL?) where Placeholder == Color {
        self.init(url: url, placeholder: { Color("neutral9") })
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                placholderView
                imageView(proxy: proxy)
                progressView
            }
            .cornerRadius(10)
            .frame(width: proxy.size.width, height: proxy.size.height)
            .task {
                task?.cancel()
                task = Task.detached(priority: .background) {
                    await MainActor.run { isProgressing = true }
                
                    do {
                        let image = try await ImageManager.shared.download(url: url)
                    
                        await MainActor.run {
                            isProgressing = false
                            self.image = image
                        }
                    
                    } catch {
                        await MainActor.run { isProgressing = false }
                    }
                }
            }
            .onDisappear {
                task?.cancel()
            }
        }
    }
    
    // MARK: Private
    @ViewBuilder
    private func imageView(proxy: GeometryProxy) -> some View {
        if let image = image {
            image
                .resizable()
                .scaledToFill()
        } else {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.4))
                .cornerRadius(6, corners: [.allCorners])
                .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }

    @ViewBuilder
    private var placholderView: some View {
        if !isProgressing, image == nil {
            placeholder()
        }
    }
    
    @ViewBuilder
    private var progressView: some View {
        if isProgressing {
            ProgressView()
                .progressViewStyle(.circular)
        }
    }
}


#if DEBUG
struct ImageView_Previews: PreviewProvider {

    static var previews: some View {
        let view = VStack {
            ImageViewCached(url: URL(string: "https://wallpaperset.com/w/full/d/2/b/115638.jpg"))
                .frame(width: 300, height: 300)
                .cornerRadius(20)
        
            ImageViewCached(url: URL(string: "https://wallpaperset.com/w/full/d/2/b/115638")) {
                Text("⚠️")
                    .font(.system(size: 120))
            }
            .frame(width: 300, height: 300)
            .cornerRadius(20)
        }
    
        view
            .previewDevice("iPhone 11 Pro")
            .preferredColorScheme(.light)
    }
}
#endif
