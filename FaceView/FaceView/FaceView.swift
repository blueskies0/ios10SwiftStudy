//
//  FaceView.swift
//  FaceView
//
//  Created by Yin on 3/27/17.
//  Copyright © 2017 Yin. All rights reserved.
//

import UIKit
//@IBDesignable
class FaceView: UIView {

    var scale : CGFloat = 0.9
    
    private var skullRadius : CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    private var skullCenter : CGPoint{
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    private var eyeOpen: Bool = false
    
    private enum Eye{
        case left
        case right
    }
    private func pathForEye(_ eye: Eye) -> UIBezierPath{
        func centerOfEye(_ eye: Eye) -> CGPoint{
            var myCenter = skullCenter
            let eyeOffset = skullRadius/Ratios.skullRatiosToEyeOffset
            myCenter.y -= eyeOffset
            myCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            return myCenter
        }
        
        let eyeRadio = skullRadius/Ratios.skullRatiosToEyeRatios
        let eyeCenter = centerOfEye(eye)
        let path: UIBezierPath
        if eyeOpen {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadio, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        }else{
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadio, y:eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadio, y: eyeCenter.y))
        }
        path.lineWidth = 5.0
        
        return path
    }
    
    private func pathForSkull() -> UIBezierPath{
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = 5.0
        return path
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        UIColor.red.set()
        pathForSkull().stroke()
        pathForEye(Eye.left).stroke()
        pathForEye(Eye.right).stroke()

        //skullPath.stroke()
    
    }
    
    private struct Ratios{
        static let skullRatiosToEyeOffset : CGFloat = 3
        static let skullRatiosToEyeRatios : CGFloat = 10
    }
}
