//
//  DetailScheduleView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/10.
//

import SwiftUI

struct DetailScheduleView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var showAddScheduleModal = false
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    var schedule: Schedule
    
    var body: some View {
        VStack{
            VStack{
                HStack(spacing: 0){
                    Text("\(schedule.title)")
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                    Spacer()
                    Text("\(OwnerOfSchedule(num: scheduleAdaptor(schedules: schedule)))")
                        .foregroundColor(Color(TextColor(num: scheduleAdaptor(schedules: schedule))))
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 9)
                        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color(BoxColor(num: scheduleAdaptor(schedules: schedule)))))
                }
                .padding(.bottom, 14)
                
                Divider()
                MiniTimeTableView(schedule: schedule)
            }.frame(height: 200)
                .padding(.horizontal, 20)
            HStack{
                DetailViewTime(startTime: dateToTime(schedule.startDate), endTime: dateToTime(schedule.endDate), startDate: dateToDate(schedule.startDate), endDate: dateToDate(schedule.endDate))
            }
            HStack{
                DetailViewMemo(schedule: schedule)
            }
        }
        .navigationTitle("상세 정보")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            self.showAddScheduleModal = true
        }){
            Text("Edit")
                .font(.custom("SpoqaHanSansNeo-Regular",size: 17))
                .foregroundColor(Color("plicPink"))
        }.sheet(isPresented: self.$showAddScheduleModal){
            EditSchedule(schedule: schedule)
        })
        .accentColor(Color("plicPink"))
//        let schedule: Schedule = Schedule(title: "", description: "", startDate: Date(), endDate: Date(), isAllDaySchedule: false, isCoupleSchedule: false, isSpecialDay: false)
//        @State var scheduleName: String = ""
//        @State var allDayToggle: Bool = false
//        @State var timeStart = Date()
//        @State var timeEnd = Date()
//        @State var noteContent: String = "메모를 작성해 주세요"
//        @State var whoSchedule = "함께"
                            
    }
    func scheduleAdaptor(schedules: Schedule) -> Int {
        
        var whoesSchedule: Int = -1
        
        if schedules.isCoupleSchedule {
            whoesSchedule = 1
        } else {
            if (schedules.createdUserId == coupleViewModel.root?.creatorUserRecordID?.recordName) {
                whoesSchedule = 0
            } else {
                whoesSchedule = 2
            }
        }
        
        return whoesSchedule
    }
    func dateToTime(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"

            let date = formatter.string(from: date)
            
            return date
    }
    func dateToDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY.MM.dd"

            let date = formatter.string(from: date)
            
            return date
    }
}

//struct DetailScheduleView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailScheduleView()
//    }
//}


func OwnerOfSchedule(num: Int) -> String {
    var owner: String = ""
    
    if num == 2 {
        owner = "디기"
    } else if num == 1 {
        owner = "함께"
    } else if num == 0{
        owner = "뱃저"
    }
    return owner
}

func BoxColor(num: Int) -> String {
    var colorBox: String = ""
    
    if num == 2 {
        colorBox = "plicYellow"
    } else if num == 1 {
        colorBox = "plicPeach"
    } else if num == 0{
        colorBox = "plicSky"
    }
    return colorBox
}

func TextColor(num: Int) -> String {
    var textColor: String = ""
    
    if num == 2 {
        textColor = "plicTimeyellow"
    } else if num == 1 {
        textColor = "plicPink"
    } else if num == 0{
        textColor = "plicNavy"
    }
    return textColor
}
