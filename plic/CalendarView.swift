//
//  CalendarView.swift
//  plic
//
//  Created by 이주화 on 2022/06/11.
//

import SwiftUI

struct CalendarView: View {
    @State var year: String = "2022"
    @State var month: String = "6"
    let dayoftheWeek : [String] = ["SUM", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Text("\(year)년 \(month)월 >")
                        .font(.custom("SpoqaHanSansNeo-Medium",size: 22))
                        .foregroundColor(Color("plicPink"))
                }
                Spacer()
                VStack{
                    Image(systemName: "plus")
                        .font(.custom("SpoqaHanSansNeo-Medium",size: 22))
                        .foregroundColor(Color("plicPink"))
                }
            }
            .padding([.leading, .trailing], 36)
            .padding(.bottom, 15)
            HStack{
                ForEach(0..<7){ i in
                    DayOfWeekView(letter: dayoftheWeek[i])
                    if(i < 6){
                        Spacer()
                    }
                }
            }.padding([.leading, .trailing], 36)
            HStack{
                
            }
        }
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
                .font(.custom("SpoqaHanSansNeo-Medium",size: 13))
                .foregroundColor(Color("plicBlack"))
        }
    }
}
