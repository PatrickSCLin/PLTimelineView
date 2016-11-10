//
//  ViewController.swift
//  PLTimelineViewDemo
//
//  Created by Patrick Lin on 11/10/2016.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

import UIKit
import PLTimelineView

class ViewController: UIViewController, PLTimelineDelegate {
    
    @IBOutlet var timestampLabel: UILabel!
    
    // MARK: Timeline Methods
    
    func timeline(_ timeline: PLTimelineView, didScrollTo date: Date) {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss.SSS"
        
        self.timestampLabel.text = formatter.string(from: date)
        
        self.timestampLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: UIFontWeightRegular)
        
    }
    
    // MARK: Init Methods

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }

}

