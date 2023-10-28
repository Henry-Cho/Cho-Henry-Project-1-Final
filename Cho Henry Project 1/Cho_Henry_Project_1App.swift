//
//  Cho_Henry_Project_1App.swift
//  Cho Henry Project 1
//
//  Created by Henry Cho on 10/16/23.
//

import SwiftUI

@main
struct Cho_Henry_Project_1App: App {
    var game = SetGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(setGame: game)
        }
    }
}
