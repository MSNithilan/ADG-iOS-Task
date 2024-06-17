//
//  Leaderboard.swift
//  ADG task
//
//  Created by Suja C on 17/06/24.
//

import SwiftUI

struct Leaderboard: View {
    var playersToDisplay: [Player]
    var body: some View {
        NavigationView{
            List(playersToDisplay){
                player in ListRow(eachPlayer: player)
            }.navigationTitle(Text("Leaderboards"))
        }
    }
}

struct ListRow: View {
    var eachPlayer: Player
    var body: some View{
        HStack{
            Image(systemName: "person.fill")
                .padding(.vertical, 15)
            Text(eachPlayer.name)
            Spacer()
            Text("100 pts")
        }
    }
}

var playerList=[
    Player(id: 1, name: "Abe"),
    Player(id: 2, name: "Ben"),
    Player(id: 3, name: "Cathy"),
    Player(id: 4, name: "Don"),
    Player(id: 5, name: "Earl"),
    Player(id: 6, name: "Finn"),
    Player(id: 7, name: "Garry"),
    Player(id: 8, name: "Han"),
    Player(id: 9, name: "Ian"),
    Player(id: 10, name: "Jack"),
]

#Preview {
    Leaderboard(playersToDisplay : playerList)
}
