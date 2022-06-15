//
//  DetailScheduleView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/10.
//

import SwiftUI

struct DetailScheduleView: View {
    
    @Binding var scheduleName: String
    @Binding var allDayToggle: Bool
    @Binding var timeStart: Date
    @Binding var timeEnd: Date
    @Binding var noteContent: String
    @Binding var whoSchedule: String
    
    
    var body: some View {
        NavigationView{
            Text("뷰 들어갈 곳")
            //네비게이션 설정 (임의로 ContentView)
                .navigationBarTitle("세부 일정", displayMode: .inline)
                .navigationBarItems(
                    leading: NavigationLink(destination: ContentView(), label: {
                        Image(systemName: "chevron.left")
                        Text("오늘의 일정")
                            .font(Font.custom("SpoqaHanSansNeo-Regular", size: 16))
                            .offset(x: -5)
                    }),
                    trailing: NavigationLink(destination: ContentView(), label: {
                        Text("Edit")
                            .font(Font.custom("SpoqaHanSansNeo-Regular", size: 16))
                    })
                )
                .accentColor(Color("plicPink"))
        }
    }
}

//struct DetailScheduleView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailScheduleView()
//    }
//}
