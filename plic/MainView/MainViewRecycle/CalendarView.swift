//
//  CalendarView.swift
//  plic
//
//  Created by 이주화 on 2022/06/11.
//

import SwiftUI

struct CalendarView: View {
    @State var year = [Int](2022..<2100)
    @State var month = [Int](0..<13)
    @EnvironmentObject var currentDate: DateData
    @State var currentMonth: Int = 0
    @State var currentYear: Int = 0
    @State var check: Bool = true
    @State var selection = Date()
    @State private var showAddScheduleModal = false

    
    
    let dayoftheWeek : [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        VStack{
            HStack{
                Button(action : {
                    check.toggle()
                }){
                    HStack{
                        Text("\(extraData(currentDate.currentDate)[1])년 \(extraData(currentDate.currentDate)[0])월")
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 16))
                            .foregroundColor(Color("plicPink"))
//                        Image(systemName: "chevron.right")
//                            .font(.custom("SpoqaHanSansNeo-Bold",size: 16))
//                            .foregroundColor(Color("plicPink"))
                    }
                }
                Button(action:
                    {
                        withAnimation{
                            currentMonth -= 1
                            
                        }
                    }
                ){
                    Image(systemName: "chevron.left")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 16))
                        .foregroundColor(Color("plicPink"))
                }
//                    Image(systemName: "chevron.left")
//                        .font(.custom("SpoqaHanSansNeo-Bold",size: 16))
//                        .foregroundColor(Color("plicPink"))
//
//                    .onTapGesture {
//                        withAnimation{currentMonth -= 1}
//
//                    }
                Button(action:
                    {
                        withAnimation{
                            currentMonth += 1
                            
                        }
                    }
                ){
                    Image(systemName: "chevron.right")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 16))
                        .foregroundColor(Color("plicPink"))
                }
                Spacer()
                //Image를 plus로 변경 + 모달 팝업
                Button(action: {
                    self.showAddScheduleModal = true
                }){
                    Image(systemName: "plus")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 16))
                        .foregroundColor(Color("plicPink"))
                }.sheet(isPresented: self.$showAddScheduleModal){
                    MainAddSchedule()
                }
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 15)
            if(check){
                HStack{
                    LazyVGrid(columns: columns) {
                        ForEach(dayoftheWeek, id: \.self){ i in
                        DayOfWeekView(letter: i)
                    }
                    }
                }.padding([.leading, .trailing], 20)
                HStack{
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(extractDate()){ value in
                            DayView(value: value, currentDate: currentDate.currentDate)
                                
                                .onTapGesture {
                                    currentDate.currentDate = value.date
                                }
                        }
                    }
                }.padding([.leading, .trailing], 20)
            }
            else{
                HStack(spacing: 0) {
                    DatePicker("Please enter a date", selection: $selection,
                                       displayedComponents: .date)
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
//                            Picker(selection: self.$currentYear, label: Text("")) {
//                                ForEach(0 ..< self.year.count) { index in
//                                    Text("\(self.year[index]) 년")
//                                        .padding(.leading, 40)
//                                }
//                            }
//                            .pickerStyle(.wheel)
//
//
//                            Picker(selection: self.$currentMonth, label: Text("")) {
//                                ForEach(0 ..< self.month.count) { index in
//                                    Text("\(self.month[index]) 월")
//                                        .padding(.trailing, 40)
//                                }
//                            }
//                            .pickerStyle(.wheel)
                }.frame(width: 340, height: 300)
            
            }
            
            
        }
        .onChange(of: currentMonth){ newValue in
            currentDate.currentDate = getCurrentMonth()
        }
//        .onChange(of: currentYear){ newValue in
//           currentDate = getCurrentYear()
//        }
        .onChange(of: selection){ newValue in
            currentDate.currentDate = selection

        }
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    func extraData(_ currentDate: Date) -> [String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM YYYY"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())
        else{
            return Date()
        }
        
        return currentMonth
    }
    
    func getCurrentYear() -> Date {
        let calendar = Calendar.current
        
        guard let currentYear = calendar.date(byAdding: .year, value: self.currentYear, to: Date())
        else{
            return Date()
        }
        
        return currentYear
    }
    
    func extractDate()->[DateValue]{
        
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap{ date -> DateValue in
            
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday,from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

struct DayOfWeekView: View {
    let letter: String
    
    var body: some View {
        VStack{
            Text("\(letter)")
                .font(.custom("SpoqaHanSansNeo-Regular",size: 13))
                .foregroundColor(Color("plicBlack"))
        }
    }
}

struct DayView: View {

    
    let dateFormatter = DateFormatter()
    
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    
    let value: DateValue
    let currentDate: Date
    var firstCheck: Bool = false
    var secondCheck: Bool = false
    var thirdCheck: Bool = false
    
    var body: some View{
        
        VStack(spacing: 5){
            if value.day != -1{
                ZStack{
                    ZStack{
                        Circle()
                            .fill(isSameDay(date1: value.date, date2: currentDate) ? Color("plicPink") : Color("plicWhite"))
                        HStack{
                            
                            Text("\(value.day)")
                                .font(isSameDay(date1: value.date, date2: currentDate) ? Font.custom("SpoqaHanSansNeo-Bold",size: 16) : Font.custom("SpoqaHanSansNeo-Regular",size: 16) )
                                .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? Color("plicWhite") : Color("plicDarkgrey"))
    //                            .background(
    //                                Capsule()
    //                                    .fill(Color("plicPink"))
    //                                    .padding(2)
    //                                    .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
    //                            )
                        }
                    }
                    .frame(width: 32, height: 32)
                    
                    
                    HStack(spacing: 2){
                        ForEach(coupleViewModel.schedules, id: \.self){ item in
                            if( compareDate(value.date) == compareDate(item.startDate)){
                                if(scheduleAdaptor(schedules: item) == 2){
                                    Circle()
                                        .fill(Color("plicCirclepink"))
                                        .frame(width: 6, height: 6)
                                }
                                if(scheduleAdaptor(schedules: item) == 1){
                                    Circle()
                                        .fill(Color("plicCircleyellow"))
                                        .frame(width: 6, height: 6)
                                }
                                if(scheduleAdaptor(schedules: item) == 0){
                                    Circle()
                                        .fill(Color("plicCirclesky"))
                                        .frame(width: 6, height: 6)

                                }
                                
                            }
                        }
                    }.padding(.top, 42)
                
                    if(firstCheck){
                        Circle()
                            .fill(Color("plicCirclepink"))
                            .frame(width: 6, height: 6)
                    }
                    if(secondCheck){
                        Circle()
                            .fill(Color("plicCircleyellow"))
                            .frame(width: 6, height: 6)
                    }
                    if(thirdCheck){
                        Circle()
                            .fill(Color("plicCirclesky"))
                            .frame(width: 6, height: 6)

                    }
                    
//                    if(item.who == 0){
                    //
                    //                                    if(firstCheck == false){
                    //                                        VStack{
                    //                                            Circle()
                    //                                                .fill(Color("plicCirclepink"))
                    //                                                .frame(width: 6, height: 6)
                    //                                            firstCheck.toggle()
                    //                                        }
                    //                                    }
                    //    //
                    //                                }else if(item.who == 1){
                    //                                    if(secondCheck == false){
                    //                                        Circle()
                    //                                            .fill(Color("plicCircleyellow"))
                    //                                            .frame(width: 6, height: 6)
                    //
                    //                                    }
                    //    //                                secondCheck = true
                    //                                }else if(item.who == 2){
                    //                                    if(thirdCheck == false){
                    //                                        Circle()
                    //                                            .fill(Color("plicCirclesky"))
                    //                                            .frame(width: 6, height: 6)
                    //
                    //                                    }
                    //    //                                thirdCheck = true
                    //                                }
                }
            }
            
        }.frame(width: 30, height: 40)
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
    
    func isSameDay(date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func isCheck(date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func stringToDate(Str: String) -> Date?{
        let formatter = DateFormatter()
        
        formatter.dateFormat = "y-M-d"
        
        let date = formatter.date(from: Str)
        
        return date
    }
    
    func compareDate(_ currentDate: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM dd"
        
        let date = formatter.string(from: currentDate)
        
        return date
    }
}

extension Date{
    func getAllDates() -> [Date]{
        
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: self)!

        
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}

struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
}


struct ScheduleDummy: Hashable{
    let startDay: String
    let endDay: String
    let firstCheck: Bool
    let secondCheck: Bool
    let thirdCheck: Bool
}
