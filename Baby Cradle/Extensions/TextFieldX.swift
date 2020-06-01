//
//  TextFieldAttribute.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 5/9/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    func setPlaceHolder(with placeHolder: String) {
        
        self.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        
    }

}
