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
            // cookie clicker home screen
            Homescreen()
                .tabItem {
                    Image(systemName: "hand.point.up.left")
                    Text("Game")
                }
            //leaderboard page
            Leaderboard(playersToDisplay: playerList)
                .tabItem {
                    Image(systemName: "list.number")
                    Text("Leaderboards")
                }
            //personal best page
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
