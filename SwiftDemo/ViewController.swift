//
//  ViewController.swift
//  SwiftDemo
//
//  Created by Architect_ZBX on 16/2/19.
//  Copyright © 2016年 zhaobingxu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ASValueTrackingSliderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let slider = ASValueTrackingSlider(frame: CGRectMake(20,100,WScreen - 40, 20))
        slider.backgroundColor = UIColor.redColor()
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.PercentStyle
        slider.numberFormatter = formatter
        self.view.addSubview(slider)
        slider.delegate = self
        slider.font = UIFont(name: "Futura-CondensedExtraBold", size: 26)
//        slider.popUpViewArrowLength = 20.0
        slider.showPopUpViewAnimated(true)
        
        
        
//        self.view.backgroundColor = UIColor.redColor()
//        let imageView = UIImageView(frame: UIScreen.mainScreen().bounds)
//        imageView.image = UIImage(named: "1.png")
//        self.view.addSubview(imageView)
//        UIGraphicsBeginImageContextWithOptions(UIScreen.mainScreen().bounds.size, true  , 1.0)
//        let v = BezierView()
//        v.frame = UIScreen.mainScreen().bounds
//        imageView.addSubview(v)
//        self.view.addSubview(v)
        
//        let button = UIButton()
//        self.view.addSubview(button)
//        button.mas_makeConstraints { (make) -> Void in
//            make.edges.
//        }
        
//        let button = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 20))
//        button.backgroundColor = UIColor.blackColor()
//        self.view.addSubview(button)
//        button.setTitle("dianji", forState: UIControlState.Normal)
//        button.addTarget(self, action: Selector("showUI"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func sliderWillDisplayPopUpView(slider: ASValueTrackingSlider!) {
        
    }
    
    func showUI() {
        let keyArray: NSArray = NSArray(array: ["移动", "温度", "湿度"])
        let valueArray: NSArray = NSArray(array: [["开","关"],["10","11","20"],["50","60","90"]])
        let alertView = UNAlertView(title: "", message: "", key: keyArray, value: valueArray)
        alertView.messageAlignment = NSTextAlignment.Center
        alertView.buttonAlignment  = UNButtonAlignment.Horizontal
        alertView.addButton("确定") { (keyIndex, valueIndex) -> Void in
            print("keyIndex is \(keyIndex) ")
            print("valueIndex is \(valueIndex)")
        }
        
        alertView.addButton("取消") { (keyIndex, valueIndex) -> Void in
            
        }
        
        // Show
        alertView.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

