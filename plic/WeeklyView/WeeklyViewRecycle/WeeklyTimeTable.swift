//
//  WeeklyTimeTable.swift
//  plic
//
//  Created by 이주화 on 2022/06/14.
//

import SwiftUI

struct WeeklyTimeTable: View {
    @EnvironmentObject var currentDate: DateData
    let Times: [DumyTime]
//    var month: String = "6"
//    var day: String = "23"
    let firstNick: String = "디기"
    let secondNick: String = "벳져"

    
    var body: some View {
        
            VStack{
                HStack{
                    WeeklyTimeTableTitleView(month: extraData(currentDate.currentDate)[1], day: extraData(currentDate.currentDate)[0])
                }
                .padding([.leading,.trailing], 5)
                .padding([.leading,.trailing], 20)
            ScrollView{
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(lineWidth: 1)
//                        .foregroundColor(Color("plicGrey"))
//                        .shadow(color: Color("plicGrey"), radius: 2)
                    VStack{
                        HStack{
                            TimeTableNameView(firstNick: firstNick, secondNick: secondNick)
                        }.padding([.leading,.trailing], 105)
                            .padding(.top, 50)
                        HStack{
                            TimeTableWeeklyView(Times: Times)
                        }.padding([.leading,.trailing], 20)
                            .padding(.top, 0)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray, radius: 2)
                    .padding(.top, 20)
                    .padding([.leading,.trailing], 20)
                
            }
            
        }
            
        
    }
    func extraData(_ currentDate: Date) -> [String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd M"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
}

//struct WeeklyTimeTable_Previews: PreviewProvider {
//    static var previews: some View {
//        WeeklyTimeTable()
//    }
//}

struct WeeklyTimeTableTitleView: View {
    let month: String
    let day: String
    @State private var showAddScheduleModal = false

    
    var body: some View {
        HStack{
            Text("\(month)월 \(day)일의 일정")
                .font(.custom("SpoqaHanSansNeo-Bold",size: 20))
                .foregroundColor(Color("plicBlack"))
            Spacer()
            Button(action: {
                self.showAddScheduleModal = true
            }){
                Image(systemName: "plus")
                    .font(.custom("SpoqaHanSansNeo-Medium",size: 22))
                    .foregroundColor(Color("plicGrey"))
            }.sheet(isPresented: self.$showAddScheduleModal){
                AddSchedule()
            }
        }
    }
}

struct DumyTime: Hashable{
    let startTime: Float
    let endTime: Float
    let name: String
    var who: Int
}


struct TimeTableWeeklyView : View {
    let Time: [String] = ["06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00"]
    let Times: [DumyTime] 
                             
    
    var body: some View {
        ZStack(alignment: .top){
            
            HStack{
                
                VStack{
                    ForEach(Time, id: \.self){ item in
                        
                        Text(item)
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                            .foregroundColor(Color("plicTime"))
                            .frame(height: 10)
                            .padding(.bottom, 25)
                            
                    }
                }
                Spacer()
                VStack{
                    ForEach(Time, id: \.self){ item in
                        
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
                        //                                .padding(.top, CGFloat((value.startTime - 6) * 43))
                                                        .offset(x: -60, y: CGFloat((value.startTime - 6) * 43))
                    }
                    else if(value.who == 1){
                        TimeTableView(letter: value.name, num: value.endTime - value.startTime, who: value.who, testSchedule: value)
                            .offset(x: 15, y: CGFloat((value.startTime - 6) * 43))
                            //                                .offset(x: 15)
                            //                                .padding(.top, CGFloat((value.startTime - 6) * 43))
                    }
                    else
                    {
                        TimeTableView(letter: value.name, num: value.endTime - value.startTime, who: value.who, testSchedule: value)
                            .offset(x: 90, y: CGFloat((value.startTime - 6) * 43))
                        //                                .offset(x: 90)
                        //                                .padding(.top, CGFloat((value.startTime - 6) * 43))
                    }
                    Spacer()
                }.padding(.top, 10)

            }
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

