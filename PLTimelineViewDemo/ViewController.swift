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
    
    // MARK: Timeline Methods
    
    func timeline(_ timeline: PLTimelineView, didScrollTo date: Date) {
        
        print("\(date.description(with: Locale.current))")
        
    }
    
    // MARK: Init Methods

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }

}

