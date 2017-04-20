//
//  ViewController.swift
//  FaceView
//
//  Created by Yin on 3/27/17.
//  Copyright © 2017 Yin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView!{
        // didSet will be called when ios hooked up this outlet to the FaceView.
        didSet{
            updateUI()
            print("faceView is changed")
        }
    }
    var expression = FacialExpression(eyes:.open,mouth:.grin)
    {
        // didSet will be called when the expression is changed.
        didSet{
            updateUI()
            print("expression is changed")
        }
    }
    
    private func updateUI(){
       
        switch expression.eyes
        {
        case .open:
            // To prevent the case when the change of expression
            // happened before the FaceView is hooked, append ? to faceView.
            // As a result, instead of crashing, it will be ignore when faceView is nil.
            faceView?.eyeOpen = true
        case .closed:
            faceView?.eyeOpen = false
        case .squinting:
            faceView?.eyeOpen = false
        }
        // usage of ??  : 
        // If the parameter comes before ?? is not nil, use its value directly,
        // otherwise use the value following the ??
        faceView?.mouthCurvature = mouthCurvature[expression.mouth] ?? 1.0

    }
    private var mouthCurvature:[FacialExpression.Mouth:CGFloat] = [FacialExpression.Mouth.frown: -1.0, .smirk : -0.5, .neutral : 0.0, .grin : 0.5, .smile : 1.0]
}
