//
//  DayPickerView.swift
//  plic
//
//  Created by 이주화 on 2022/06/12.
//

import SwiftUI

struct DayPickerView: View {
    @EnvironmentObject var currentDate: DateData
    @State var weeksDate: [Date] = [Date(), Date(), Date(), Date()]
    @State var currentDay: Int = 0
    
    var body: some View {
        VStack{
            HStack{
                Button(action:
                    {
                        withAnimation{
                            currentDay -= 5
                            
                        }
                    }
                ){
                    Image(systemName: "chevron.left")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                        .foregroundColor(Color("plicPink"))
                }
                Button(action:
                    {
                        withAnimation{
                            currentDay -= 2
                            
                        }
                    }
                ){
                    DayPicksView(letter: extraData(weeksDate[0])[1], whatDate: extraData(weeksDate[0])[0])
                }
                Button(action:
                    {
                        withAnimation{
                            currentDay -= 1
                            
                        }
                    }
                ){
                    DayPicksView(letter: extraData(weeksDate[1])[1], whatDate: extraData(weeksDate[1])[0])
                }
                DayPickView(letter: extraData(currentDate.currentDate)[1], whatDate: extraData(currentDate.currentDate)[0])
                Button(action:
                    {
                        withAnimation{
                            currentDay += 1
                            
                        }
                    }
                ){
                    DayPicksView(letter: extraData(weeksDate[2])[1], whatDate: extraData(weeksDate[2])[0])
                }
                Button(action:
                    {
                        withAnimation{
                            currentDay += 2
                            
                        }
                    }
                ){
                    DayPicksView(letter: extraData(weeksDate[3])[1], whatDate: extraData(weeksDate[3])[0])
                }
                Button(action:
                    {
                        withAnimation{
                            currentDay += 5
                            
                        }
                    }
                ){
                    Image(systemName: "chevron.right")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                        .foregroundColor(Color("plicPink"))
                }
                
            }
        }.onChange(of: currentDay){ newValue in
            currentDate.currentDate = getCurrentDay()
            weeksDate[0] = getDay(-2 + currentDay)
            weeksDate[1] = getDay(-1 + currentDay)
            weeksDate[2] = getDay(1 + currentDay)
            weeksDate[3] = getDay(2 + currentDay)
        }
//        .onChange(of: currentDate.currentDate){ newValue in
//            weeksDate[0] = getDay(-2)
//            weeksDate[1] = getCurrentDay()
//            weeksDate[2] = getFirstDay(getCurrentDay(), 1)
//            weeksDate[3] = getFirstDay(getCurrentDay(), 2)
//            print(weeksDate)
//        }
        .onAppear(){
            weeksDate[0] = getFirstDay(currentDate.currentDate, -2)
            weeksDate[1] = getFirstDay(currentDate.currentDate, -1)
            weeksDate[2] = getFirstDay(currentDate.currentDate, 1)
            weeksDate[3] = getFirstDay(currentDate.currentDate, 2)
        }
        
        
    }
    func extraData(_ currentDate: Date) -> [String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "d EEEEE"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentDay() -> Date {
        let calendar = Calendar.current
        
        
        guard let currentDay = calendar.date(byAdding: .day, value: self.currentDay, to: Date())
        else{
            return Date()
        }
        
        return currentDay
    }
    
    func getDay(_ num: Int) -> Date {
        let calendar = Calendar.current
        
        
        guard let currentDay = calendar.date(byAdding: .day, value: num, to: Date())
        else{
            return Date()
        }
        
        return currentDay
    }
    func getFirstDay(_ currentDate: Date, _ num: Int) -> Date {
        let calendar = Calendar.current
        
        
        guard let currentDay = calendar.date(byAdding: .day, value: num, to: Date())
        else{
            return Date()
        }
        
        print("CurrentDay \(currentDay)")
        return currentDay
    }
    func isSameDay(date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}

struct DayPickerView_Previews: PreviewProvider {
    static var previews: some View {
        DayPickerView()
    }
}

struct DayPickView: View {
    let letter: String
    let whatDate: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("plicLightpink"))
                .frame(width: 50, height: 72)
            VStack(spacing: 0){
                    Text("\(letter)")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                        .foregroundColor(Color("plicPink"))
                        .padding([.top, .bottom], 8)
                    Text("\(whatDate)")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 18))
                        .foregroundColor(Color("plicPink"))
                        .padding(.bottom, 3)
                    Circle()
                        .fill(Color("plicPink"))
                        .frame(width: 6, height: 6)
                
            }
        }.frame(width: 50, height: 72)
    }
}

struct DayPicksView: View {
    let letter: String
    let whatDate: String
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                    Text("\(letter)")
                        .font(.custom("SpoqaHanSansNeo-Regular",size: 12))
                        .foregroundColor(Color("plicDarkgrey"))
                        .padding(.bottom, 8)
                        .padding(.top, 1)
                    Text("\(whatDate)")
                        .font(.custom("SpoqaHanSansNeo-Regular",size: 18))
                        .foregroundColor(Color("plicDarkgrey"))
                        .padding(.bottom, 3)
            }
        }.frame(width: 50, height: 72)
    }
}
