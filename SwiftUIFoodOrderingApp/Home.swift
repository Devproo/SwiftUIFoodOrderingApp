//
//  Home.swift
//  SwiftUIFoodOrderingApp
//
//  Created by ipeerless on 27/07/2023.
//

import SwiftUI

struct Home: View {
    @StateObject var HomeModel = HomeViewModel()
    var body: some View {
        ZStack {
            VStack(spacing:10) {
                HStack(spacing: 15) {
                    Button {
                        withAnimation(.easeIn) {
                            HomeModel.showMenu.toggle()
                        }
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.pink)
                    }
                    
                    
                    
                    
                    Text(HomeModel.userLocation  == nil ? "Loading...." : "Deliver To")
                        .foregroundColor(.black)
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.pink)
                    
                    Spacer()
                }
                .padding([.horizontal, .top])
                
                Divider()
                
                HStack(spacing: 15) {
                   
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                       
                    
                    TextField("Search", text: $HomeModel.search)
                    
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
                
                ScrollView (.vertical, showsIndicators: false){
                    VStack {
                        ForEach(HomeModel.filtered) { item in
                        
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .center) ) {
                                ItemView(item: item)
                                    
                                HStack {
                                    Text("Free Delivery")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal)
                                        .background(.pink)
                                    
                                    Spacer(minLength: 0)
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(.pink)
                                            .clipShape(Circle())
                                    }
                                    .padding(.trailing, 10)
                                    .padding(.top, 10)

                                }
                            }
                            .frame(width: UIScreen.main.bounds.width  - 30)
                        }
                        
                    }
                    .padding(.top, 10)
                }
            }
            
            HStack {
                Menu(homeData: HomeModel)
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6, y: 10.0)
                
                Spacer(minLength: 0)
                
            }
            .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea())
            .onTapGesture {
                withAnimation(.easeIn) {
                    HomeModel.showMenu.toggle()
                }
            }
            
            if HomeModel.noLocation {
                Text("Plz enable location access")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
        }
            .onAppear() {
                HomeModel.locationManager.delegate = HomeModel
               
        
        }
            .onChange(of: HomeModel.search) { value in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if value == HomeModel.search && HomeModel.search != ""{
                        
                    }
                }
                if HomeModel.search == "" {
                    withAnimation(.linear) {
                        HomeModel.filtered = HomeModel.items
                    }
                }
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
