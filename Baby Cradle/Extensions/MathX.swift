//
//  MathX.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 5/16/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import Foundation

extension Float {
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
