//
//  PanGestureInfoProviding.swift
//  Big Timer
//
//  Created by Joel Klabo on 4/26/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import UIKit

protocol PanGestureInfoReceiving {
    func verticalPanInfo(velocity: Double, translation: Double)
    func verticalPan(sender: AnyObject)
}

extension PanGestureInfoReceiving where Self: UIViewController {
    func verticalPan(sender: AnyObject) {
        let gestureRecognizer = sender as! UIPanGestureRecognizer
        let velocity = -gestureRecognizer.velocity(in: view).y
        let translation = -gestureRecognizer.translation(in: view).y
        verticalPanInfo(velocity: Double(velocity), translation: Double(translation))
    }
}
