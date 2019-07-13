//
//  ViewController.swift
//  Incident Map
//
//  Created by diondre lewis on 7/12/19.
//  Copyright © 2019 Diondre Lewis. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {

    override func viewDidAppear() {
        super.viewDidAppear()
        
        openPanel()
    }
    
    func openPanel() {
        let panel = NSOpenPanel()
        guard let window = view.window else { return }
        panel.beginSheetModal(for: window) { response in
            switch response {
                
            case NSApplication.ModalResponse.OK:
                let url = panel.urls[0]
                self.open(url)
                
            default:
                break
            }
        }
    }
    
    func open(_ url: URL) {
        guard let data = try? NSData(contentsOfFile: url.relativePath) as Data else { return }
        guard let cad = try? JSONDecoder().decode(Cad.self, from: data) else { return }
        guard let timestamp = cad.description.eventOpenedTimeInterval else { return }
        
        // get weather data
        self.representedObject = nil // show indicator
        DarkSkyService.instance.getTimeMachineResult(cad.address.latitude, cad.address.longitude, time: timestamp) { result in
            // error?
            guard let result = result else {
                return
            }
            
            // done
            self.representedObject = (cad, result)
        }
    }

    override var representedObject: Any? {
        didSet {
            splitViewItems.forEach {
                $0.viewController.representedObject = representedObject
            }
        }
    }
}
