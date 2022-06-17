//
//  DetailScheduleView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/10.
//

import SwiftUI

struct DetailScheduleView: View {
    var testSchedule: DumyTime
    
    var body: some View {
        VStack{
            VStack{
                HStack(spacing: 0){
                    Text("\(testSchedule.name)")
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                    Spacer()
                    Text("\(OwnerOfSchedule(num: testSchedule.who))")
                        .foregroundColor(Color(TextColor(num: testSchedule.who)))
                        .font(.custom("SpoqaHanSansNeo-Regular", size: 17))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 9)
                        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color(BoxColor(num: testSchedule.who))))
                }
                .padding(.bottom, 14)
                
                Divider()
                MiniTimeTableView(testSchedule: testSchedule)
            }.frame(height: 200)
                .padding(.horizontal, 20)
            HStack{
                DetailViewTime(startTime: "\(testSchedule.startTime)", endTime: "\(testSchedule.endTime)")
            }
            HStack{
                DetailViewMemo()
            }
        }
        .accentColor(Color("plicPink"))
    }
}

//struct DetailScheduleView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailScheduleView()
//    }
//}


func OwnerOfSchedule(num: Int) -> String {
    var owner: String = ""
    
    if num == 0 {
        owner = "디기"
    } else if num == 1 {
        owner = "함께"
    } else if num == 2{
        owner = "뱃저"
    }
    return owner
}

func BoxColor(num: Int) -> String {
    var colorBox: String = ""
    
    if num == 0 {
        colorBox = "plicYellow"
    } else if num == 1 {
        colorBox = "plicPeach"
    } else if num == 2{
        colorBox = "plicSky"
    }
    return colorBox
}

func TextColor(num: Int) -> String {
    var textColor: String = ""
    
    if num == 0 {
        textColor = "plicTimeyellow"
    } else if num == 1 {
        textColor = "plicPink"
    } else if num == 2{
        textColor = "plicNavy"
    }
    return textColor
}
