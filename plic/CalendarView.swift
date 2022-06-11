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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 30), spacing: 18)],
                    spacing: 10) {
                    ForEach(1..<32){ i in
                    DayView(letter: i, firstCheck: true, secondCheck: true, thirdCheck: true)
                    }
                }
            }.padding([.leading, .trailing], 36)
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

struct DayView: View {
    let letter: Int
    @State var firstCheck: Bool
    @State var secondCheck: Bool
    @State var thirdCheck: Bool
    
    var body: some View{
        VStack{
            HStack{
                Text("\(letter)")
                    .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
                    .foregroundColor(Color("plicBlack"))
            }
            HStack{
                Spacer()
                if(firstCheck){
                    Circle()
                        .fill(Color("plicCirclepink"))
                        .frame(width: 6, height: 6)
                    Spacer()
                }
                if(secondCheck){
                    Circle()
                        .fill(Color("plicCircleyellow"))
                        .frame(width: 6, height: 6)
                    Spacer()
                }
                if(thirdCheck){
                    Circle()
                        .fill(Color("plicCirclesky"))
                        .frame(width: 6, height: 6)
                    Spacer()
                }
            }
        }.frame(width: 30, height: 40)
    }
}
