//
//  ShakableViewController.swift
//  EggTimer
//
//  Created by Yongkun Li on 2/15/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreMotion
import CoreHaptics

class motionManager{
    private let motion = CMMotionManager()
    
    private var timer: Timer?
    
    // User gyroscope data
    public var Gx: Double?
    public var Gy: Double?
    
    init() {
        // Initialize device motion
        guard self.motion.isAccelerometerAvailable else {return}
        self.motion.startAccelerometerUpdates(to: .main, withHandler: {data, error in
            self.Gx = data?.acceleration.x
            self.Gy = data?.acceleration.y
        })
    }
}
