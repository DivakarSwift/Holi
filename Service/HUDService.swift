//
//  HUDService.swift
//  Holi
//
//  Created by Кирилл on 6/29/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
import SVProgressHUD

struct HUDService {
    
    static func setup() {
        
    }
    
    static func show() {
        SVProgressHUD.show()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    static func showWithOutIgnoringInteractionEvents() {
        SVProgressHUD.show()
    }
    
    static func showInfo(with message: String) {
        SVProgressHUD.showInfo(withStatus: message)
        SVProgressHUD.setMaximumDismissTimeInterval(2)
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    static func dismiss() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    static func showError(withStatus status: String = "Error") {
        SVProgressHUD.showError(withStatus: status)
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    static func showSuccess(message: String?){
        SVProgressHUD.showSuccess(withStatus: message)
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
