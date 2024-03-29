//
//  HomeView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI
import CachedAsyncImage

struct HomeView: View {
    @StateObject private var model = HomeViewModel()
    @State var navigateToAnimalsHome = false
    @State var navigateToBreedingHome = false
    private var monitor = NetworkMonitor()
    
    var body: some View {
        ZStack{
            ColorUtil
                .getPrimaryColor(farmData: model.state.farmData)
                .ignoresSafeArea(.all)
            
            VStack{
                Spacer()
                
                if model.state.farmData != nil && !model.state.farmData!.imageLogoUrl.isEmpty {
                    CachedAsyncImage(
                        url: URL(string: model.state.farmData!.imageLogoUrl),
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        },
                        placeholder: {
                            if monitor.isConnected {
                                ProgressView()
                            }
                            else{
                                Text(model.state.farmData!.farmName)
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            
                        }
                    )
                    .padding(.top, 20)
                    .frame(height: 180)
                }
                Text(model.state.farmData?.farmName ?? "")
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
                    .isHidden(model.state.farmData?.imageLogoUrl != "")
                Spacer()
                VStack{
                    TabView{
                        homeViewCards
                            .tabItem{
                                Label("Início",systemImage: "house.fill")
                            }
                        settingsView
                            .tabItem{
                                Label("Configurações",systemImage: "gearshape.fill")
                            }
                    }
                    .accentColor(ColorUtil.getPrimaryColor(farmData: model.state.farmData))
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(12, corners: [.topLeft, .topRight])

            }
            .padding(.bottom, -40)
            AppProgressView(show: model.bindings.loading.wrappedValue)
            NavigationLink(
                destination: AnimalsHomeView(),
                isActive: $navigateToAnimalsHome,
                label: {}
            )
            NavigationLink(
                destination: BreedingHomeView(),
                isActive: $navigateToBreedingHome,
                label: {}
            )
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
    
    var homeViewCards: some View {
        List {
            CardViewRow(imagePath: "HorseCardHome", title: "Plantel", farmData: model.state.farmData){
                navigateToAnimalsHome.toggle()
            }
            CardViewRow(imagePath: "StationCardHome", title: "Estação", farmData: model.state.farmData){
                navigateToBreedingHome.toggle()
            }

            CardViewRow(imagePath: "VaccineCardHome", title: "Vacinação", farmData: model.state.farmData){
            }
            CardViewRow(imagePath: "FinanceCardHome", title: "Financeiro", farmData: model.state.farmData){
            
            }
        }
        .listStyle(.plain)
    }
    
    var settingsView: some View {
        VStack(){
            Text(model.state.farmData?.farmName ?? "")
                .font(.system(size: 20))
                .foregroundColor(.black.opacity(0.6))
                .padding()
            List{
                Text("Alterar logo")
                    .onTapGesture {
                        model.showBottomSheetToEdit(editType: EditType.LOGO)
                    }
                Text("Editar nome da propriedade")
                    .onTapGesture {
                        model.showBottomSheetToEdit(editType: EditType.FARM_NAME)
                    }
                Text("Alterar cor")
                    .onTapGesture {
                        model.showBottomSheetToEdit(editType: EditType.COLOR)
                    }
                Text("Criar nova senha")
                    .onTapGesture {
                        model.showBottomSheetToEdit(editType: EditType.PASSWORD)
                    }
            }
            .sheet(isPresented: model.bindings.showSheetEdit){
                switch(model.state.editTypeEnum){
                    case EditType.LOGO: editLogo
                    case EditType.FARM_NAME: editFarmName
                    case EditType.COLOR: editColor
                    case EditType.PASSWORD: editPassword
                }
            }
        }
        
    }
    
    var editLogo: some View{
        ZStack {
            VStack{
                image
                .background(Color.gray)
                .cornerRadius(12, corners: [.allCorners])
                .padding(.top, 20)
                .frame(width: UIScreen.main.bounds.width*0.8,height: 400)
                
                Button(action: {
                    model.bindings.showGalleryToSelectImage.wrappedValue.toggle()
                }, label: {
                    Text("Editar")
                })
                .padding(.top, 30)
                
                Spacer()
                
                Button(action: model.uploadLogo) {
                    Text("SALVAR")
                        .textPrimaryButtonStyle(isEnabled: true)
                }
                .primaryButtonStyle(isEnabled: true, color: ColorUtil.getPrimaryColor(farmData: model.state.farmData))
                .padding()
            }
            .sheet(isPresented: model.bindings.showGalleryToSelectImage){
                ImagePicker(selectedImage: model.bindings.selectedImage)
            }
            
            AppProgressView(show: model.state.loading)
        }
        
    }
    
    @ViewBuilder
    var image: some View {
        if model.bindings.selectedImage.wrappedValue?.pngData() != nil {
            Image(uiImage: model.bindings.selectedImage.wrappedValue!)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(contentMode: .fit)
        }
        else{
            CachedImageView(
                imageUrl: model.state.farmData!.imageLogoUrl,
                width: UIScreen.main.bounds.size.width*0.8,
                height: UIScreen.main.bounds.size.height*0.3
            )
        }
    }
    
    var editFarmName: some View{
        ZStack{
            VStack{
                TextField("Nome Haras/Fazenda", text: model.bindings.farmName)
                    .padding()
                    .overlay(
                        TextFieldOverlay().shape()
                    )
                Spacer()
                Button(action: model.updateFarmName) {
                    Text("SALVAR")
                        .textPrimaryButtonStyle(isEnabled: true)
                }
                .primaryButtonStyle(isEnabled: true, color: ColorUtil.getPrimaryColor(farmData: model.state.farmData))
            }
            .padding()
            AppProgressView(show: model.state.loading)
        }
        
    }
    
    var editColor: some View{
        ZStack{
            VStack{
                ColorPicker("Cor principal", selection: model.bindings.colorSelected)
                    .padding(.top, 20)
                Spacer()
                Button(action: model.updateColor) {
                    Text("SALVAR")
                        .textPrimaryButtonStyle(isEnabled: true)
                }
                .primaryButtonStyle(isEnabled: true, color: ColorUtil.getPrimaryColor(farmData: model.state.farmData))
            }
            .padding()
            AppProgressView(show: model.state.loading)
        }
    }
    
    var editPassword: some View{
        ZStack{
            VStack{
                SecureField("Senha", text: model.bindings.newPassword)
                    .padding()
                    .overlay(
                        TextFieldOverlay().shape()
                    )
                SecureField("Repita a senha", text: model.bindings.newPasswordRepeat)
                    .padding()
                    .overlay(
                        TextFieldOverlay().shape()
                    )
                Spacer()
                Button(action: model.updatePassword) {
                    Text("SALVAR")
                        .textPrimaryButtonStyle(isEnabled: true)
                }
                .primaryButtonStyle(isEnabled: true, color: ColorUtil.getPrimaryColor(farmData: model.state.farmData))
            }
            .alert(isPresented: model.bindings.showAlertErrorPasswordEdit){
                Alert(
                    title: Text("Erro"),
                    message: Text(model.state.errorPasswordEditMessage),
                    dismissButton: .destructive(Text("Ok"))
                )
            }
            .padding()
            AppProgressView(show: model.state.loading)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
