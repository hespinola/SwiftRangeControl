//
//  ViewController.swift
//  SwiftRangeControl
//
//  Created by Humberto Espinola on 02/03/2019.
//  Copyright (c) 2019 Humberto Espinola. All rights reserved.
//

import UIKit
import SwiftRangeControl

class ViewController: UIViewController {
    
    @IBOutlet weak var rangeSlider: RangeSlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        rangeSlider.addTarget(self, action: #selector(rangeSliderChanged), for: .valueChanged)
    }

    @objc private func rangeSliderChanged(_ rangeSlider: RangeSlider) {
        print(rangeSlider.minimumValue, rangeSlider.maximumValue)
    }

}

