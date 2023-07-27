//
//  Menu.swift
//  SwiftUIFoodOrderingApp
//
//  Created by ipeerless on 27/07/2023.
//

import SwiftUI

struct Menu: View {
    @ObservedObject var homeData : HomeViewModel
    var body: some View {
        VStack {
            Button {} label: {
            Image(systemName: "cart")
                .font(.title)
                .foregroundColor(Color.pink)
            Text("Cart")
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer(minLength: 0)
        }
            
            Spacer()
            HStack {
                Spacer()
                Text("Version 0.1")
                    .fontWeight(.bold)
                    .foregroundColor(Color.pink)
            }
            .padding(10)
            

        }
        .padding([.top, .trailing])
        .frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.white.ignoresSafeArea())
        
    }
}


