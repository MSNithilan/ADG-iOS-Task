//
//  ContentView.swift
//  ADG task
//
//  Created by Suja C on 16/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Homescreen()
                .tabItem {
                    Image(systemName: "hand.point.up.left")
                    Text("Game")
                }
            Leaderboard(playersToDisplay: playerList)
                .tabItem {
                    Image(systemName: "list.number")
                    Text("Leaderboards")
                }
            PersonalBest(scoresToDisplay: PBList)
                .tabItem {
                    Image(systemName: "trophy")
                    Text("Personal Best")
                }
            
        }
        
    }
}

#Preview {
    ContentView()
}
