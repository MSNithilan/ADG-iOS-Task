//
//  Players.swift
//  ADG task
//
//  Created by Suja C on 17/06/24.
//

//leaderboards struct

import SwiftUI

struct Player: Identifiable {
    var id:Int
    var name:String
}

//personal best struct

struct PB: Identifiable{
    var id:Int
    var pts:Int
}
