//
//  LoginView.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject private var model: LoginViewModel
    private let passTitle = "Senha"
    
    init(model: LoginViewModel) {
        self.model = model
    }
    
    var body: some View {
        ZStack {
            Color.primaryColor.ignoresSafeArea(.all)
            VStack{
                Spacer()
                Image("HorseConnect")
                    .aspectRatio(contentMode: .fit)
                Spacer()
                VStack{
                    Spacer()
                    TextField("E-mail", text: model.bindings.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .overlay(
                            TextFieldOverlay().shape()
                        )
                
                    passwordField
                    Text("Esqueceu a senha?")
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Spacer()
                    Button(action: model.login) {
                        Text("ENTRAR")
                            .textPrimaryButtonStyle(isEnabled: model.state.canSubmit)
                    }
                    .primaryButtonStyle(isEnabled: model.state.canSubmit)
                    Text("Cadastre-se")
                        .font(.system(size: 14))
                        .underline()
                        .padding()
                        .onTapGesture {
                            model.showBottomSheetCreateUser()
                        }
                    Spacer()
                }
                .padding()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 350,
                    alignment: .topLeading
                )
                .background(.white)
                .cornerRadius(12, corners: [.topLeft, .topRight])
            }
            .padding(.bottom, -40)
            NavigationLink(
                destination: HomeView(),
                isActive: model.bindings.isSuccess,
                label: {}
            )
            AppProgressView(
                text: "Entrando...",
                show: model.bindings.isLoading.wrappedValue)
        }
        .alert(isPresented: model.bindings.isShowAlertError){
            Alert(
                title: Text("Erro"),
                message: Text("Verifique seu email e senha e tente novamente."),
                dismissButton: .destructive(Text("Ok"))
            )
        }
        .sheet(isPresented: model.bindings.showBottomSheetCreateUser){
            ZStack{
                VStack{
                    Spacer().frame(height: 40)
                    Text("Dados para login")
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("E-mail", text: model.bindings.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .overlay(
                            TextFieldOverlay().shape()
                        )
                
                    passwordField
                        .padding(.bottom, 20)
                    Text("Haras/Fazenda")
                        .foregroundColor(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Nome do Haras/Fazenda", text: model.bindings.farmName)
                        .keyboardType(.default)
                        .padding()
                        .overlay(
                            TextFieldOverlay().shape()
                        )
                    ColorPicker("Cor principal", selection: model.bindings.colorSelected)
                        .padding(.top, 20)
                    HStack{
                        Image(uiImage: model.bindings.imageLogoSelected.wrappedValue)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Rectangle())
                            .cornerRadius(10)
                        
                        Button(action: model.callSheetImage) {
                            Text("Inserir logo")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                        }
                        
                    }
                    .sheet(isPresented: model.bindings.callSheetImage){
                        ImagePicker(selectedImage: model.bindings.imageLogoSelected)
                    }
                    .padding(.top, 20)
                    Spacer()
                    Button(action: model.createUser) {
                        Text("CADASTRAR")
                            .textPrimaryButtonStyle(isEnabled: model.state.canSubmit)
                    }
                    .primaryButtonStyle(isEnabled: model.state.canSubmit)
                    
                }
                .padding()
                AppProgressView(
                    text: "Cadastrando...",
                    show: model.bindings.isLoading.wrappedValue)
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var passwordField: some View {
        HStack{
            Group{
                if model.state.isPassSecure {
                    SecureField(passTitle, text: model.bindings.password)
                }else{
                    TextField(passTitle, text: model.bindings.password)
                }
            }
            .padding()
            .overlay{
                TextFieldOverlay().shape()
                HStack{
                    Button(action: {
                        model.bindings.isPassSecure.wrappedValue.toggle()
                    }, label: {
                        Image(systemName:!model.state.isPassSecure ? "eye.slash" : "eye" )
                            .foregroundColor(.gray)
                    })
                }
                .padding(.trailing, 10)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .animation(.easeInOut(duration: 0.2), value: model.state.isPassSecure)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(model: .init(initialState: .init()))
    }
}
