//
//  LoginViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

final class LoginViewModel: ObservableObject {
    @Published private(set) var state: LoginViewState
    private let auth = Auth.auth()
    private let storage = Storage.storage()
    private let repository = Repository()

    var bindings: (
            email: Binding<String>,
            password: Binding<String>,
            farmName: Binding<String>,
            isSuccess: Binding<Bool>,
            isShowAlertError: Binding<Bool>,
            isLoading: Binding<Bool>,
            messageError: Binding<String>,
            isPassSecure: Binding<Bool>,
            showBottomSheetCreateUser: Binding<Bool>,
            colorSelected: Binding<Color>,
            callSheetImage: Binding<Bool>,
            imageLogoSelected: Binding<UIImage?>
        ) {
            (
                email: Binding(to: \.state.email, on: self),
                password: Binding(to: \.state.password, on: self),
                farmName: Binding(to: \.state.farmName, on: self),
                isSuccess: Binding(to: \.state.isSuccess, on: self),
                isShowAlertError: Binding(to: \.state.isShowAlertError, on: self),
                isLoading: Binding(to: \.state.isLoading, on: self),
                messageError: Binding(to: \.state.messageError, on: self),
                isPassSecure: Binding(to: \.state.isPassSecure, on: self),
                showBottomSheetCreateUser: Binding(to: \.state.showBottomSheetCreateUser, on: self),
                colorSelected: Binding(to: \.state.colorSelected, on: self),
                callSheetImage: Binding(to: \.state.callSheetImage, on: self),
                imageLogoSelected: Binding(to: \.state.imageLogoSelected, on: self)
            )
        }

        init(
            initialState: LoginViewState = .init()
        ) {
            state = initialState
        }
    
    
    func login(){
        self.state.isLoading = true
        DispatchQueue.main.async {
            self.auth.signIn(withEmail: self.state.email, password: self.state.password){ result, error in
                self.state.isLoading = false
                guard result != nil, error == nil else {
                    self.state.isShowAlertError = true
                    return
                }
                SingletonUtil.shared.userUid = result?.user.uid ?? ""
                self.state.isSuccess = true
            }
        }
        
    }
    
    func createUser(){
        self.state.isLoading = true
        DispatchQueue.main.async {
            self.auth.createUser(withEmail: self.state.email, password: self.state.password){ result, error in
                guard result != nil, error == nil else {
                    return
                }
                SingletonUtil.shared.userUid = result?.user.uid ?? ""
                self.uploadLogo(){ url in
                    self.repository.addFarmData(farmData: FarmData(farmName: self.state.farmName, imageLogoUrl: url, primaryColor: self.state.colorSelected.toHex() ?? ""), userId: result?.user.uid ?? ""){
                        self.state.isLoading = false
                        self.state.showBottomSheetCreateUser = false
                        self.state.isSuccess = true
                    }
                }
            }
        }
    }

    func uploadLogo(complete: @escaping (String) -> Void){
        DispatchQueue.main.async {
            let childRef = self.storage.reference().child("logos/" + SingletonUtil.shared.userUid + ".png")
            if let data = self.state.imageLogoSelected?.pngData() {
                _ = childRef.putData(data, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        complete("")
                        print(error ?? "")
                        return
                    }
                    _ = metadata.size
                    childRef.downloadURL { (url, error) in
                        guard url != nil else {
                            complete("")
                            print(error ?? "")
                            return
                        }
                        complete(url?.description ?? "")
                    }
                }
            }
            
        }
    }
    
    func showBottomSheetCreateUser(){
        self.state.showBottomSheetCreateUser.toggle()
    }
    
    func callSheetImage(){
        self.state.callSheetImage.toggle()
    }
    
    func storeSessionToken(sessionToken: String){
        let defaults = UserDefaults.standard
        defaults.set(sessionToken, forKey: "sessionToken")
    }
}
