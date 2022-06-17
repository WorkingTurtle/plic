//
//  DetailScheduleView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/10.
//

import SwiftUI

struct DetailScheduleView: View {
    let testSchedule: DumyTime
//
//    @Binding var scheduleName: String
////    @Binding var allDayToggle: Bool
//    @Binding var timeStart: Date
//    @Binding var timeEnd: Date
////    @Binding var noteContent: String
//    @Binding var whoSchedule: String
    
    
    var body: some View {
        
        NavigationView{            
            VStack{
                VStack{
                    MiniTimeTableView(testSchedule: testSchedule)
                }.frame(height: 200)
                    .padding(.horizontal, 20)
                HStack{
                    DetailViewTime(startTime: "\(testSchedule.startTime)", endTime: "\(testSchedule.endTime)")
                }
                HStack{
                    DetailViewMemo()
                }
                
                
                
            }
            
            //네비게이션 설정 (임의로 ContentView)
                .navigationBarTitle("상세 정보", displayMode: .inline)
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
