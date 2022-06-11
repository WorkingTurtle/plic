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
    let dayoftheWeek : [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    let columns = [
          //추가 하면 할수록 화면에 보여지는 개수가 변함
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
                VStack{
                    Text("\(year)년 \(month)월")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 16))
                        .foregroundColor(Color("plicPink"))
                }
                VStack{
                    Image(systemName: "chevron.right")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 16))
                        .foregroundColor(Color("plicPink"))
                }
                Spacer()
                VStack{
                    Image(systemName: "plus")
                        .font(.custom("SpoqaHanSansNeo-Medium",size: 16))
                        .foregroundColor(Color("plicPink"))
                }
            }
            .padding([.leading, .trailing], 32)
            .padding(.bottom, 15)
            HStack{
                LazyVGrid(columns: columns) {
                    ForEach(0..<7){ i in
                    DayOfWeekView(letter: dayoftheWeek[i])
                }
                }
            }.padding([.leading, .trailing], 32)
            HStack{
                LazyVGrid(columns: columns) {
                    ForEach(1..<42){ i in
                    DayView(letter: i, firstCheck: true, secondCheck: true, thirdCheck: true)
                    }
                }
            }.padding([.leading, .trailing], 32)
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
                .font(.custom("SpoqaHanSansNeo-Bold",size: 13))
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
        VStack(spacing: 2){
            HStack{
                Text("\(letter)")
                    .font(Font.custom("SpoqaHanSansNeo-Bold",size: 13))
                    .foregroundColor(Color("plicBlack"))
            }.frame(width: 32, height: 32)
            HStack(spacing: 2){
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
            }
        }.frame(width: 30, height: 40)
    }
}
