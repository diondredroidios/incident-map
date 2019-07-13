//
//  DSResult.swift
//  Incident Map
//
//  Created by diondre lewis on 7/12/19.
//  Copyright © 2019 Diondre Lewis. All rights reserved.
//

import Foundation

// MARK: DarkSky Models

struct DSTimeMachineResult: Codable {
    var hourly: DSDataBlock?
}

struct DSDataBlock: Codable {
    var summary: String?
    var data: [DSDataPoint]
}

struct DSDataPoint: Codable {
    var summary: String?
    var temperature: Double?
    var humidity: Double?
    var windSpeed: Double?
    var windBearing: Int?
    
    var windBearingString: String? {
        get {
            guard let windBearing = windBearing else {
                return nil
            }
            
            let windBearingDouble = Double(windBearing)
            let fraction = (windBearingDouble - 22.5) / 360.0
            let number = fraction * 8
            let index = number.rounded(.up)
            let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"]
            let string = directions[Int(index)]
            
            return string
        }
    }
}
