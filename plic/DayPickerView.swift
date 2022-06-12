//
//  DayPickerView.swift
//  plic
//
//  Created by 이주화 on 2022/06/12.
//

import SwiftUI

struct DayPickerView: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "chevron.left")
                    .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                    .foregroundColor(Color("plicPink"))
                DayPicksView(letter: "월", whatDate: "7")
                DayPicksView(letter: "화", whatDate: "8")
                DayPickView(letter: "수", whatDate: "9")
                DayPicksView(letter: "목", whatDate: "10")
                DayPicksView(letter: "금", whatDate: "11")
                Image(systemName: "chevron.right")
                    .font(.custom("SpoqaHanSansNeo-Bold",size: 17))
                    .foregroundColor(Color("plicPink"))
            }.padding([.leading, .trailing], 20)
        }
        
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
