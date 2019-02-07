//
//  RangeSlider.swift
//  RangeSlider
//
//  Created by Humberto Espinola on 2/4/19.
//  Copyright © 2019 Humberto Espinola. All rights reserved.
//

import UIKit

@IBDesignable
open class RangeSlider: UIControl {
    
    // MARK: - On screen controls
    private let trackLayer = RangeSliderTrackLayer()
    private let lowerControlLayer = RangeSliderControlLayer()
    private let upperControlLayer = RangeSliderControlLayer()
    
    // MARK: - Class Properties
    
    /// Minimum value for the slider, default is 0.0
    @IBInspectable open var minimumValue: Double = 0.0 {
        didSet {
            updateLayers()
        }
    }
    
    /// Maximum value for the slider, default is 10.0
    @IBInspectable open var maximumValue: Double = 10.0 {
        didSet {
            updateLayers()
        }
    }
    
    /// Lower control value, default is 1.0
    @IBInspectable open var lowerValue: Double = 1.0 {
        didSet {
            updateLayers()
        }
    }
    
    /// Upper control value, default is 9.0
    @IBInspectable open var upperValue: Double = 9.0 {
        didSet {
            updateLayers()
        }
    }
    
    private var previousLocation = CGPoint()
    
    /// Default is system blue
    @IBInspectable open var trackTintColor: UIColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1) {
        didSet {
            trackLayer.backgroundColor = trackTintColor.cgColor
            trackLayer.setNeedsDisplay()
        }
    }
    
    /// Default is system blue
    @IBInspectable open var trackHighlightColor: UIColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    /// Disabled by default with 0
    @IBInspectable open var trackCornerRadius: CGFloat = 0 {
        didSet {
            trackLayer.cornerRadius = trackCornerRadius
            trackLayer.masksToBounds = trackCornerRadius > 0
            trackLayer.setNeedsDisplay()
        }
    }
    
    /// Track height, default value is 4
    @IBInspectable open var trackHeight: CGFloat = 4 {
        didSet {
            updateLayers()
        }
    }
    
    /// Lower control corner radius, default is 0
    @IBInspectable open var lowerControlCornerRadius: CGFloat = 0 {
        didSet {
            lowerControlLayer.cornerRadius = lowerControlCornerRadius
            lowerControlLayer.masksToBounds = lowerControlCornerRadius > 0
            lowerControlLayer.setNeedsDisplay()
        }
    }
    
    /// Lower control tint color, default is white
    @IBInspectable open var lowerControlTintColor: UIColor = UIColor.white {
        didSet {
            lowerControlLayer.backgroundColor = lowerControlTintColor.cgColor
            lowerControlLayer.setNeedsDisplay()
        }
    }
    
    /// Lower control border width, default is 0
    @IBInspectable open var lowerControlBorderWidth: CGFloat = 0 {
        didSet {
            lowerControlLayer.borderWidth = lowerControlBorderWidth
            lowerControlLayer.masksToBounds = lowerControlBorderWidth > 0
            lowerControlLayer.setNeedsDisplay()
        }
    }
    
    /// Lower control border color, default is nil
    @IBInspectable open var lowerControlBorderColor: UIColor? {
        didSet {
            lowerControlLayer.borderColor = lowerControlBorderColor?.cgColor
            lowerControlLayer.setNeedsDisplay()
        }
    }
    
    /// Upper control corner radius, default is 0
    @IBInspectable open var upperControlCornerRadius: CGFloat = 0 {
        didSet {
            upperControlLayer.cornerRadius = upperControlCornerRadius
            upperControlLayer.masksToBounds = upperControlCornerRadius > 0
            upperControlLayer.setNeedsDisplay()
        }
    }
    
    /// Upper control tint color, default is white
    @IBInspectable open var upperControlTintColor: UIColor = UIColor.white {
        didSet {
            upperControlLayer.backgroundColor = upperControlTintColor.cgColor
            upperControlLayer.setNeedsDisplay()
        }
    }
    
    /// Upper control border width, default is 0
    @IBInspectable open var upperControlBorderWidth: CGFloat = 0 {
        didSet {
            upperControlLayer.borderWidth = upperControlBorderWidth
            upperControlLayer.masksToBounds = upperControlBorderWidth > 0
            upperControlLayer.setNeedsDisplay()
        }
    }
    
    /// Upper control border color, default is nil
    @IBInspectable open var upperControlBorderColor: UIColor? {
        didSet {
            upperControlLayer.borderColor = upperControlBorderColor?.cgColor
            upperControlLayer.setNeedsDisplay()
        }
    }
    
    /// Control width, default is 10
    @IBInspectable open var controlWidth: CGFloat = 10
    
    /// Control height, default is 10
    @IBInspectable open var controlHeight: CGFloat = 10
    
    // MARK: - View Cycle
    open override var frame: CGRect {
        didSet {
            updateLayers()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupSubviews()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        updateLayers()
    }
    
    // MARK: - User Interaction
    final override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        if lowerControlLayer.frame.contains(previousLocation) {
           lowerControlLayer.highlighted = true
        } else if upperControlLayer.frame.contains(previousLocation) {
            upperControlLayer.highlighted = true
        }
        
        return lowerControlLayer.highlighted || upperControlLayer.highlighted
    }
    
    final override public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - controlWidth)
        
        previousLocation = location
        
        if lowerControlLayer.highlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, minimumValue, upperValue)
        } else if upperControlLayer.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(upperValue, lowerValue, maximumValue)
        }
        
        sendActions(for: .valueChanged)
        
        return true
    }
    
    final override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerControlLayer.highlighted = false
        upperControlLayer.highlighted = false
    }
    
    // MARK: - Class Methods
    private func setupSubviews() {
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        trackLayer.backgroundColor = trackTintColor.cgColor
        layer.addSublayer(trackLayer)
        
        lowerControlLayer.rangeSlider = self
        lowerControlLayer.contentsScale = UIScreen.main.scale
        lowerControlLayer.backgroundColor = lowerControlTintColor.cgColor
        lowerControlLayer.borderWidth = lowerControlBorderWidth
        lowerControlLayer.borderColor = lowerControlBorderColor?.cgColor
        layer.addSublayer(lowerControlLayer)
        
        upperControlLayer.rangeSlider = self
        upperControlLayer.contentsScale = UIScreen.main.scale
        upperControlLayer.backgroundColor = upperControlTintColor.cgColor
        upperControlLayer.borderWidth = upperControlBorderWidth
        upperControlLayer.borderColor = upperControlBorderColor?.cgColor
        layer.addSublayer(upperControlLayer)
    }
    
    private func updateLayers() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: (bounds.height / 2) - (trackHeight / 2))
        trackLayer.setNeedsDisplay()
        
        let lowerControlCenter = CGFloat(positionFor(value: lowerValue))
        lowerControlLayer.frame = CGRect(x: lowerControlCenter - controlWidth / 2, y: (bounds.height / 2) - (controlHeight / 2), width: controlWidth, height: controlHeight)
        lowerControlLayer.setNeedsDisplay()
        
        let upperControlCenter = CGFloat(positionFor(value: upperValue))
        upperControlLayer.frame = CGRect(x: upperControlCenter - controlWidth / 2, y: (bounds.height / 2) - (controlHeight / 2), width: controlWidth, height: controlHeight)
        upperControlLayer.setNeedsDisplay()
        
        CATransaction.commit()
    }
    
    internal func positionFor(value: Double) -> Double {
        return Double(bounds.width - controlWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(controlWidth / 2.0)
    }
    
    private func boundValue(_ value: Double, _ toLowerValue: Double, _ upperValue: Double) -> Double {
        return min(max(value, toLowerValue), upperValue)
    }
}

