//
//  ActionSheetAndPickerViewViewController.swift
//  SwiftDemo
//
//  Created by Architect_ZBX on 16/2/22.
//  Copyright © 2016年 zhaobingxu. All rights reserved.
//

import UIKit

class ActionSheetAndPickerViewViewController: UIViewController,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    let keyArray: NSArray = NSArray(array: ["移动", "温度", "湿度"])
    let valueArray: NSArray = NSArray(array: [["开","关"],["10","11","20"],["50","60","90"]])
    var subValueArray: NSArray!
    var actionSheet:UIActionSheet!
    var picker:UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.subValueArray = valueArray[0] as! NSArray
    }
    
    func showUI() {
        actionSheet = UIActionSheet(title: "\n\n\n\n\n\n\n\n\n\n", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "确定")
        actionSheet.userInteractionEnabled = true
        actionSheet.backgroundColor = UIColor.clearColor()
        picker = UIPickerView()
        //        picker.frame = CGRectMake(0, 0, 200, 100)
        picker.delegate = self
        picker.dataSource = self
        picker.showsSelectionIndicator = true
        self.actionSheet.addSubview(picker)
        let window = UIApplication.sharedApplication().keyWindow
        if ((window?.subviews.contains(self.view)) != nil) {
            self.actionSheet.showInView(self.view)
        } else {
            self.actionSheet.showInView(window!)
            
        }
        //        self.actionSheet.showInView(window!)
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.keyArray.count
        }
        else {
            return self.subValueArray!.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.keyArray[row] as? String
        }
        else {
            return self.subValueArray![row] as? String
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //       print("row = \(row), component = \(component)")
        switch(component) {
        case 0:
            self.subValueArray = self.valueArray[row] as? NSArray
            self.picker.selectRow(0, inComponent: 1, animated: false)
            self.picker.reloadComponent(1)
            break
        case 1:
            break
        default:
            print("没了")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
