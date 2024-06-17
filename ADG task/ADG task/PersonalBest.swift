//
//  PersonalBest.swift
//  ADG task
//
//  Created by Suja C on 17/06/24.
//

import SwiftUI

struct PersonalBest: View {
    var scoresToDisplay: [PB]
    var body: some View {
        NavigationView{
            List(scoresToDisplay){
                score in PBRow(eachPB: score)
            }.navigationTitle(Text("Personal Bests"))
        }
    }
}

struct PBRow: View {
    var eachPB: PB
    var body: some View{
        HStack{
            Text(String(eachPB.id)+")")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .padding(5.0)
            Spacer()
            Text(String(eachPB.pts))
                .font(.title3)
            Spacer()
        }
    }
}

var PBList=[
    PB(id: 1, pts: 250),
    PB(id: 2, pts: 240),
    PB(id: 3, pts: 220),
    PB(id: 4, pts: 200),
    PB(id: 5, pts: 190),
    PB(id: 6, pts: 180),
    PB(id: 7, pts: 175),
    PB(id: 8, pts: 172),
    PB(id: 9, pts: 171),
    PB(id: 10, pts: 155),
]

#Preview {
    PersonalBest(scoresToDisplay:PBList)
}
