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
            .padding(.bottom, 15)
            HStack{
                TimeTableNameView(firstNick: firstNick, secondNick: secondNick)
            }.padding([.leading,.trailing], 90)
            HStack{
                TimeTableMiniView()
            }
        }
        .padding([.leading,.trailing], 20)
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
  let Times: [DumyTime] =
    [DumyTime(startTime: 9, endTime: 10, name: "친구 약속", who: 2),
     DumyTime(startTime: 10, endTime: 11, name: "데이트", who: 1),
     DumyTime(startTime: 11, endTime: 12, name: "점심", who: 0),
     DumyTime(startTime: 11, endTime: 12, name: "점심", who: 2)]
    var currentTimeArr: [Int] = [0, 1, 2, 3]
    

    
    static let HourDateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }()
    
    
    var body: some View {
        ZStack{
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
            
            ForEach(Times, id: \.self){ value in
                VStack{
                    if(value.who == 0){
                        TimeTableView(letter: value.name, num: value.endTime - value.startTime, who: value.who, testSchedule: value)
                            .padding(.top, CGFloat((value.startTime - 9) * 43))
                            .offset(x: -60)
                    }
                    else if(value.who == 1){
                        TimeTableView(letter: value.name, num: value.endTime - value.startTime, who: value.who, testSchedule: value)
                            .offset(x: 15)
                            .padding(.top, CGFloat((value.startTime - 9) * 43))
                    }
                    else
                    {
                        TimeTableView(letter: value.name, num: value.endTime - value.startTime, who: value.who, testSchedule: value)
                            .offset(x: 90)
                            .padding(.top, CGFloat((value.startTime - 9) * 43))
                    }
                    Spacer()
                }.padding(.top, 10)
                
                
//                    .padding(.top, CGFloat((value.startTime - 6) * 30) )
//                Spacer()
            }

        }
        
        
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
