//
//  HomeViewModel.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 11/11/22.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth

final class HomeViewModel: ObservableObject{
    
    @Published private(set) var state: HomeViewState
    private let repository = Repository()
    private let storage = Storage.storage()
    private let auth = Auth.auth()
    
    init(
        initialState: HomeViewState = .init()
    ) {
        state = initialState
    }
    
    var bindings: (
            showError: Binding<Bool>,
            loading: Binding<Bool>,
            showSheetEdit: Binding<Bool>,
            selectedImage: Binding<UIImage?>,
            showGalleryToSelectImage: Binding<Bool>,
            farmName: Binding<String>,
            colorSelected: Binding<Color>,
            newPassword: Binding<String>,
            newPasswordRepeat: Binding<String>,
            showAlertErrorPasswordEdit: Binding<Bool>
        ) {
            (
                showError: Binding(to: \.state.showError, on: self),
                loading: Binding(to: \.state.loading, on: self),
                showSheetEdit: Binding(to: \.state.showSheetEdit, on: self),
                selectedImage: Binding(to: \.state.selectedImage, on: self),
                showGalleryToSelectImage: Binding(to: \.state.showGalleryToSelectImage, on: self),
                farmName: Binding(to: \.state.farmName, on: self),
                colorSelected: Binding(to: \.state.colorSelected, on: self),
                newPassword: Binding(to: \.state.newPassword, on: self),
                newPasswordRepeat: Binding(to: \.state.newPasswordRepeat, on: self),
                showAlertErrorPasswordEdit: Binding(to: \.state.showAlertErrorPasswordEdit, on: self)
            )
        }
    
    func getFarmData(userId: String){
        state.loading = true
        DispatchQueue.main.async {
            self.repository.getFarmData(userId: userId){ farmData in
                if farmData != nil {
                    SingletonUtil.shared.farmData = farmData
                    self.state.farmName = farmData?.farmName ?? ""
                    self.state.colorSelected = Color(hex: farmData?.primaryColor ?? "") ?? Color.primaryColor
                    self.state.farmData = farmData
                }
                else{
                    self.state.farmData = farmData
                    self.state.showError = true
                    self.state.messageError = "Ocorreu um erro ao tentar recuperar os dados da sua propriedade."
                }
                self.state.loading = false
            }
        }
    }
    
    func showBottomSheetToEdit(editType: EditType){
        state.editTypeEnum = editType
        state.showSheetEdit = true
    }
    
    func uploadLogo(){
        self.state.loading = true
        DispatchQueue.main.async {
            let childRef = self.storage.reference().child("logos/" + SingletonUtil.shared.userUid + ".png")
            if let data = self.state.selectedImage?.pngData() {
                _ = childRef.putData(data, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        self.state.loading = false
                        return
                    }
                    _ = metadata.size
                    childRef.downloadURL { (url, error) in
                        guard url != nil else {
                            self.state.loading = false
                            return
                        }
                        self.state.farmData?.imageLogoUrl = url?.description ?? ""
                        if let farmData = self.state.farmData {
                            self.updateFarmData(farmData: farmData)
                        }
                    }
                }
            }
            
        }
    }
    
    func updateFarmName(){
        self.state.loading = true
        DispatchQueue.main.async {
            self.state.farmData?.farmName = self.state.farmName
            if let farmData = self.state.farmData {
                self.updateFarmData(farmData: farmData)
            }
            
        }
    }
    
    func updateColor(){
        self.state.loading = true
        DispatchQueue.main.async {
            if let color = self.state.colorSelected.toHex() {
                self.state.farmData?.primaryColor = color
            }
            if let farmData = self.state.farmData {
                self.updateFarmData(farmData: farmData)
            }
        }
    }
    
    private func updateFarmData(farmData: FarmData) {
        self.repository.addFarmData(farmData: farmData, userId: SingletonUtil.shared.userUid){
            self.state.loading = false
            self.state.showSheetEdit = false
        }
    }
    
    func updatePassword(){
        self.state.loading = true
        if(state.newPassword == state.newPasswordRepeat){
            if(state.newPassword.count < 6){
                self.state.loading = false
                self.state.errorPasswordEditMessage = "A senha deve ter mais que 6 dígitos."
                self.state.showAlertErrorPasswordEdit = true
            }
            else{
                DispatchQueue.main.async {
                    self.auth.currentUser?.updatePassword(to: self.state.newPassword){ error in
                        if (error as NSError?) != nil {
                            self.state.loading = false
                            self.state.errorPasswordEditMessage = "Ocorreu um erro ao tentar alterar sua senha. Tente novamente mais tarde."
                            self.state.showAlertErrorPasswordEdit = true
                        }
                        else{
                            self.state.loading = false
                            self.state.showSheetEdit = false
                        }
                    }
                }
            }
        }
        else{
            self.state.loading = false
            self.state.errorPasswordEditMessage = "As senhas digitadas não são iguais."
            self.state.showAlertErrorPasswordEdit = true
        }
    }
}

enum EditType {
    case LOGO, FARM_NAME, COLOR, PASSWORD
}
