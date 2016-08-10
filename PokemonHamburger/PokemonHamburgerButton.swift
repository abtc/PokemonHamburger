//
//  PokemonHamburgerButton.swift
//  PokemonHamburger
//
//  Created by Kuma on 8/10/16.
//  Copyright © 2016 Windward. All rights reserved.
//

import UIKit

class PokemonHamburgerButton: UIButton {
    
    func bezierPathCircle(radius: CGFloat, centerX: CGFloat, centerY: CGFloat, startAngleDegree: CGFloat, endAngleDegree: CGFloat) -> UIBezierPath {
        let startAngle = CGFloat(startAngleDegree * CGFloat(M_PI) / 180)
        let endAngle = CGFloat(endAngleDegree * CGFloat(M_PI) / 180)
        
        let path = UIBezierPath(arcCenter: CGPointMake(centerX, centerY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        return path
    }
    
    func bezierPathHorizontalLine(startPoint: CGPoint, endPoint: CGPoint) -> UIBezierPath {
        let path6Path = UIBezierPath()
        path6Path.moveToPoint(startPoint)
        path6Path.addLineToPoint(endPoint)
        return path6Path
    }
    
    var isOn: Bool = false {
        didSet {
            doAnimation(isReverse: isOn)
        }
    }
    
    
    var halfCircleBlackLeft: CAShapeLayer! = CAShapeLayer() // (
    var halfCircleBlackRight: CAShapeLayer! = CAShapeLayer() // )
    
    var halfCircleRedLeft: CAShapeLayer! = CAShapeLayer() // (
    var halfCircleRedRight: CAShapeLayer! = CAShapeLayer() // )
    
    var halfCircleYellowLeft: CAShapeLayer! = CAShapeLayer() // (
    var halfCircleYellowRight: CAShapeLayer! = CAShapeLayer() // )
    
    var menuLineTop: CAShapeLayer! = CAShapeLayer() //      Ξ
    var menuLineCenter: CAShapeLayer! = CAShapeLayer() //   Ξ
    var menuLineBottom: CAShapeLayer! = CAShapeLayer() //   Ξ
    
    
    var innerCircle: CAShapeLayer! = CAShapeLayer() //      O
    var innerCircleSolid: CAShapeLayer! = CAShapeLayer() // ·
    
    
    let color = UIColor(red: 26/255.0, green: 26/255.0, blue: 26/255.0, alpha: 1.000)
    let yellowColor = UIColor(red: 250.0/255.0, green: 222.0/255.0, blue: 92.0/255.0, alpha: 1.000)
    let redColor = UIColor(red: 0.942, green: 0.000, blue: 0.025, alpha: 1.000)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialLayer()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialLayer()
    }
    
    func initialLayer() {
        let layerSize = CGSizeMake(200, 200)
        
        for sublayer in [halfCircleRedLeft, halfCircleRedRight, halfCircleYellowLeft, halfCircleYellowRight, halfCircleBlackLeft, halfCircleBlackRight,  menuLineTop, menuLineCenter, menuLineBottom, innerCircle, innerCircleSolid] {
            sublayer.lineCap = kCALineCapRound
            sublayer.lineJoin = kCALineJoinRound
            //            sublayer.lineDashPattern = dashParts
            sublayer.masksToBounds = true
            sublayer.rasterizationScale = 2.0 * UIScreen.mainScreen().scale
            sublayer.shouldRasterize = true
            sublayer.lineWidth = 5
            sublayer.miterLimit = 5
            sublayer.fillColor = nil
            sublayer.strokeColor = color.CGColor
            
            sublayer.bounds = CGRectMake(0, 0, layerSize.width, layerSize.height)
            
            sublayer.actions = [
                "strokeStart": NSNull(),
                "strokeEnd": NSNull(),
                "strokeColor": NSNull(),
                "opacity": NSNull(),
                "transform": NSNull(),
                "path": NSNull(),
                "fillColor": NSNull(),
            ]
            
            sublayer.strokeStart = 0.0
            sublayer.strokeEnd = 1.0
            
            sublayer.position = CGPointMake(CGRectGetWidth(frame) / 2, CGRectGetHeight(frame) / 2)
            
            self.layer.addSublayer(sublayer)
            
        }
        
        
        let centerX: CGFloat = layerSize.width / 2
        let centerY: CGFloat = layerSize.height / 2
        let radius: CGFloat = 60.0
        let startAngleDegree: CGFloat = -45.0 - 90
        let endAngleDegree: CGFloat = 45.0
        let startAngleDegree2: CGFloat = 45.0
        let endAngleDegree2: CGFloat = 45.0 + 180
        
        
        halfCircleBlackLeft.path = bezierPathCircle(radius, centerX: centerX, centerY: centerY, startAngleDegree: startAngleDegree, endAngleDegree: endAngleDegree).CGPath
        halfCircleBlackRight.path = bezierPathCircle(radius, centerX: centerX, centerY: centerY, startAngleDegree: startAngleDegree2, endAngleDegree: endAngleDegree2).CGPath
        
        halfCircleRedLeft.path = bezierPathCircle(radius, centerX: centerX, centerY: centerY, startAngleDegree: startAngleDegree, endAngleDegree: endAngleDegree).CGPath
        halfCircleRedRight.path = bezierPathCircle(radius, centerX: centerX, centerY: centerY, startAngleDegree: startAngleDegree2, endAngleDegree: endAngleDegree2).CGPath
        
        halfCircleYellowLeft.path = bezierPathCircle(radius, centerX: centerX, centerY: centerY, startAngleDegree: startAngleDegree, endAngleDegree: endAngleDegree).CGPath
        halfCircleYellowRight.path = bezierPathCircle(radius, centerX: centerX, centerY: centerY, startAngleDegree: startAngleDegree2, endAngleDegree: endAngleDegree2).CGPath
        
        halfCircleRedLeft.lineWidth = 4
        halfCircleRedRight.lineWidth = 4
        halfCircleYellowLeft.lineWidth = 4
        halfCircleYellowRight.lineWidth = 4
        
        let axisX: CGFloat = (layerSize.width / 2) - (radius)
        let axisY: CGFloat = (layerSize.width / 2) - (radius)
        
        let topLinePointLeftX: CGFloat = axisX + radius * (1 - sqrt(2) / 2)
        let topLinePointLeftY: CGFloat = axisY + radius * (1 - sqrt(2) / 2)
        let topLinePointLeft: CGPoint = CGPointMake(topLinePointLeftX, topLinePointLeftY)
        
        let topLinePointRightX: CGFloat = layerSize.width - axisX - radius * (1 - sqrt(2) / 2)
        let topLinePointRightY: CGFloat = topLinePointLeftY
        let topLinePointRight: CGPoint = CGPointMake(topLinePointRightX, topLinePointRightY)
        
        let centerLinePointLeftX: CGFloat = axisX
        let centerLinePointLeftY: CGFloat = layerSize.height / 2
        let centerLinePointLeft: CGPoint = CGPointMake(centerLinePointLeftX, centerLinePointLeftY)
        
        let centerLinePointRightX: CGFloat = layerSize.width - axisX
        let centerLinePointRightY: CGFloat = centerLinePointLeftY
        let centerLinePointRight: CGPoint = CGPointMake(centerLinePointRightX, centerLinePointRightY)
        
        let bottomLinePointLeftX: CGFloat = topLinePointLeftX
        let bottomLinePointLeftY: CGFloat = layerSize.height - axisY - radius * (1 - sqrt(2) / 2)
        let bottomLinePointLeft: CGPoint = CGPointMake(bottomLinePointLeftX, bottomLinePointLeftY)
        
        let bottomLinePointRightX: CGFloat = topLinePointRightX
        let bottomLinePointRightY: CGFloat = bottomLinePointLeftY
        let bottomLinePointRight: CGPoint = CGPointMake(bottomLinePointRightX, bottomLinePointRightY)
        
        menuLineTop.path = bezierPathHorizontalLine(topLinePointLeft, endPoint: topLinePointRight).CGPath
        menuLineCenter.path = bezierPathHorizontalLine(centerLinePointLeft, endPoint: centerLinePointRight).CGPath
        menuLineBottom.path = bezierPathHorizontalLine(bottomLinePointLeft, endPoint: bottomLinePointRight).CGPath
        
        menuLineTop.strokeStart = 0.0
        menuLineTop.strokeEnd = 0.0
        
        menuLineCenter.strokeStart = 0.0 // (0.2929 / 2)  //  1 - sqrt(2)/2 = 0.2929
        menuLineCenter.strokeEnd = 1.0 // 1 - (0.2929 / 2 )
        
        menuLineBottom.strokeStart = 1.0
        menuLineBottom.strokeEnd = 1.0
        
        innerCircle.path = bezierPathCircle(radius / 4.5, centerX: centerX, centerY: centerY, startAngleDegree: 0, endAngleDegree: 360).CGPath
        innerCircle.fillColor = UIColor.whiteColor().CGColor
        innerCircleSolid.path = bezierPathCircle(radius / 4.5 / 3, centerX: centerX, centerY: centerY, startAngleDegree: 0, endAngleDegree: 360).CGPath
        innerCircleSolid.fillColor = color.CGColor
        
        
        //        halfCircleBlackLeft.hidden = true
        //        halfCircleBlackRight.hidden = true
        halfCircleRedLeft.hidden = true
        halfCircleRedRight.hidden = true
        halfCircleYellowLeft.hidden = true
        halfCircleYellowRight.hidden = true
        //
        //        menuLineTop.hidden = true
        //        menuLineCenter.hidden = true
        //        menuLineBottom.hidden = true
        
    }
    
    func reverseAnimation() {
        doAnimation(isReverse: true)
    }
    
    
    
    func changeColorWhenAnimationComplete() {
        
    }
    
    
    func doAnimation(isReverse isReverse: Bool = false) {
        var passedTime: CFTimeInterval = 0.0
        
        for sublayer in [halfCircleBlackLeft, halfCircleBlackRight, halfCircleRedLeft, halfCircleRedRight, halfCircleYellowLeft, halfCircleYellowRight] {
            
            let circleLineStrokeStartAnim = POPBasicAnimation(propertyNamed: kPOPShapeLayerStrokeStart)
            circleLineStrokeStartAnim.duration = 0.5
            circleLineStrokeStartAnim.toValue = isReverse ? 0.0 : 1.0
            if isReverse {
                circleLineStrokeStartAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.0, 0.88, 0.76, 1.0)
                circleLineStrokeStartAnim.beginTime = CACurrentMediaTime() + 0.49 + passedTime
            } else {
                circleLineStrokeStartAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.88, 0, 0.76, 1.0)
                circleLineStrokeStartAnim.beginTime = CACurrentMediaTime() + passedTime
            }
            sublayer.pop_addAnimation(circleLineStrokeStartAnim, forKey: "strokeStart")
            
            
            let circleLineRotationAnim = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
            
            circleLineRotationAnim.toValue = isReverse ? 0 : M_PI
            circleLineRotationAnim.duration = 0.5
            if isReverse {
                circleLineRotationAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.0, 0.88, 0.76, 1.0)
                circleLineRotationAnim.beginTime = (CACurrentMediaTime() + 0.5) + passedTime
            } else {
                circleLineRotationAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.88, 0, 0.76, 1.0)
                circleLineRotationAnim.beginTime = CACurrentMediaTime() + passedTime
            }
            sublayer.pop_addAnimation(circleLineRotationAnim, forKey: "rotation")
            
            
            switch sublayer {
            case halfCircleBlackRight:
                passedTime += 0.05
            case halfCircleRedLeft:
                circleLineStrokeStartAnim.animationDidStartBlock = {(pop) in
                    if isReverse {
                        self.halfCircleRedLeft.strokeColor = self.redColor.CGColor
                    } else {
                        self.halfCircleRedLeft.strokeColor = self.color.CGColor
                    }
                }
                
            case halfCircleRedRight:
                passedTime += 0.05
                circleLineStrokeStartAnim.animationDidStartBlock = {(pop) in
                    if isReverse {
                        self.halfCircleRedRight.strokeColor = self.redColor.CGColor
                    } else {
                        self.halfCircleRedRight.strokeColor = self.color.CGColor
                    }
                }
            case halfCircleYellowLeft:
                circleLineStrokeStartAnim.animationDidStartBlock = {(pop) in
                    if isReverse {
                        self.halfCircleYellowLeft.strokeColor = self.yellowColor.CGColor
                    } else {
                        self.halfCircleYellowLeft.strokeColor = self.color.CGColor
                    }
                }
                
            case halfCircleYellowRight:
                circleLineStrokeStartAnim.animationDidStartBlock = {(pop) in
                    if isReverse {
                        self.halfCircleYellowRight.strokeColor = self.yellowColor.CGColor
                    } else {
                        self.halfCircleYellowRight.strokeColor = self.color.CGColor
                    }
                }
            default:
                break
            }
            
        }
        
        let innerCircleScaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        innerCircleScaleAnim.toValue = isReverse ? NSValue(CGPoint: CGPointMake(1, 1)) : NSValue(CGPoint: CGPointMake(0.001, 0.001))
        innerCircleScaleAnim.duration = 0.3
        innerCircleScaleAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        innerCircleScaleAnim.beginTime = isReverse ? (CACurrentMediaTime() + 0.5) : CACurrentMediaTime()
        innerCircle.pop_addAnimation(innerCircleScaleAnim, forKey: "innerCircleScale")
        
        let innerCircleSolidScaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        innerCircleSolidScaleAnim.toValue = isReverse ?  NSValue(CGPoint: CGPointMake(1, 1)) : NSValue(CGPoint: CGPointMake(0.001, 0.001))
        innerCircleSolidScaleAnim.duration = 0.3
        innerCircleSolidScaleAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        innerCircleSolidScaleAnim.beginTime = isReverse ? (CACurrentMediaTime() + 0.5) : (CACurrentMediaTime() + 0.2)
        //                        strokeStartAnim.fillMode = kCAFillModeBackwards
        innerCircleSolid.pop_addAnimation(innerCircleSolidScaleAnim, forKey: "innerCircleSolidScale")
        
        let centerLineRotationAnim = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        centerLineRotationAnim.toValue = isReverse ? 0 : M_PI
        centerLineRotationAnim.duration = 0.5
        
        if isReverse {
            centerLineRotationAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.0, 0.88, 0.76, 1.0)
        } else {
            centerLineRotationAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.88, 0, 0.76, 1.0)
        }
        centerLineRotationAnim.beginTime = isReverse ? (CACurrentMediaTime() + 0.5) : CACurrentMediaTime()
        //                        strokeStartAnim.fillMode = kCAFillModeBackwards
        menuLineCenter.pop_addAnimation(centerLineRotationAnim, forKey: "centerLineRotation")
        
        
        let centerLineStrokeStartAnim = POPBasicAnimation(propertyNamed: kPOPShapeLayerStrokeStart)
        centerLineStrokeStartAnim.toValue = isReverse ? 0.0 : (0.2929 / 2)
        centerLineStrokeStartAnim.duration = 0.5
        centerLineStrokeStartAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        centerLineStrokeStartAnim.beginTime = isReverse ? (CACurrentMediaTime() + 0.5) : (CACurrentMediaTime())
        //                        strokeStartAnim.fillMode = kCAFillModeBackwards
        menuLineCenter.pop_addAnimation(centerLineStrokeStartAnim, forKey: "centerStrokeStart")
        
        let centerLineStrokeEndAnim = POPBasicAnimation(propertyNamed: kPOPShapeLayerStrokeEnd)
        centerLineStrokeEndAnim.toValue = isReverse ? 1.0 : (1.0 - 0.2929 / 2)
        centerLineStrokeEndAnim.duration = 0.5
        centerLineStrokeEndAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        centerLineStrokeEndAnim.beginTime = isReverse ? (CACurrentMediaTime() + 0.49) : (CACurrentMediaTime())
        menuLineCenter.pop_addAnimation(centerLineStrokeEndAnim, forKey: "centerStrokeEnd")
        
        
        let topLineStrokeEndAnim = POPBasicAnimation(propertyNamed: kPOPShapeLayerStrokeEnd)
        topLineStrokeEndAnim.toValue = isReverse ? 0.0 : 1.0
        topLineStrokeEndAnim.duration = 0.5
        if isReverse {
            topLineStrokeEndAnim.beginTime = CACurrentMediaTime()
            topLineStrokeEndAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.26, 0.22, 0.14, 1.0)
        } else {
            topLineStrokeEndAnim.beginTime = CACurrentMediaTime() + 0.6
            topLineStrokeEndAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.26, 0.22, 0.14, 1.0)
        }
        menuLineTop.pop_addAnimation(topLineStrokeEndAnim, forKey: "topStrokeEnd")
        
        let bootomLineStrokeStartAnim = POPBasicAnimation(propertyNamed: kPOPShapeLayerStrokeStart)
        bootomLineStrokeStartAnim.toValue = isReverse ? 1.0 : 0.0
        bootomLineStrokeStartAnim.duration = 0.5
        if isReverse {
            bootomLineStrokeStartAnim.beginTime = CACurrentMediaTime()
            bootomLineStrokeStartAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.26, 0.22, 0.14, 1.0)
        } else {
            bootomLineStrokeStartAnim.beginTime = CACurrentMediaTime() + 0.6
            bootomLineStrokeStartAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.26, 0.22, 0.14, 1.0)
        }
        menuLineBottom.pop_addAnimation(bootomLineStrokeStartAnim, forKey: "bottomStrokeStart")
        
    }
    


}
