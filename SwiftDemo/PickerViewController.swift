//
//  PickerViewController.swift
//  SwiftDemo
//
//  Created by Architect_ZBX on 16/2/19.
//  Copyright © 2016年 zhaobingxu. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController,UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    var pickerView:UIPickerView!
    var backgroundView:UIView!
    var cancelButton:UIButton!
    var clickButton:UIButton!
    var allDevicesArray:NSArray?
    var deviceArray:NSArray? = []
    var deviceNameArray:NSMutableArray? = []
    var settingNameArray:NSMutableArray? = []
    var selectedDevice = ""
    var selectedSetting = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        self.getArray()
        self.initUI()
        let button = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 20))
        self.view.addSubview(button)
        button.setTitle("dianji", forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("showUI"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showUI() {
        self.view.addSubview(backgroundView)
    }
    
    func dismissUI() {
        self.backgroundView.removeFromSuperview()
    }
    
    func initUI() {
        //背景View
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: WScreen-60, height: 180))
        backgroundView.backgroundColor = UIColor.whiteColor()
        backgroundView.center = CGPoint(x: 160 , y: 250)
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.masksToBounds = true
        
        //UIPickerView
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: backgroundView.frame.width, height: 140))
        self.pickerView.backgroundColor = UIColor.clearColor()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.backgroundView.addSubview(pickerView)
        
        //定义两个button
        cancelButton = UIButton(frame: CGRect(x: 0, y: 140, width: backgroundView.frame.width/2, height: 40))
        cancelButton.backgroundColor = UIColor.whiteColor()
        cancelButton.layer.borderColor = UIColor.grayColor().CGColor
        cancelButton.layer.borderWidth = 0.5
        cancelButton.setTitle("取消", forState: UIControlState.Normal)
        cancelButton.setTitleColor(UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1), forState: UIControlState.Normal)
        cancelButton.addTarget(self, action: Selector("dismissUI"), forControlEvents: UIControlEvents.TouchUpInside)
        self.backgroundView.addSubview(cancelButton)
        
        clickButton = UIButton(frame: CGRect(x: backgroundView.frame.width/2, y: 140, width: backgroundView.frame.width/2, height: 40))
        clickButton.backgroundColor = UIColor.whiteColor()
        clickButton.layer.borderColor = UIColor.grayColor().CGColor
        clickButton.layer.borderWidth = 0.5
        clickButton.setTitle("确定", forState: UIControlState.Normal)
        clickButton.setTitleColor(UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1), forState: UIControlState.Normal)
        clickButton.addTarget(self, action: Selector("click"), forControlEvents: UIControlEvents.TouchUpInside)
        self.backgroundView.addSubview(clickButton)
    }
    
    func click() {
        print("您所选的设备为"+self.selectedDevice+"的设置为"+self.selectedSetting)
        
    }
    
    func getArray() {
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("devices", ofType: "plist")
        print("plist的路径为"+path!)
        allDevicesArray = NSArray(contentsOfFile: path!)
        self.deviceArray = allDevicesArray?.objectAtIndex(0) as? NSArray        //第一个设备
        for(var i = 0;i < deviceArray?.count;i++) {
            let dictionary = deviceArray![i] as! NSDictionary
            let name = dictionary.objectForKey("name")
            self.deviceNameArray?.addObject(name!)
        }
        self.selectedDevice = self.deviceNameArray![0] as! String
        let settingArray = deviceArray?.objectAtIndex(0).objectForKey("Setting")
        for(var i = 0;i<settingArray?.count;i++) {
            let name = settingArray![i]
            self.settingNameArray?.addObject(name)
        }
        self.selectedSetting = self.settingNameArray![0] as! String
    }
    
    //pickerView的代理方法
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(component) {
        case 0:
            return (deviceNameArray?.count)!
        case 1:
            return (settingNameArray?.count)!
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(component) {
        case 0:
            return self.deviceNameArray![row] as? String
        case 1:
            return self.settingNameArray![row] as? String
        default:
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch(component) {
        case 0:
            self.settingNameArray?.removeAllObjects()
            let settingArray = deviceArray?.objectAtIndex(row).objectForKey("Setting")
            for(var i = 0;i<settingArray?.count;i++) {
                let name = settingArray![i]
                self.settingNameArray?.addObject(name)
            }
            self.selectedDevice = self.deviceNameArray![row] as! String
            self.pickerView.selectRow(0, inComponent: 1, animated: false)
            self.pickerView.reloadComponent(1)
            break
        case 1:
            self.selectedSetting = self.settingNameArray![row] as! String
            break
            
        default:
            print("没了")
        }
    }
    
    
}
