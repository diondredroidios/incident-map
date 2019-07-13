//
//  Cad.swift
//  Incident Map
//
//  Created by diondre lewis on 7/12/19.
//  Copyright © 2019 Diondre Lewis. All rights reserved.
//

import Foundation

struct Cad: Codable {
    var address: CadAddress
    var description: CadDescription
}

struct CadAddress: Codable {
    var latitude: Double
    var longitude: Double
}

struct CadDescription: Codable {
    var type: String
    var subtype: String
    var incident_number: String
    var event_opened: String
    var comments: String
    
    var eventOpenedTimeInterval: TimeInterval? {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            guard let date = formatter.date(from: event_opened) else {
                return nil
            }
            let timestamp = date.timeIntervalSince1970
            return timestamp
        }
    }
}
