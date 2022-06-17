//
//  WeeklyView.swift
//  plic
//
//  Created by 이주화 on 2022/06/14.
//

import SwiftUI

struct WeeklyView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        VStack{
//            Button(action: {presentationMode.wrappedValue.dismiss()}) {
//                HStack{
//                    Image(systemName: "chevron.left")
//                        .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
//                        .foregroundColor(Color("plicPink"))
//                    Text("Plic 캘린더")
//                    Spacer()
//                }.padding(.leading, 20)
//            }
            HStack{
                DayPickerView()
            }
            HStack{
                WeeklyTimeTable()
            }    
        }.navigationTitle("오늘의 일정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WeeklyView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyView()
    }
}
