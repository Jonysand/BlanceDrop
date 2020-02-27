//
//  GameManager.swift
//  DropGame
//
//  Created by Yongkun Li on 2/26/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class GameManager: ObservableObject{
    @Published var gameStarted: Bool = false
    @Published var gameEnded: Bool = false
    @Published var playerPosition: CGSize
    @Published var targetPosition: CGSize
    
    @Published var isInBound: Bool = true
    let playerR: CGFloat;
    @Published var targetR: CGFloat;
    let WindowSize = UIScreen.main.bounds
    var score = 0
    
    var MM = motionManager()
    var playerVelocityX:CGFloat = 0
    var playerVelocityY:CGFloat = 0
    var targetAccelerationX:CGFloat = 0
    var targetAccelerationY:CGFloat = 0
    var targetVelocityX:CGFloat = 0
    var targetVelocityY:CGFloat = 0
    
    var timer: Timer?
    var timerCount = 0;
    
    // difficulty setting
    var timeNotInBoundLeft = 30 * 60
    var timeInBound = 0
    let targetShrinkRate:CGFloat = 0.01
    let targetVelocityUpdateInterval =  60
    
    init() {
        playerPosition = .init(width: 0, height: 0)
        targetPosition = .init(width: 0, height: 0)
        playerR = min(WindowSize.width, WindowSize.height)/20
        targetR = min(WindowSize.width, WindowSize.height)/4
        
        self.timer = Timer(fire: Date(), interval: (1.0/60.0),
                           repeats: true,
                           block:self.loop)
        RunLoop.current.add(self.timer!, forMode: .default)
    }
    
    func reset(){
        isInBound = true
        score = 0
        playerVelocityX = 0
        playerVelocityY = 0
        targetAccelerationX = 0
        targetAccelerationY = 0
        targetVelocityX = 0
        targetVelocityY = 0
        timerCount = 0
        timeNotInBoundLeft = 30 * 60
        timeInBound = 0
        playerPosition = .init(width: 0, height: 0)
        targetPosition = .init(width: 0, height: 0)
        targetR = min(WindowSize.width, WindowSize.height)/4
        gameStarted = true
        gameEnded = false
    }
    
    func loop(timer: Timer){
        if (gameStarted){
            
            // update player's velocity and position
            playerVelocityX += CGFloat(MM.Gx ?? 0)/8
            playerVelocityY += -CGFloat(MM.Gy ?? 0)/8
            playerPosition.width += playerVelocityX
            playerPosition.height += playerVelocityY
            if (playerPosition.width < -WindowSize.width/2+playerR) {
                playerPosition.width = -WindowSize.width/2+playerR
                playerVelocityX *= -1;
            }
            if (playerPosition.height < -WindowSize.height/2+playerR) {
                playerPosition.height = -WindowSize.height/2+playerR
                playerVelocityY *= -1;
            }
            if (playerPosition.width > WindowSize.width/2-playerR) {
                playerPosition.width = WindowSize.width/2-playerR
                playerVelocityX *= -1;
            }
            if (playerPosition.height > WindowSize.height/2-playerR) {
                playerPosition.height = WindowSize.height/2-playerR
                playerVelocityY *= -1;
            }
            
            // target size shrinks
            if(targetR > playerR + 10) {targetR -= targetShrinkRate}
            
            // update target's velocity and postition
            if(timerCount > targetVelocityUpdateInterval) {
                targetAccelerationX = CGFloat.random(in: -0.01...0.01)
                targetAccelerationY = CGFloat.random(in: -0.01...0.01)
                timerCount=0
            }
            targetVelocityX += targetAccelerationX
            targetVelocityY += targetAccelerationY
            
            if targetVelocityX > 3 { targetVelocityX = 3 }
            
            targetPosition.width += targetVelocityX
            targetPosition.height += targetVelocityY
            if (targetPosition.width < -WindowSize.width/2+targetR) {
                targetPosition.width = -WindowSize.width/2+targetR
                targetVelocityX *= -1;
            }
            if (targetPosition.height < -WindowSize.height/2+targetR) {
                targetPosition.height = -WindowSize.height/2+targetR
                targetVelocityY *= -1;
            }
            if (targetPosition.width > WindowSize.width/2-targetR) {
                targetPosition.width = WindowSize.width/2-targetR
                targetVelocityX *= -1;
            }
            if (targetPosition.height > WindowSize.height/2-targetR) {
                targetPosition.height = WindowSize.height/2-targetR
                targetVelocityY *= -1;
            }
            
            if (pow(playerPosition.width-targetPosition.width, 2)+pow(playerPosition.height-targetPosition.height, 2))>pow(targetR, 2){
                isInBound = false
            }else{
                isInBound = true
            }
            
            timerCount += 1
            
            // score
            if (!isInBound) { timeNotInBoundLeft -= 1}
            else { timeInBound += 1 }
            if(timeNotInBoundLeft <= 0) {
                gameStarted = false
                gameEnded = true
            }
        }
    }
}
