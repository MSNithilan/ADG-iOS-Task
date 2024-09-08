//
//  HomeView.swift
//  CutyCard
//
//  Created by Suja C on 08/09/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            BackgroundView()
            VStack() {
                Header()
                    .padding(.top,40)
                    .padding(.bottom,0)
                CoinInfo()
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20,height: 10)
                    .padding(.top)
                    .padding(.bottom,-80)
                Image("creditcard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 320, height: 300)
                    .padding(.bottom, -40)
                Footer()
                
            }
        }
        .ignoresSafeArea()
        
    }
        
}

#Preview {
    HomeView()
}

struct BackgroundView: View{
    let bgc2 = #colorLiteral(red: 0.9735880494, green: 0.9078813195, blue: 0.937294066, alpha: 1)
    let bgc3 = #colorLiteral(red: 0.9913429618, green: 0.9622896314, blue: 0.9371775985, alpha: 1)
    let bgc1 = #colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.7960784314, alpha: 1)
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(bgc1), Color(bgc2), Color(bgc3), Color(bgc3)]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}

struct Header: View {
    var body: some View {
 VStack {
     HStack {
         Circle()
             .fill(Color.white)
             .frame(width: 50)
         Spacer()
         Text("Add Credit")
             .font(.callout)
             .foregroundStyle(.white)
             .frame(width: 105, height: 40)
             .background(Color.black)
             .background(in: RoundedRectangle(cornerRadius: 25))
             
         Spacer()
         Circle()
             .fill(Color.white)
             .frame(width: 50)
     }
     .padding(20)
        }
    }
}

struct CoinInfo: View {
    var body: some View {
        Image("icon")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 100)
        Text("0,00080 BTC")
            .font(.system(size: 40))
            .padding(.bottom,10)
        Text("[086X...05TX]")
            .font(.footnote)
    }
}

struct Footer: View {
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(.white)
                .opacity(0.9)
                .frame(width: 380, height: 240)
                .padding(.bottom)
            VStack(alignment: .center){
                Text("Add Some Credit To Your Card")
                    .font(.system(size: 35))
                    .multilineTextAlignment(.center)
                    .padding(.leading,60)
                    .padding(.trailing,60)
                Text("Generally Add A Debit Or Credit Card On Your Own Card Or Wallet.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.leading,70)
                    .padding(.trailing,70)
                    .padding(.top,-10)
                    .padding(.bottom,20)
                    .foregroundStyle(.gray)
                HStack(spacing: 45){
                    Image(systemName: "arrow.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    Text("8,969.00 Euro")
                        .font(.system(size: 23))
                        .padding(.bottom)
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                }
                .padding(.bottom)
            }
        }
        
    }
}
