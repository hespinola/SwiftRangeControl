//
//  RangeSliderTrackLayer.swift
//  RangeSlider
//
//  Created by Humberto Espinola on 2/5/19.
//  Copyright © 2019 Humberto Espinola. All rights reserved.
//

import UIKit

internal class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        guard let slider = rangeSlider else { return }
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        ctx.setFillColor(slider.trackTintColor.cgColor)
        ctx.addPath(path.cgPath)
        ctx.fillPath()
        
        let lowerValuePosition = CGFloat(slider.positionFor(value: slider.lowerValue))
        let upperValuePosition = CGFloat(slider.positionFor(value: slider.upperValue))
        let rect = CGRect(x: lowerValuePosition, y: 0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
        let highlightedPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        ctx.setFillColor(slider.trackHighlightColor.cgColor)
        ctx.addPath(highlightedPath.cgPath)
        ctx.fillPath()
    }
}
