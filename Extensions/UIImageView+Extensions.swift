//
//  UIImageView+Extensions.swift
//  Holi
//
//  Created by Кирилл on 10/17/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation
extension UIImageView {
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
