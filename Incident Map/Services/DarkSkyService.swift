//
//  DarkSkyService.swift
//  Incident Map
//
//  Created by diondre lewis on 7/12/19.
//  Copyright © 2019 Diondre Lewis. All rights reserved.
//

import Foundation

class DarkSkyService {
    
    static let instance = DarkSkyService()
    
    static let key = "2c975102356d9f3f794cd420a8fa6117"
    static func timeMachineURl(_ latitude: Double, _ longitude: Double, _ time: TimeInterval) -> String {
        return "https://api.darksky.net/forecast/\(key)/\(latitude),\(longitude),\(Int(time))"
    }
    
    private init() {}
    
    func getTimeMachineResult(_ latitude: Double, _ longitude: Double, time: TimeInterval, _ handler: @escaping (DSTimeMachineResult?) -> Void) {
        // url
        let string = DarkSkyService.timeMachineURl(latitude, longitude, time)
        guard let url = URL(string: string) else {
            print("Couldn't create time machine url")
            DispatchQueue.main.async { handler(nil) }
            return
        }
        
        // data task
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // check for error
            guard let data = data, error == nil else {
                print("Error getting weather data", error!)
                DispatchQueue.main.async { handler(nil) }
                return
            }
            
            // parse
            let timeMachineResult: DSTimeMachineResult
            do {
                timeMachineResult = try JSONDecoder().decode(DSTimeMachineResult.self, from: data)
            } catch {
                print("Error decoding weather data", error)
                DispatchQueue.main.async { handler(nil) }
                return
            }
            
            // success
            DispatchQueue.main.async { handler(timeMachineResult) }
        }
        
        // start task
        task.resume()
    }
}
