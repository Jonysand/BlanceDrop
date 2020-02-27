//
//  ContentView.swift
//  DropGame
//
//  Created by Yongkun Li on 2/26/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack{
            gameScene()
                .blur(radius: self.gameManager.gameStarted ? 0:10)
                .animation(.easeInOut)
            InfoView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let gameManager = GameManager()
    static var previews: some View {
        ContentView().environmentObject(gameManager)
    }
}
