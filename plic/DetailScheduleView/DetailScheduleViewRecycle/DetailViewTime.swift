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
                    .font(.custom("SpoqaHanSansNeo-Regular",size: 14))
                Spacer()
            }
            .padding(.leading, 24)
            
            HStack{
                VStack(alignment: .leading){
                    Text("시작")
                        .font(.custom("SpoqaHanSansNeo-Regular",size: 13))
                        .padding(.leading, 45)
                    Text("\(startTime) \(isAMPM(isMorning))")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                        .padding(.leading, 45)
                        .padding(.top, 1)
                    Text("\(startDate)")
                        .font(.custom("SpoqaHanSansNeo-Regular",size: 13))
                        .foregroundColor(Color("plicDarkgrey"))
                        .padding(.leading, 45)
                        .padding(.top, 7)
                }
                
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(Color("plicPink"))
                Spacer()
                
                VStack(alignment: .leading){
                    Text("종료")
                        .font(.custom("SpoqaHanSansNeo-Regular",size: 13))
                        .padding(.trailing, 97)
                    Text("\(endTime) \(isAMPM(!isMorning))")
                        .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                        .padding(.trailing, 42)
                        .padding(.top, 1)
                    Text("\(endDate)")
                        .font(.custom("SpoqaHanSansNeo-Regular",size: 13))
                        .foregroundColor(Color("plicDarkgrey"))
                        .padding(.trailing, 52)
                        .padding(.top, 7)
                }
            }
            .padding(.top, 11)
            
            Divider()
                .padding(.horizontal, 20)
                .padding(.top, 14)
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
