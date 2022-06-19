//
//  MainTimeTableView.swift
//  plic
//
//  Created by 이주화 on 2022/06/13.
//

import SwiftUI

struct MainTimeTableView: View {
    @EnvironmentObject var currentDate: DateData
    @State var currentMonth: Int = 0
    var month: String = "6"
    var day: String = "23"
    let firstNick: String = "디기"
    let secondNick: String = "벳져"
    
    var body: some View {
        VStack{
            HStack{
                MainTimeTableTitleView(month: extraData(currentDate.currentDate)[1], day: extraData(currentDate.currentDate)[0])
            }
            .padding(.bottom, 10)
            .padding([.leading,.trailing], 30)
            .padding(.top, 25)
            HStack{
                TimeTableNameView(firstNick: firstNick, secondNick: secondNick)
            }.padding([.leading,.trailing], 90)
                .padding(.leading, 20)
            HStack{
                TimeTableMiniView()
            }.padding([.leading,.trailing], 30)
        }
        
        .background(Color.white)
        .cornerRadius(0)
        .shadow(color: Color("plicLightgrey"), radius: 5)
        
        
        .frame(height: 230)
    }
    
    func extraData(_ currentDate: Date) -> [String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd M"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
}

struct MainTimeTableView_Previews: PreviewProvider {
    static var previews: some View {
        MainTimeTableView()
    }
}

struct MainTimeTableTitleView: View {
    let month: String
    let day: String
    
    var body: some View {
        HStack{
            Text("\(month)월 \(day)일의 일정")
                .font(.custom("SpoqaHanSansNeo-Bold",size: 16))
                .foregroundColor(Color("plicBlack"))
            Spacer()
            NavigationLink(destination: WeeklyView(), label: {
            Image(systemName: "chevron.right")
                .font(.custom("SpoqaHanSansNeo-Bold",size: 16))
                .foregroundColor(Color("plicGrey"))
            })
        }
    }
}

struct TimeTableNameView: View {
    let firstNick: String
    let secondNick: String
    
    var body: some View {
        HStack{
            Text(firstNick)
                .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                .foregroundColor(Color("plicTime"))
            Spacer()
            Image(systemName: "heart.fill")
                .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                .foregroundColor(Color("plicPink"))
            Spacer()
            Text(secondNick)
                .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                .foregroundColor(Color("plicTime"))
        }
    }
}

struct TimeTableMiniView : View {
    var currentTimeArr: [Int] = [0, 1, 2, 3]
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    @EnvironmentObject var currentDate: DateData
    var currentTime: Date = Date()
    

    
    static let HourDateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }()
    
    
    var body: some View {
        ZStack(alignment: .top){
            HStack{
                VStack{
                    
                    //    ForEach를 써서 (x * 60초 * 60초)를 사용. x를 i라 생각하고 사용
                    //    자동으로 배열에 담아주는 ForEach문 생성
                    
                    ForEach(currentTimeArr, id: \.self) { x in
                        let timeTableSinceNow = Date(timeIntervalSinceNow: TimeInterval(x * 60 * 60))
                        Text("\(timeTableSinceNow, formatter: TimeTableMiniView.HourDateformat):00")
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
            
            ForEach(coupleViewModel.schedules, id: \.self){ item in
                if (compareDate(currentDate.currentDate) == compareDate(item.startDate) && dateToFloat(item.endDate) >= dateToFloat(currentTime)){
//                    if(dateToFloat(item.endDate) >= dateToFloat(currentTime)){
                        VStack{
                            if(scheduleAdaptor(schedules: item) == 2){
                                TimeTableView(schedule: item)
                                //                                .padding(.top, CGFloat((value.startTime - 6) * 43))
                                                                .offset(x: -60, y: CGFloat((dateToFloat(item.startDate) - dateToTime(currentTime)) * 43))
                            }
                            else if(scheduleAdaptor(schedules: item) == 1){
                                TimeTableView(schedule: item)
                                    .offset(x: 15, y: CGFloat((dateToFloat(item.startDate) - dateToTime(currentTime)) * 43))
                                    //                                .offset(x: 15)
                                    //                                .padding(.top, CGFloat((value.startTime - 6) * 43))
                            }
                            else
                            {
                                TimeTableView(schedule: item)
                                    .offset(x: 90, y: CGFloat((dateToFloat(item.startDate) - dateToTime(currentTime)) * 43))
                                //                                .offset(x: 90)
                                //                                .padding(.top, CGFloat((value.startTime - 6) * 43))
                            }
                            Spacer()
                        }.padding(.top, 10)

//                    }
                }
                
                
//                    .padding(.top, CGFloat((value.startTime - 6) * 30) )
//                Spacer()
            }

        }
        
        
    }
    
    func compareDate(_ currentDate: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM dd"
        
        let date = formatter.string(from: currentDate)
        
        return date
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
//    func dateToInt(_ date: Date) -> String {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "HH"
//            let hour = formatter.string(from: date)
//
//        return hour
//    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
