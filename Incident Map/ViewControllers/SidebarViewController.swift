//
//  SidebarViewController.swift
//  Incident Map
//
//  Created by diondre lewis on 7/12/19.
//  Copyright © 2019 Diondre Lewis. All rights reserved.
//

import Cocoa

class SidebarViewController: NSViewController {
    
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var textView: NSTextView!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    var isLoading = false {
        didSet {
            titleTextField.isHidden = isLoading
            textView.isHidden = isLoading
            progressIndicator.isHidden = !isLoading
            if isLoading {
                progressIndicator.startAnimation(self)
            } else {
                progressIndicator.stopAnimation(self)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.isHidden = true
        textView.isHidden = true
        progressIndicator.isHidden = true
    }
    
    @IBAction func openPanel(_ button: NSButton) {
        (parent as! SplitViewController).openPanel()
    }
    
    override var representedObject: Any? {
        didSet {
            if let (cad, timeMachineResult) = representedObject as? (Cad, DSTimeMachineResult) {
                isLoading = false
                
                guard let timeInterval = cad.description.eventOpenedTimeInterval else { return }
                let date = Date(timeIntervalSince1970: timeInterval)
                let hour = Calendar.current.component(.hour, from: date)
                let dataForHour = timeMachineResult.hourly?.data[hour]
                
                textView.string = """
                Incident number: \(cad.description.incident_number)
                
                Type: \(cad.description.type)
                Sub-type: \(cad.description.subtype)
                
                Conditions: \(dataForHour?.summary ?? "-")
                Temperature: \(dataForHour?.temperature ?? 0)°
                Wind: \(dataForHour?.windSpeed ?? 0) MPH \(dataForHour?.windBearingString ?? "-")
                
                
                Comments
                \(cad.description.comments)
                """
            } else {
                isLoading = true
            }
        }
    }
}
