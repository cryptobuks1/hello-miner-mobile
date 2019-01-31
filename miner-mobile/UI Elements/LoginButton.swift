//
//  LoginButton.swift
//  miner-mobile
//
//  Created by Frank Caron on 1/31/19.
//  Copyright © 2019 Frank Caron. All rights reserved.
//

import Foundation
import UIKit

let kLoginButtonBackgroundColor = UIColor.white
let kLoginButtonTintColor = UIColor.black
let kLoginButtonCornerRadius: CGFloat = 10.0

class LoginButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    private func configureUI() {
        self.backgroundColor = kLoginButtonBackgroundColor
        self.layer.cornerRadius = kLoginButtonCornerRadius
        self.tintColor = kLoginButtonTintColor
        self.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 25)
    }
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? kLoginButtonTintColor : kLoginButtonBackgroundColor
            tintColor = isHighlighted ? kLoginButtonBackgroundColor : kLoginButtonTintColor
        }
    }
    
}
