//
//  CallItem.swift
//  SberTeleCom
//
//  Created by Mikhail Seregin on 18.12.2018.
//  Copyright © 2018 Mikhail Seregin. All rights reserved.
//

import Foundation

struct CallItem: Codable {
    var recordId: Int
    var extTrackingId: String
    var providerId: String
    var groupId: String
    var userId: String
    var phone: String
    var direction: String
//    var date: DateInterval?
    var duration: Int
    var fileSize: Int
}

protocol CallItemViewModel {
    var id: String { get }
    var phone: String { get }
    var manager: String { get }
    var type: String { get }
}

extension CallItem: CallItemViewModel {
    var id: String {
        return String(recordId)
    }
    
    var manager: String {
        return providerId
    }
    
    var type: String {
        if direction == "INBOUND" {
            return "Входящий"
        } else {
            return "Исходящий"
        }
    }
}
