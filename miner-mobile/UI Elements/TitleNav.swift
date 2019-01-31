//
//  TitleNav.swift
//  miner-mobile
//
//  Created by Frank Caron on 1/31/19.
//  Copyright © 2019 Frank Caron. All rights reserved.
//

import UIKit

class TitleNav: UINavigationBar {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    private func configureUI() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.backgroundColor = .clear
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    
}
