//
//  PLTimelineLoupeView.swift
//  PLTimelineView
//
//  Created by Patrick Lin on 10/11/2016.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

import UIKit

@IBDesignable class PLTimelineLoupeView: UIView {

    let unit_loupe_image_width: CGFloat = 244
    
    let unit_loupe_image_height: CGFloat = 70
    
    let unit_second_width: CGFloat = 10
    
    let unit_second_height: CGFloat = 15
    
    let unit_ten_second_height: CGFloat = 22
    
    let unit_minute_height: CGFloat = 30
    
    let unit_hour_height: CGFloat = 40
    
    let unit_gap_height: CGFloat = 20
    
    var loupeImageView: UIImageView!
    
    var loupeMaskLayer: CAShapeLayer!
    
    var currentDate: Date?
    
    // MARK: Public Methods
    
    func displayInLoupe(date: Date) {
        
        self.currentDate = date
        
        self.setNeedsDisplay()
        
    }
    
    // MARK: Internal Methods
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.layoutIfNeeded()
        
        if self.loupeImageView == nil {
            
            let bundle = Bundle(for: PLTimelineLoupeView.self)
            
            let image = UIImage(named: "loupe.png", in: bundle, compatibleWith: nil)
            
            self.loupeImageView = UIImageView(image: image)
            
            self.addSubview(self.loupeImageView)
            
        }

        if self.loupeMaskLayer == nil {
            
            self.loupeMaskLayer = CAShapeLayer()
            
            self.layer.mask = self.loupeMaskLayer
            
        }
        
        let x = (self.bounds.size.width / 2) - (unit_loupe_image_width / 2)
        
        let y = (self.bounds.size.height / 2) - (unit_loupe_image_height / 2)
        
        self.loupeImageView.frame = CGRect(x: x, y: y, width: unit_loupe_image_width, height: unit_loupe_image_height)
        
        let roundedRect = self.loupeImageView.frame.insetBy(dx: 2, dy: 2).offsetBy(dx: 0, dy: -1)
        
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: 10)
        
        path.lineWidth = 0
        
        self.loupeMaskLayer.path = path.cgPath
        
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        UIColor.white.setFill()
        
        UIRectFill(rect)
        
        if self.currentDate == nil { return }
        
        UIColor.lightGray.setFill()
        
        let based_x = rect.size.width / 2
        
        for i in -15 ... 15 {
            
            let date = self.currentDate!.addingTimeInterval(TimeInterval(i))
            
            self.drawTimeUnit(date: date, based: based_x, offset: CGFloat(i) * 10)
            
        }

        UIRectFill(CGRect(x: 0, y: 0, width: rect.size.width, height: 0.5))
        
        UIRectFill(CGRect(x: 0, y: rect.size.height - 20, width: rect.size.width, height: 0.5))
        
    }
    
    func drawTimeUnit(date: Date, based: CGFloat, offset: CGFloat) {
        
        let hour = CGFloat(Calendar.current.component(.hour, from: date))
        
        let minute = CGFloat(Calendar.current.component(.minute, from: date))
        
        let second = CGFloat(Calendar.current.component(.second, from: date))
        
        let nanosecond = CGFloat(Calendar.current.component(.nanosecond, from: date))
        
        let second_offset = (nanosecond / 100000000)
        
        var x: CGFloat = 0
        
        var y: CGFloat = 0
        
        var width: CGFloat = 0
        
        var height: CGFloat = 0
        
        if second != 0 {
            
            width = 1
            
            height = (second.truncatingRemainder(dividingBy: 10) == 0) ? unit_ten_second_height : unit_second_height
            
            x = based + offset - second_offset
            
            y = self.bounds.size.height - height - unit_gap_height
            
        }
            
        else if minute != 0 {
            
            width = 1
            
            height = unit_minute_height
            
            x = based + offset - second_offset
            
            y = self.bounds.size.height - height - unit_gap_height
            
        }
            
        else if hour != 0 {
            
            width = 1
            
            height = unit_hour_height
            
            x = based + offset - second_offset
            
            y = self.bounds.size.height - height - unit_gap_height
            
        }
        
        UIRectFill(CGRect(x: x, y: y, width: width, height: height))
        
        if second.truncatingRemainder(dividingBy: 10) != 0 {
            
            return
        
        }
        
        let textFontAttributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 12),
            NSForegroundColorAttributeName: UIColor.lightGray,
            NSParagraphStyleAttributeName: NSParagraphStyle.default
        ]
        
        let text_width = CGFloat(54)
        
        let text_height = CGFloat(12)
        
        let text_x = x - (text_width / 2)
        
        let text_y = self.bounds.size.height - 17
        
        let text_rect = CGRect(x: text_x, y: text_y, width: text_width, height: text_height)
        
        (String(format: "%02d:%02d:%02d", Int(hour), Int(minute), Int(second)) as NSString).draw(in: text_rect, withAttributes: textFontAttributes)
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        self.isOpaque = false
        
        self.isUserInteractionEnabled = false
        
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
