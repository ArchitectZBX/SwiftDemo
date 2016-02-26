//
//  BezierView.swift
//  SwiftDemo
//
//  Created by Architect_ZBX on 16/2/26.
//  Copyright © 2016年 zhaobingxu. All rights reserved.
//

import UIKit

class BezierView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
        
        CGContextSetRGBStrokeColor(context,1,1,1,1.0);
        
        CGContextMoveToPoint(context, 50, 150);//设置Path的起点
        CGContextAddQuadCurveToPoint(context,150, 50, 270, 150);//设置贝塞尔曲线的控制点坐标和终点坐标
        CGContextStrokePath(context);
    }

}
