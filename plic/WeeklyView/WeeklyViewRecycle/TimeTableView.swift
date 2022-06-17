//
//  TimeTableView.swift
//  plic
//
//  Created by 이주화 on 2022/06/14.
//

import SwiftUI

struct TimeTableView: View {
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    let width: CGFloat = 60.0
    let coupleWidth: CGFloat = 210.0
    var height: CGFloat = 43.0
    let schedule: Schedule
    
    var body: some View {
        NavigationLink(destination: DetailScheduleView(schedule: schedule)){
            if(scheduleAdaptor(schedules: schedule) == 2){
                VStack{
                    HStack{
                        Text(schedule.title)
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                            .foregroundColor(Color("plicTimeyellow"))
                            .padding(.top, 5)
                            .padding(.leading, 5)
                        Spacer()
                    }
                    
                    Spacer()
                }
                .frame(width: width, height: height * CGFloat(dateToFloat(schedule.endDate)-dateToFloat(schedule.startDate)))
                .background(Color("plicYellow"))
                .cornerRadius(3)
            }else if(scheduleAdaptor(schedules: schedule) == 1){
                VStack{
                    HStack{
                        Text(schedule.title)
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                            .foregroundColor(Color("plicPink"))
                            .padding(.top, 5)
                            .padding(.leading, 5)
                        Spacer()
                    }
                    
                    Spacer()
                }
                .frame(width: coupleWidth, height: height * CGFloat(dateToFloat(schedule.endDate)-dateToFloat(schedule.startDate)))
                .background(Color("plicTimepink"))
                .cornerRadius(3)
            }else if(scheduleAdaptor(schedules: schedule) == 0){
                VStack{
                    HStack{
                        Text(schedule.title)
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                            .foregroundColor(Color("plicNavy"))
                            .padding(.top, 5)
                            .padding(.leading, 5)
                        Spacer()
                    }

                    Spacer()

                }
                .frame(width: width, height: height * CGFloat(dateToFloat(schedule.endDate)-dateToFloat(schedule.startDate)))
                .background(Color("plicTimeblue"))
                .cornerRadius(3)
            }
        }
    }
    func scheduleAdaptor(schedules: Schedule) -> Int {
        
        var whoesSchedule: Int = -1
        
        if schedules.isCoupleSchedule {
            whoesSchedule = 2
        } else {
            if (schedules.createdUserId == coupleViewModel.root?.creatorUserRecordID?.recordName) {
                whoesSchedule = 1
            } else {
                whoesSchedule = 0
            }
        }
        
        return whoesSchedule
    }
    func dateToFloat(_ date: Date) -> Float {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            let hour = formatter.string(from: date)
            
            formatter.dateFormat = "mm"
            let min = formatter.string(from: date)
            
            return (hour as NSString).floatValue + (min as NSString).floatValue / 60.0
    }
            
}


//func overFour(num: Float) -> Int {
//    @Binding num: Float
//    var a = Int(num)
//
//    if a > 4 {
//        a == 4
//        return a
//    }
//}
