//
//  MiniTimeTableView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/16.
//

import SwiftUI


struct MiniTimeTableView: View {
    let schedule: Schedule
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    @EnvironmentObject var currentDate: DateData
                                         
    var currentTimeArr: [Int] = [0, 1, 2, 3]
    
    var body: some View {
        ZStack(alignment: .top){
            HStack{
                VStack{
                    ForEach(currentTimeArr, id: \.self) { x in
                        Text("\(Int(timeTostring(schedule.startDate))! + x):00")
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                            .foregroundColor(Color("plicTime"))
                            .frame(height: 10)
                            .padding(.bottom, 25)
                    }
                }
                
                Spacer()
                
                VStack{
                    ForEach(currentTimeArr, id: \.self){ item in
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .frame(height: 10)
                            .foregroundColor(Color("plicLine"))
                            .padding(.bottom, 25)
                    }
                }.padding(.top, 11)
            }
            
                VStack{
                    if(scheduleAdaptor(schedules: schedule) == 2){
                        DetailTimeTableView(schedule: schedule)
//                            .padding(.top, CGFloat((testSchedule.startTime - 9) * 43))
                            .offset(x: -60, y: CGFloat((dateToFloat(schedule.startDate) - dateToTime(schedule.startDate)) * 43))
                    }
                    else if(scheduleAdaptor(schedules: schedule) == 1){
                        DetailTimeTableView(schedule: schedule)
                            .offset(x: 15, y: CGFloat((dateToFloat(schedule.startDate) - dateToTime(schedule.startDate)) * 43))
//                            .padding(.top, CGFloat((testSchedule.startTime - 9) * 43))
                    }
                    else
                    {
                        DetailTimeTableView(schedule: schedule)
                            .offset(x: 90, y: CGFloat((dateToFloat(schedule.startDate) - dateToTime(schedule.startDate)) * 43))
//                            .padding(.top, CGFloat((testSchedule.startTime - 1.3) * 43))
                    }
                    Spacer()
                }.padding(.top, 10)

        }
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
    func timeTostring(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            let hour = formatter.string(from: date)
            
            return hour
    }
    func dateToFloat(_ date: Date) -> Float {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            let hour = formatter.string(from: date)
            
            formatter.dateFormat = "mm"
            let min = formatter.string(from: date)
            
            return (hour as NSString).floatValue + (min as NSString).floatValue / 60.0
    }
    func dateToTime(_ date: Date) -> Float {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            let hour = formatter.string(from: date)
            
            
            
            return (hour as NSString).floatValue
    }
}

//struct MiniTimeTableView_Previews: PreviewProvider {
//    static var previews: some View {
//        MiniTimeTableView()
//    }
//}
