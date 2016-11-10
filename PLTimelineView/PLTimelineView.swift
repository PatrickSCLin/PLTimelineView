//
//  PLTimelineView.swift
//  PLTimelineView
//
//  Created by Patrick Lin on 11/10/2016.
//  Copyright © 2016 Patrick Lin. All rights reserved.
//

import UIKit

@objc public protocol PLTimelineDelegate: NSObjectProtocol {
    
    func timeline(_ timeline: PLTimelineView, didScrollTo date: Date)
    
}

@IBDesignable public class PLTimelineView: UIView, UIScrollViewDelegate {
    
    var basedDate: Date!
    
    var currentDate: Date!
    
    var currentIndicator: CAShapeLayer!
    
    var contentView: PLTimelineContentView!
    
    var loupeView: PLTimelineLoupeView!
    
    var longpressGesture: UILongPressGestureRecognizer!
    
    @IBOutlet public weak var delegate: AnyObject?

    // MARK: Scroll Delegate Methods
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard var target_date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self.basedDate) else { return }
        
        let unit_page_width = scrollView.contentSize.width / 3
        
        var isDayChange = false
        
        if scrollView.contentOffset.x >  (scrollView.contentSize.width) - self.bounds.size.width {
            
            scrollView.contentOffset = CGPoint(x: (unit_page_width * 2) - self.bounds.size.width, y: 0)
            
            target_date = Calendar.current.date(byAdding: .day, value: 1, to: target_date)!
            
            isDayChange = true
            
        }
        
        else if scrollView.contentOffset.x < 0 {
            
            scrollView.contentOffset = CGPoint(x: unit_page_width, y: 0)
            
            target_date = Calendar.current.date(byAdding: .day, value: -1, to: target_date)!
            
            isDayChange = true
            
        }
        
        let unit_hour_width = self.contentView.rulerView.unit_hour_width
        
        let unit_minute_width = unit_hour_width / 6 / 10
        
        let unit_second_width = unit_minute_width / 60
        
        let timeline_x = scrollView.contentOffset.x + (self.bounds.size.width / 2)
        
        let unit_timeline_x = timeline_x.truncatingRemainder(dividingBy: unit_page_width)
        
        let hour = Int(floor(unit_timeline_x / unit_hour_width))
        
        let minute = Int(floor((unit_timeline_x - (CGFloat(hour) * unit_hour_width)) / unit_minute_width))
        
        let second = Int(floor((unit_timeline_x - (CGFloat(hour) * unit_hour_width) - (CGFloat(minute) * unit_minute_width)) / unit_second_width))
        
        let day_offsets = [-1, 0, 1]
        
        let day_index = Int(floor(timeline_x / unit_page_width))
        
        let day_offset = day_offsets[day_index]
        
        if isDayChange {
            
            self.basedDate = target_date
            
        }
        
        var current_date = Calendar.current.date(bySettingHour: hour, minute: minute, second: second, of: target_date)!
        
        current_date = Calendar.current.date(byAdding: .day, value: day_offset, to: current_date)!
        
        self.currentDate = current_date
        
        (self.delegate as? PLTimelineDelegate)?.timeline(self, didScrollTo: self.currentDate)
        
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
    
    override public func layoutSubviews() {
        
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
    
    func initLoupeView() {
        
        self.loupeView = PLTimelineLoupeView()
        
        self.addSubview(self.loupeView)
        
        self.loupeView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: self.loupeView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.loupeView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.loupeView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.loupeView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        
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
    
    func longpress(gesture: UILongPressGestureRecognizer) {
        
        switch gesture.state {
            
        case .began:
            
            print("began")
            
            self.loupeView.displayInLoupe(date: self.currentDate)
            
            break
            
        case .cancelled:
            
            print("cancelled")
            
            break
            
        case .changed:
            
            print("changed")
            
            break
            
        case .ended:
            
            print("ended")
            
            break
            
        default:
            
            break
            
        }
        
    }
    
    // MARK: Init Methods
    
    func commonInit() {
        
        let now = Date()
        
        self.basedDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: now)
        
        self.currentDate = now
        
        self.initContentView()
        
        self.initLoupeView()
        
        self.longpressGesture = UILongPressGestureRecognizer(target: self, action: #selector(PLTimelineView.longpress(gesture:)))
        
        self.longpressGesture.minimumPressDuration = 1
        
        self.addGestureRecognizer(self.longpressGesture)
        
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
    
}
