//
//  DetailViewTime.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/10.
//

import SwiftUI

struct DetailViewTime: View {
    
    var startTime: String = "11:00"
    var endTime: String = "18:00"
    var startDate: String = "2022.06.03"
    var endDate: String = "2022.06.04"
    @State var isMorning: Bool = true

    
    var body: some View {
        
        //시간 UI Layout 
        VStack{
            HStack{
                Image(systemName: "calendar")
                    .foregroundColor(Color("plicPink"))
                    .frame(width: 15, height: 14)
                Text("시간")
                    .font(.system(size: 14))
                Spacer()
            }
            .padding(.leading, 24)
            
            HStack{
                Text("시작")
                    .font(.system(size: 13))
                    .padding(.leading, 45)
                Spacer()
                Text("종료")
                    .font(.system(size: 13))
                    .padding(.trailing, 109)
            }
            .padding(.top, 11)
            
            HStack{
                Text("\(startTime) \(isAMPM(isMorning))")
                    .font(.system(size: 17, weight: .bold))
                    .padding(.leading, 45)
                Image(systemName: "arrow.right")
                    .foregroundColor(Color("plicPink"))
                
                //arrow를 어떻게 padding값을 줘야 할까요?
                    .padding(.horizontal, 49)
                Text("\(endTime) \(isAMPM(isMorning))")
                    .font(.system(size: 17, weight: .bold))
                    .padding(.trailing, 57)
            }
            .padding(.top, 1)
            
            HStack{
                Text("\(startDate)")
                    .font(.system(size: 13))
                
                //색상 추가되면 바뀌어야 하는 구간 gray -> #757575
                    .foregroundColor(.gray)
                    .padding(.leading, 45)
                Spacer()
                Text("\(endDate)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .padding(.trailing, 67)
            }
            .padding(.top, 7)
            
            Divider()
                .padding(.horizontal, 20)
                .padding(.top, 13.92)
        }
    }
}


struct DetailViewTime_Previews: PreviewProvider {
    static var previews: some View {
        DetailViewTime()
    }
}


func isAMPM(_ morning: Bool) -> String {
    if morning == true {
        return "AM"
    } else {
        return "PM"
    }
}
