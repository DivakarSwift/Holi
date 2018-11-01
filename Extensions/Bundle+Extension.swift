//
//  BundleExtension.swift
//  Holi
//
//  Created by Кирилл on 7/2/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "v. \(releaseVersionNumber ?? "1.0.0") \"\(buildVersionNumber ?? "0")\""
    }
}
