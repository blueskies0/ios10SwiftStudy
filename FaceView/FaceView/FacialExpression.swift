//
//  FacialExpression.swift
//  FaceIt
//
//  Created by Yin on 4/20/17.
//  Copyright © 2017 Yin. All rights reserved.
//

import Foundation

// UI-independent representation of a facial expression

struct FacialExpression
{
    // struct has a default  constructor
    enum Eyes: Int {
        case open
        case closed
        case squinting
    }
    
    enum Mouth: Int {
        case frown
        case smirk
        case neutral
        case grin
        case smile
        
        var sadder: Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        var happier: Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }
    
    var sadder: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.sadder)
    }
    var happier: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.happier)
    }

    let eyes: Eyes
    let mouth: Mouth
}