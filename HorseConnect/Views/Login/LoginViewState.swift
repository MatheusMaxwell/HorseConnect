//
//  LoginViewState.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 10/11/22.
//

import SwiftUI

struct LoginViewState {
    var email = ""
    var password = ""
    var farmName = ""
    var isLoading = false
    var isSuccess = false
    var isShowAlertError = false
    var messageError = ""
    var isPassSecure = true
    var showBottomSheetCreateUser = false
    var colorSelected = Color.primaryColor
    var callSheetImage = false
    var imageLogoSelected: UIImage? = nil
}

extension LoginViewState {
    var canSubmit: Bool {
        email.isEmpty == false && password.isEmpty == false && isLoading == false
    }
}
