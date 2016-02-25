//
//  UNAlertView.swift
//  UNAlertView
//
//  Created by Yuta Akizuki on 2015/11/10.
//  Copyright © 2015年 ytakzk. All rights reserved.
//

import UIKit

private let kContainerWidth: CGFloat = WScreen - 60
private let kButtonHeight: CGFloat   = 45.0
private let kUNAlertViewTag          = 1928
private let kCornerRadius: CGFloat   = 10.0
private let kShadowOpacity: Float    = 0.15

internal enum UNButtonAlignment {
    case Horizontal
    case Vertical
}

//typealias GetIndexBlock = (actionIdIndex:NSInteger, valueIndex:NSInteger) -> Void

final public class UNAlertView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var titleLabel        = UILabel()
    private var messageLabel      = UILabel()
    private var picker            = UIPickerView()
    private var containerView     = UIView()
    private var shadowView        = UIView()
    private var buttons           = [UNAlertButton]()
    var keyIndex = 0
    var valueIndex = 0
    
    // Message alignment
    var messageAlignment      = NSTextAlignment.Center
    
    // Button alignment
    var buttonAlignment       = UNButtonAlignment.Horizontal
    
    // Fonts
    var titleFont: UIFont?
    var messageFont: UIFont?
    
    var keyArray: NSArray!
    var valueArray: NSArray!
    var subValueArray:NSArray?
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    // Initialize with a message
    //    convenience public init(message: String) {
    //        self.init(title: "", message: message)
    //    }
    
    // Initialize with a title and a message
    public init(title: String, message: String, key: NSArray, value: NSArray) {
        super.init(frame: CGRectZero)
        
        titleLabel.text       = title
        messageLabel.text     = message
        self.keyArray         = key
        self.subValueArray    = value[0] as? NSArray
        self.valueArray       = value
        
        self.frame            = UIScreen.mainScreen().bounds
        self.backgroundColor  = UIColor(white: 0, alpha: 0.2)
        containerView.layer.cornerRadius = kCornerRadius
        containerView.layer.masksToBounds      = true
        
        shadowView.layer.shadowColor   = UIColor.blackColor().CGColor
        shadowView.layer.shadowOffset  = CGSizeZero
        shadowView.layer.shadowOpacity = kShadowOpacity
        shadowView.layer.shadowRadius  = kCornerRadius
        
    }
    
    // Add a button with a title and an action
    public func addButton(title:String, action: (keyIndex:NSInteger, valueIndex:NSInteger) -> Void) {
        
        let btn    = UNAlertButton(title: title, backgroundColor: UIColor.whiteColor(), fontColor: UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1))
        btn.action = action
        btn.addTarget(self, action:Selector("buttonTapped:"), forControlEvents:.TouchUpInside)
        buttons.append(btn)
    }
    
    // Add a button with a title, a background color, a font color and an action
    //    public func addButton(titl e:String, backgroundColor: UIColor, action:()->Void) {
    //
    //        let btn    = UNAlertButton(title: title, backgroundColor: backgroundColor, fontColor: nil)
    //        btn.action = action
    //        btn.addTarget(self, action:Selector("buttonTapped:"), forControlEvents:.TouchUpInside)
    //        buttons.append(btn)
    //    }
    //
    //    // Add a button with a title, a background color, a font color and an action
    //    public func addButton(title:String, backgroundColor: UIColor, fontColor: UIColor, action:()->Void) {
    //
    //        let btn    = UNAlertButton(title: title, backgroundColor: backgroundColor, fontColor: fontColor)
    //        btn.action = action
    //        btn.addTarget(self, action:Selector("buttonTapped:"), forControlEvents:.TouchUpInside)
    //        buttons.append(btn)
    //    }
    
    // Show an alertview
    public func show() {
        
        // Draw all the subviews
        
        // Remove all the subviews
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        // Add self to keyWindow
        if let rv = UIApplication.sharedApplication().keyWindow {
            if rv.viewWithTag(kUNAlertViewTag) == nil {
                self.tag = kUNAlertViewTag
                rv.addSubview(self)
            }
        } else {
            return
        }
        
        var currentContentHeight:CGFloat = 10.0
        // Title
        if titleLabel.text?.characters.count > 0 {
            currentContentHeight = 21.0
            titleLabel.frame = CGRect(x: 22, y: currentContentHeight, width: kContainerWidth-44, height: 25)
            currentContentHeight = getBottomPos(titleLabel)
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.font = (titleFont != nil) ? titleFont : UIFont.boldSystemFontOfSize(16)
            containerView.addSubview(titleLabel)
        }
        
        // Message
        messageLabel.numberOfLines = 0
        messageLabel.font = (messageFont != nil) ? messageFont : UIFont.systemFontOfSize(16)
        let messageSize    = messageLabel.sizeThatFits(CGSize(width: kContainerWidth-44, height: 9999))
        messageLabel.frame = CGRect(x: 22, y: currentContentHeight + 10, width: kContainerWidth-44, height: messageSize.height)
        currentContentHeight = getBottomPos(messageLabel)
        messageLabel.textAlignment = messageAlignment
        containerView.addSubview(messageLabel)
        
        //picker
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: kContainerWidth, height: 140))
        picker.backgroundColor = UIColor.whiteColor()
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        containerView.addSubview(picker)
        
        currentContentHeight = getBottomPos(picker)
        
        // Button
        let space:CGFloat = 0.5
        let width  = (kContainerWidth - space * CGFloat(buttons.count-1)) / CGFloat(buttons.count)
        for var i = 0; i < buttons.count; i++ {
            let btn   = buttons[i]
            if buttonAlignment == UNButtonAlignment.Horizontal {
                btn.frame  = CGRect(x: (width + space)*CGFloat(i), y: currentContentHeight + 0.5, width: width, height: kButtonHeight)
                if i == buttons.count - 1 {
                    currentContentHeight = getBottomPos(btn)
                }
            } else {
                let y = (i == 0) ? currentContentHeight + 15: currentContentHeight + space
                btn.frame = CGRect(x: 0.0, y: y, width: kContainerWidth, height: kButtonHeight)
                currentContentHeight = getBottomPos(btn)
            }
            containerView.addSubview(btn)
        }
        
        // Shadow View & Container View
        shadowView.frame     = CGRect(x: 0, y: 0, width: kContainerWidth, height: currentContentHeight)
        shadowView.center    = self.center
        containerView.frame  = CGRect(origin: CGPointZero, size: shadowView.frame.size)
        containerView.backgroundColor = UIColor(red: 218/255, green: 218/255, blue: 222/255, alpha: 1)
        shadowView.addSubview(containerView)
        self.addSubview(shadowView)
        
        // Apply a fade-in animation
        self.alpha     = 0.0
        self.transform = CGAffineTransformMakeScale(1.3, 1.3)
        
        UIView.animateWithDuration(0.2,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                self.transform = CGAffineTransformMakeScale(1.0, 1.0)
                self.alpha = 1.0
            },
            completion: {(finished) in
            }
        )
        
    }
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.keyArray.count
        }
        else {
            return self.subValueArray!.count
        }
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.keyArray[row] as? String
        }
        else {
            return self.subValueArray![row] as? String
        }
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //       print("row = \(row), component = \(component)")
        switch(component) {
        case 0:
            self.subValueArray = self.valueArray[row] as? NSArray
            self.picker.selectRow(0, inComponent: 1, animated: false)
            self.picker.reloadComponent(1)
            self.keyIndex = row
            break
        case 1:
            self.valueIndex = row
            break
        default:
            print("没了")
        }
        
        
    }
    
    // Dismiss the alertview from the keywindow
    private func dismiss() {
        
        // Apply a fade-out animation
        UIView.animateWithDuration(0.18,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                self.containerView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                self.alpha = 0.0
            },
            completion: {(finished) in
                self.removeFromSuperview()
            }
        )
    }
    
    func buttonTapped(btn:UNAlertButton) {
        
        btn.action(actionIdIndex: self.keyIndex, valueIndex: self.valueIndex)
        dismiss()
    }
    
    private func getBottomPos(view: UIView) -> CGFloat {
        
        return view.frame.origin.y + view.frame.height
    }
    
}

internal final class UNAlertButton: UIButton {
    
    private var target:AnyObject!
    private var action: ((actionIdIndex:NSInteger, valueIndex:NSInteger) -> Void)!
    //    private var action:()->Void
    override var highlighted: Bool {
        
        didSet {
            
            self.alpha = (highlighted) ? 0.8 : 1.0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(title: title, backgroundColor: nil, fontColor: nil)
    }
    
    init(title: String, backgroundColor: UIColor?, fontColor: UIColor?) {
        
        super.init(frame: CGRectZero)
        self.backgroundColor = (backgroundColor != nil) ? backgroundColor! : self.tintColor
        self.setTitle(title, forState: .Normal)
        self.setTitleColor((fontColor != nil) ? fontColor! : UIColor.whiteColor() , forState: .Normal)
    }
    
}

// Extension
internal extension UIColor {
    
    class func hex (var hexStr : NSString, alpha : CGFloat) -> UIColor {
        
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string", terminator: "")
            return UIColor.whiteColor()
        }
    }
}
