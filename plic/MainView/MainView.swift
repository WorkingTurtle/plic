//
//  MainView.swift
//  plic
//
//  Created by 이주화 on 2022/06/13.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack{
            Image("MainTab")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 170)
                .ignoresSafeArea(.all)
            VStack(spacing: 0){
                HStack{
                    
                }.frame(height: 100)
                    .padding(0)
                HStack{
                    CalendarView()
                }.frame(height: 360)
                    .padding(.bottom,10)
                    Divider()
                HStack{
                    MainTimeTableView()
                }.frame(height: 230)
                    .padding(.top,10)
            }
        }
        .navigationBarHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
