<meta name='keywords' content='iOS, timeline, custom, customization, customized'>

#PLTimelineView 

PLTimelineView is a customized timeline for iOS, simple and easy to use.

####Preview

![preview](http://i.imgur.com/zaCNemF.gif)

####Requirement 

 - XCode 8.0

####Support

 - Support infinite scroll timeline view
 - Support loupe detail view
 - Support using and realtime render in Storyboard
 - Magic

####Delegate

```swift
@objc public protocol PLTimelineDelegate: NSObjectProtocol {
    
    func timeline(_ timeline: PLTimelineView, didScrollTo date: Date)
    
}
```
