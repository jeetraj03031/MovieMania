//
//  ButtonAnimationFactory.swift
//  MovieMania
//
//  Created by EPIC on 03/10/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import UIKit

typealias ButtonConfiguration = (symbol: String, buttonTint: UIColor)

struct ButtonAnimationFactory {
    
    func makeActivateAnimation(for button: UIButton, _ config: ButtonConfiguration) {
        button.layer.opacity = 0.5
        button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            button.layer.opacity = 1
            button.transform = CGAffineTransform(scaleX: 1, y: 1)
            button.setImage(UIImage(named: config.symbol), for: .normal)
            button.tintColor = config.buttonTint
        })
    }
    
    func makeDeactivateAnimation(for button: UIButton, _ config: ButtonConfiguration) {
        button.layer.opacity = 0.5
        button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            button.layer.opacity = 1
            button.transform = CGAffineTransform(scaleX: 1, y: 1)
            button.setImage(UIImage(named: config.symbol), for: .normal)
            button.tintColor = config.buttonTint
        })
    }
}
