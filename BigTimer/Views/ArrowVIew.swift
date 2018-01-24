//
//  ArrowVIew.swift
//  BigTimer
//
//  Created by Joel Klabo on 1/23/18.
//  Copyright © 2018 Joel Klabo. All rights reserved.
//

import UIKit

class ArrowView: UIView {
    
    enum Direction {
        case down
        case up
    }

    let zRotationKeyPath = "transform.rotation.z"
    
    var lineColor = Theme.lineColor()
    var lineWidth = Theme.lineWidth()
    
    fileprivate var arrowDirection: Direction = .up
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isOpaque = false
    }
    
    override func draw(_ rect: CGRect) {
        
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
        }
        
        lineColor.setStroke()
        
        let rect = rect.insetBy(dx: lineWidth, dy: lineWidth)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.stroke()
        
    }
    
    func changeDirection (_ direction: Direction) {

        if (arrowDirection == direction) {
            return
        } else {
            arrowDirection = direction
        }

        if (arrowDirection == .up) {
            self.transform = CGAffineTransform(rotationAngle: 0)
            let rotateAnimation = CABasicAnimation(keyPath: zRotationKeyPath)
            rotateAnimation.duration = 0.2
            rotateAnimation.fromValue = M_PI
            rotateAnimation.toValue = 0
            self.layer.add(rotateAnimation, forKey: "rotation")
        } else {
            self.layer.setValue(M_PI, forKey: zRotationKeyPath)
            self.transform = CGAffineTransform(rotationAngle: 3.14)
            let rotateAnimation = CABasicAnimation(keyPath: zRotationKeyPath)
            rotateAnimation.duration = 0.2
            rotateAnimation.fromValue = 0
            rotateAnimation.toValue = M_PI
            self.layer.add(rotateAnimation, forKey: "rotation")
        }

    }
}
