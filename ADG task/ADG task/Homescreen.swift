//
//  Homescreen.swift
//  ADG task
//
//  Created by Suja C on 17/06/24.
//

import SwiftUI

struct Homescreen: View {
    @State var count = 0
    var body: some View {
        VStack {
            Spacer()
            Text("Cookie Clicker")
                .bold()
                .font(.largeTitle)
            Spacer()
            Text(String(count))
                .font(.largeTitle)
            Spacer()
            //increment function
            Button("Click Here!") {
                Increment()
            }
            .font(.title2)
            Spacer()
            //reset function
            Button("Reset") {
                reset()
            }.foregroundStyle(.red)
                .font(.title2)
            Spacer()
            Spacer()
        }
    }
    func Increment(){
        count+=1
    }
    func reset(){
        count=0
    }
}

#Preview {
    Homescreen()
}
