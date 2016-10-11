//
//  PLTimelineRulerView.swift
//  PLTimelineView
//
//  Created by Patrick Lin on 11/10/2016.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

import UIKit

@IBDesignable class PLTimelineRulerView: UIView {
    
    var unit_hour_width: CGFloat = 60
    
    var unit_hour_height: CGFloat = 30
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        UIColor.clear.setFill()
        
        UIRectFill(rect)
        
        UIColor.lightGray.setFill()
        
        let unit_gap_height = CGFloat(20)
        
        let unit_minute_width = unit_hour_width / 6
        
        let unit_minute_height = CGFloat(unit_hour_height / 2)
        
        let unit_page = rect.width / 3
        
        for i in 0...2 {
            
            for hour in 0...23 {
                
                let hour_x = CGFloat(hour) * unit_hour_width + (CGFloat(i) * unit_page)
                
                let hour_y = rect.size.height - unit_hour_height
                
                UIRectFill(CGRect(x: hour_x, y: hour_y - unit_gap_height, width: 1, height: unit_hour_height))
                
                for minute in 1..<6 {
                    
                    let minute_x = CGFloat(minute) * unit_minute_width
                    
                    let minute_y =  rect.size.height - unit_minute_height
                    
                    UIRectFill(CGRect(x: hour_x + minute_x, y: minute_y - unit_gap_height, width: 1, height: unit_minute_height))
                    
                }
                
                let textFontAttributes = [
                    NSFontAttributeName: UIFont.systemFont(ofSize: 12),
                    NSForegroundColorAttributeName: UIColor.lightGray,
                    NSParagraphStyleAttributeName: NSParagraphStyle.default
                ]
                
                let text_width = CGFloat(34)
                
                let text_height = CGFloat(12)
                
                let text_x = hour_x - (text_width / 2)
                
                let text_y = rect.size.height - 17
                
                (String(format: "%02d:00", hour) as NSString).draw(in: CGRect(x: text_x, y: text_y, width: text_width, height: text_height), withAttributes: textFontAttributes)
                
            }
            
        }
        
        UIRectFill(CGRect(x: 0, y: 0, width: rect.size.width, height: 0.5))
        
        UIRectFill(CGRect(x: 0, y: rect.size.height - 20, width: rect.size.width, height: 0.5))
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        self.isOpaque = false
        
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
