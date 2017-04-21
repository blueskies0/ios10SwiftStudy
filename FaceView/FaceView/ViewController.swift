//
//  ViewController.swift
//  FaceView
//
//  Created by Yin on 3/27/17.
//  Copyright © 2017 Yin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceViewer: FaceView!{
    
        // didSet will be called when ios hooked up this outlet to the FaceView.
        didSet{
            updateUI()
            print("faceView is changed")
        }
    }
    var expression = FacialExpression(eyes:.open,mouth:.frown)
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
            // happened before the faceViewer is hooked, append ? to faceViewer.
            // As a result, instead of crashing, it will be ignore when faceViewer is nil.
            faceViewer?.eyeOpen = true
        case .closed:
            faceViewer?.eyeOpen = false
        case .squinting:
            faceViewer?.eyeOpen = false
        }
        // usage of ??  : 
        // If the parameter comes before ?? is not nil, use its value directly,
        // otherwise use the value following the ??
        faceViewer?.mouthCurvature = mouthCurvature[expression.mouth] ?? 1.0

    }
    private var mouthCurvature:[FacialExpression.Mouth:CGFloat] = [FacialExpression.Mouth.frown: -1.0, .smirk : -0.5, .neutral : 0.0, .grin : 0.5, .smile : 1.0]
}
