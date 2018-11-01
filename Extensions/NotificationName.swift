//
//  NotificationName.swift
//  Holi
//
//  Created by Кирилл on 21.03.2018.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import Foundation

fileprivate let loginNotificationKey = "com.letsswap.login"
fileprivate let chatMessagesCount = "com.letsswap.messagesCount"

extension Notification.Name {
    
    static let userLoginNotification = Notification.Name(rawValue: loginNotificationKey)
    static let chatMessagesCountNotification = Notification.Name(rawValue: chatMessagesCount)
}
