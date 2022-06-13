//
//  TapBarMainView.swift
//  plic
//
//  Created by 이주화 on 2022/06/13.
//

import SwiftUI

struct TapBarMainView: View {
    init(tabbarIndex: Int) {
        
        UITabBar.appearance().backgroundColor = UIColor(Color("plicWhite"))
        
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("plicGrey"))

        self.tabbarIndex = tabbarIndex
    }

    @State var tabbarIndex : Int = 0
    
    var body: some View {
        TabView(selection: $tabbarIndex){

            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    
                    Text("일정")
                   
                }.tag(0)
            
            AddSchedule()
                .tabItem {
                    Image(systemName: "heart.text.square.fill")
                    Text("목표")
                }.tag(1)
            
            DetailScheduleView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("설정")
                }.tag(2)
            
            
        }
        .accentColor(Color("plicPink"))
    }
}
