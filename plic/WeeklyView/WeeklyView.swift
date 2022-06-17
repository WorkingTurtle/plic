//
//  WeeklyView.swift
//  plic
//
//  Created by 이주화 on 2022/06/14.
//

import SwiftUI

struct WeeklyView: View {
    @Environment(\.presentationMode) var presentationMode
    let Times: [DumyTime] =
    [DumyTime(startTime: 9, endTime: 14, name: "친구 약속", who: 2),
     DumyTime(startTime: 10, endTime: 11, name: "데이트", who: 1),
     DumyTime(startTime: 11, endTime: 12, name: "점심", who: 0),
     DumyTime(startTime: 6, endTime: 8, name: "아침", who: 0),
     DumyTime(startTime: 6, endTime: 8, name: "아침", who: 2),
     DumyTime(startTime: 11, endTime: 12, name: "점심", who: 2)]
    
    var body: some View {
        
        VStack{
            Button(action: {presentationMode.wrappedValue.dismiss()}) {
                HStack{
                    Image(systemName: "chevron.left")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                        .foregroundColor(Color("plicPink"))
                    Text("Plic 캘린더")
                    Spacer()
                }.padding(.leading, 20)
            }
            HStack{
                DayPickerView()
            }
            HStack{
                WeeklyTimeTable(Times: Times)
            }    
        }.navigationBarHidden(true)
    }
}

struct WeeklyView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyView()
    }
}
