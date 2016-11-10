//
//  PLTimelineContentView.swift
//  PLTimelineView
//
//  Created by Patrick Lin on 11/10/2016.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

import UIKit

@IBDesignable class PLTimelineContentView: UIScrollView {

    var rulerView: PLTimelineRulerView!
    
    func updateRuler() {
        
        self.layoutIfNeeded()
        
        self.contentSize = CGSize(width: self.rulerView.unit_hour_width * 24 * 3, height: self.bounds.size.height)
        
        self.rulerView.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.updateRuler()
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        self.showsVerticalScrollIndicator = false
        
        self.showsHorizontalScrollIndicator = false
        
        self.isOpaque = false
        
        self.rulerView = PLTimelineRulerView()
        
        self.addSubview(self.rulerView)
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }

}
