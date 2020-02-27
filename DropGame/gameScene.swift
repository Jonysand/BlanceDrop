//
//  gameScene.swift
//  DropGame
//
//  Created by Yongkun Li on 2/26/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct gameScene: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack{
            // target ring
            Circle()
                .stroke(lineWidth: 10)
                .offset(gameManager.targetPosition)
                .frame(width: gameManager.targetR*2, height: gameManager.targetR*2)
                .foregroundColor(gameManager.isInBound ? Color.green:Color.red)
            
            // player dot
            Circle()
                .offset(gameManager.playerPosition)
                .frame(width: gameManager.playerR*2, height: gameManager.playerR*2)
            
            // stop tap, to lower the difficulty
            Button(action: {
                self.gameManager.playerVelocityX = 0
                self.gameManager.playerVelocityY = 0
                }
            ){ Color.clear.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)}
                .opacity(self.gameManager.gameStarted ? 1:0)
        }.animation(nil)
    }
}

struct gameScene_Previews: PreviewProvider {
    static let gameManager = GameManager()
    static var previews: some View {
        gameScene().environmentObject(gameManager)
    }
}
