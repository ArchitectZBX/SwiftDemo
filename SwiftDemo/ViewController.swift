//
//  ViewController.swift
//  SwiftDemo
//
//  Created by Architect_ZBX on 16/2/19.
//  Copyright © 2016年 zhaobingxu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let button = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 20))
        button.backgroundColor = UIColor.blackColor()
        self.view.addSubview(button)
        button.setTitle("dianji", forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("showUI"), forControlEvents: UIControlEvents.TouchUpInside)
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

