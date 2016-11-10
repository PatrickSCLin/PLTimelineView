//
//  PLTimelineLoupeView.swift
//  PLTimelineView
//
//  Created by Patrick Lin on 10/11/2016.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

import UIKit

@IBDesignable class PLTimelineLoupeView: UIView {

    let unit_second_width: CGFloat = 10
    
    let unit_second_height: CGFloat = 15
    
    let unit_minute_height: CGFloat = 30
    
    let unit_hour_height: CGFloat = 50
    
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
        
        if self.loupeImageView == nil {
            
            self.loupeImageView = UIImageView(image: UIImage(named: "loupe.png"))
            
            self.addSubview(self.loupeImageView)
            
        }
        
        if self.loupeMaskLayer == nil {
            
            self.loupeMaskLayer = CAShapeLayer()
            
            self.layer.mask = self.loupeMaskLayer
            
        }
        
        let x = (self.bounds.size.width / 2) - (self.loupeImageView.image!.size.width / 2)
        
        let y = (self.bounds.size.height / 2) - (self.loupeImageView.image!.size.height / 2)
        
        let width = self.loupeImageView.image!.size.width
        
        let height = self.loupeImageView.image!.size.height
        
        self.loupeImageView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        let roundedRect = self.loupeImageView.frame.insetBy(dx: 2, dy: 3).offsetBy(dx: 0, dy: -1)
        
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: 10)
        
        path.lineWidth = 0
        
        self.loupeMaskLayer.path = path.cgPath
        
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        UIColor.clear.setFill()
        
        UIRectFill(rect)
        
        if self.currentDate == nil { return }
        
        UIColor.white.setFill()
        
        print("rect: \(rect)")
        
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
