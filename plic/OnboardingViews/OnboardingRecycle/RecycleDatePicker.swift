//
//  RecycleDatePicker.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI

struct RecycleDatePicker: View {
    @Binding var date: Date
    
    static let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    
    
    var body: some View {
        VStack(spacing: 15){
            ZStack{
                // 뒤에 박스처리 좀 더 나은 방법이 있을 거라 추정됨.. 똥을 싸버렸다
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .frame(width: .infinity, height: 45)
                    .padding(.horizontal, 20)
                Text("\(date, formatter: RecycleDatePicker.dateformat)")
                    .font(Font.custom("SpoqaHanSansNeo-Regular", size: 20))
            }
            ZStack{
                // 마찬가지
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .frame(width: .infinity, height: 200)
                    .padding(.horizontal, 20)
                DatePicker("선택", selection: $date, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
            }
        }.padding(.top, 30)
    }
}
