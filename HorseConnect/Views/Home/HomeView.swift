//
//  HomeView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var model = HomeViewModel()
    
    init() {
        URLCache.shared.memoryCapacity = 10_000_000 // ~10 MB memory space
        URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
    }

    var body: some View {
        ZStack{
            ColorUtil
                .getPrimaryColor(farmData: model.state.farmData)
                .ignoresSafeArea(.all)
            
            VStack{
                Spacer()
                
                if model.state.farmData != nil && !model.state.farmData!.imageLogoUrl.isEmpty {
                    AsyncImage(
                        url: URL(string: model.state.farmData!.imageLogoUrl),
                        content: { image in
                            image
                                .resizable()
                                .frame(maxWidth: UIScreen.main.bounds.size.width*0.8, maxHeight: .infinity)
                                .aspectRatio(contentMode: .fit)
                                
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .padding(.top, 20)
                    .frame(height: 100)
                }
                Text(model.state.farmData?.farmName ?? "")
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
                    .isHidden(model.state.farmData?.imageLogoUrl != "")
                Spacer()
                VStack{
                    HStack{
                        cardHome(imagePath: "HorseCardHome", title: "Plantel")
                            .padding(.trailing, 5)
                            .padding(.bottom)
                        cardHome(imagePath: "StationCardHome", title: "Estação")
                            .padding(.leading, 5)
                            .padding(.bottom)

                    }
                    .padding()
                    HStack{
                        cardHome(imagePath: "VaccineCardHome", title: "Vacinação")
                            .padding(.trailing, 5)
                            .padding(.top)
                        cardHome(imagePath: "FinanceCardHome", title: "Financeiro")
                            .padding(.leading, 5)
                            .padding(.top)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.size.height*0.75)
                .background(.white)
                .cornerRadius(12, corners: [.topLeft, .topRight])
            }
            .padding(.bottom, -40)
            AppProgressView(show: model.bindings.loading.wrappedValue)
        }
        .onAppear{
            model.getFarmData(userId: SingletonUtil.shared.userUid)
        }
        .navigationBarHidden(false)
        .toolbar {
            ToolbarView()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func cardHome(imagePath: String, title: String) -> some View {
        let size = UIScreen.main.bounds.size.width
        return VStack{
            Image(imagePath)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size*0.3, height: size*0.3)
            Text(title)
                .font(.system(size: 30))
                .padding(.bottom, 8)
                .foregroundColor(.white)
        }
        .frame(width: size*0.45, height: size*0.45)
        .background(ColorUtil.getPrimaryColor(farmData: model.state.farmData))
        .cornerRadius(12, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
