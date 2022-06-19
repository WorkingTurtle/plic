//
//  MainView.swift
//  plic
//
//  Created by 이주화 on 2022/06/13.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView{
                    VStack(spacing: 0){
                            Image("TabMain2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .ignoresSafeArea(.all)
                                .frame(height: 160)
                                .padding(0)
                        
                            VStack{
                                HStack{
                                    CalendarView()
                                        .padding(.horizontal, 8)
                                }
                                    .padding(.bottom,20)
                                Divider()
                                HStack{
//                                    WeeklyTimeTable()
                                    MainTimeTableView()
                                }
//                                    .padding(.top,20)
                                HStack{
                                   
                                }.frame(height: 70)
                                    .padding(.top,20)
                            }
                        }
                }
            }
            .ignoresSafeArea()
            .onAppear(){
                coupleViewModel.fetchSchedules() {
                }
            }
        }
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
