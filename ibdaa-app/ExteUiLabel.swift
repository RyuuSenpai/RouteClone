//
//  ExteUiLabel.swift
//  ibdaa-app
//
//  Created by Killvak on 23/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setFontStyle() {
    let fontSize = self.font.pointSize
    if UIApplication.isRTL()  {
    self.font = UIFont(name: "MCS Tholoth S_I normal.", size: fontSize)
    }else {
    self.font = UIFont(name: "Sumptuous-LightItalic", size: fontSize)
    }
}
}

extension UITextField {
    
    
    func setFontStyle()  {
        guard  let fontSize = self.font?.pointSize else { return }
        if UIApplication.isRTL()  {
            self.font = UIFont(name: "MCS Tholoth S_I normal.", size: fontSize)
        }else {
            self.font = UIFont(name: "Sumptuous-LightItalic", size: fontSize)
        }
    }
}
