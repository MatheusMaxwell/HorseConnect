//
//  HomeViewState.swift
//  HorseConnect
//
//  Created by Matheus Maxwell Meireles on 11/11/22.
//

import UIKit
import SwiftUI

struct HomeViewState {
    var farmData: FarmData? = nil
    var loading = false
    var showError = false
    var messageError = ""
    var showSheetEdit = false
    var editTypeEnum = EditType.LOGO
    var selectedImage = UIImage()
    var showGalleryToSelectImage = false
    var farmName = ""
    var colorSelected = Color.primaryColor
    var newPassword = ""
    var newPasswordRepeat = ""
    var showAlertErrorPasswordEdit = false
    var errorPasswordEditMessage = ""
}
