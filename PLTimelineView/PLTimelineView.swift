//
//  PLTimelineView.swift
//  PLTimelineView
//
//  Created by Patrick Lin on 11/10/2016.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

import UIKit

protocol PLTimelineDelegate {
    
    func timeline(_ timeline: PLTimelineView, didScrollTo date: Date)
    
}

@IBDesignable class PLTimelineView: UIView, UIScrollViewDelegate {
    
    var currentDate: Date = Date()
    
    var currentIndicator: CAShapeLayer!
    
    var contentView: PLTimelineContentView!

    // MARK: Scroll Delegate Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let unit_page_width = scrollView.contentSize.width / 3
        
        if scrollView.contentOffset.x >  (scrollView.contentSize.width) - self.bounds.size.width {
            
            scrollView.contentOffset = CGPoint(x: (unit_page_width * 2) - self.bounds.size.width, y: 0)
            
        }
        
        else if scrollView.contentOffset.x < 0 {
            
            scrollView.contentOffset = CGPoint(x: unit_page_width, y: 0)
            
        }
        
    }
    
    // MARK: Public Methods
    
    func gotoDate(_ date: Date) {
        
        self.layoutIfNeeded()
        
        self.currentDate = date
        
        let hour = CGFloat((Calendar.current as NSCalendar).component(.hour, from: self.currentDate))
        
        let minute = CGFloat((Calendar.current as NSCalendar).component(.minute, from: self.currentDate))
        
        let second = CGFloat((Calendar.current as NSCalendar).component(.second, from: self.currentDate))
        
        let unit_page_x = self.contentView.contentSize.width / 3
        
        let unit_hour_width = self.contentView.rulerView.unit_hour_width
        
        let unit_minute_width = unit_hour_width / 6 / 10
        
        let unit_second_width = unit_minute_width / 60
        
        let timeline_x = unit_page_x + (unit_hour_width * hour) + (unit_minute_width * minute) + (unit_second_width * second) - (self.bounds.size.width / 2)
        
        self.contentView.contentOffset = CGPoint(x: timeline_x, y: 0)
        
    }
    
    // MARK: Internal Methods
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if self.currentIndicator == nil { self.initCurrentIndicator() }
        
        self.updateCurrentIndicator()
        
        self.gotoDate(self.currentDate)
        
    }
    
    func initContentView() {
        
        self.contentView = PLTimelineContentView()
        
        self.contentView.delegate = self
        
        self.addSubview(self.contentView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.contentView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        
    }

    func initCurrentIndicator() {
        
        self.layoutIfNeeded()
        
        let triangle = UIBezierPath()
        
        triangle.move(to: CGPoint(x: 0, y: 0))
        
        triangle.addLine(to: CGPoint(x: 10, y: 0))
        
        triangle.addLine(to: CGPoint(x: 5, y: 10))
        
        triangle.close()
        
        let line = CALayer()
        
        line.frame = CGRect(x: 4.5, y: 0, width: 1, height: self.bounds.size.height - 20)
        
        line.backgroundColor = UIColor.red.cgColor
        
        self.currentIndicator = CAShapeLayer()
        
        self.currentIndicator.frame = CGRect(x: 0, y: 0, width: 10, height: self.bounds.size.height - 20)
        
        self.currentIndicator.path = triangle.cgPath
        
        self.currentIndicator.fillColor = UIColor.red.cgColor
        
        self.currentIndicator.addSublayer(line)
        
        self.layer.addSublayer(self.currentIndicator)
        
    }
    
    func updateCurrentIndicator() {
        
        let x = (self.bounds.size.width / 2) - (self.currentIndicator.bounds.size.width / 2)
        
        let y = CGFloat(0)
        
        let width = CGFloat(10)
        
        let height = self.bounds.size.height - 20
        
        self.currentIndicator.frame = CGRect(x: x, y: y, width: width, height: height)
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        self.initContentView()
        
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
