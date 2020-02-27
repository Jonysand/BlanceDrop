//
//  InfoView.swift
//  DropGame
//
//  Created by Yongkun Li on 2/26/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        ZStack{
            VStack{
                Text("Score: \(self.gameManager.timeInBound/60)")
                Text("Time Available Left: \(self.gameManager.timeNotInBoundLeft/60)")
                Spacer()
                Button(action: {
                    self.gameManager.reset()
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 50)
                        Text(self.gameManager.gameEnded ? "Restart!":"Start!")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }.frame(width: 160, height: 80)
                }.opacity(self.gameManager.gameStarted ? 0:1)
            }
            
            Text("Game Over!")
                .font(.largeTitle)
                .opacity(self.gameManager.gameEnded ? 1:0)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static let gameManager = GameManager()
    static var previews: some View {
        InfoView().environmentObject(gameManager)
    }
}
