//
//  FaceView.swift
//  FaceView
//
//  Created by Yin on 3/27/17.
//  Copyright © 2017 Yin. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    @IBInspectable
    var scale : CGFloat = 0.9
    
    private var skullRadius : CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    private var skullCenter : CGPoint{
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    @IBInspectable
    var eyeOpen: Bool = false
    
    @IBInspectable
    var mouthCurvature : CGFloat = -0.5 // full smill for 1.0, full frown for -1.0
    
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
    private func pathForMouth() -> UIBezierPath{
        let mouthWidth = skullRadius / Ratios.skullRatiosToMouthWidth
        let mouthHeigth = skullRadius / Ratios.skullRatiosToMouthHeight
        let mouthOffSet = skullRadius / Ratios.skullRatiosToMouthOffset
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth / 2, y: skullCenter.y + mouthOffSet, width: mouthWidth, height: mouthHeigth)
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let middle1 = CGPoint(x: mouthRect.minX + mouthWidth / 3, y: mouthRect.midY + mouthCurvature * mouthHeigth)
        let middle2 = CGPoint(x: mouthRect.minX + 2 * mouthWidth / 3, y: mouthRect.midY + mouthCurvature * mouthHeigth)
        
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        //let path =  UIBezierPath(rect: mouthRect)
        let path =  UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: middle1, controlPoint2: middle2)
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
        pathForMouth().stroke()
        //skullPath.stroke()
    
    }
    
    private struct Ratios{
        static let skullRatiosToEyeOffset : CGFloat = 3
        static let skullRatiosToEyeRatios : CGFloat = 10
        static let skullRatiosToMouthOffset : CGFloat = 3
        static let skullRatiosToMouthWidth : CGFloat = 1.5
        static let skullRatiosToMouthHeight : CGFloat = 6   }
}
