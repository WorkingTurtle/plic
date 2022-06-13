//
//  UserAnniversaryView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/11.
//

import SwiftUI

struct Anniversary: Hashable{
    let dDay: Int
    let date: String
    var name: String
}

struct UserAnniversaryView: View {
    
    let anniversaryList: [Anniversary] = [
        Anniversary(dDay: 3, date: "2022년 6월 5일", name: "서울 여행"),
        Anniversary(dDay: 27, date: "2022년 6월 29일", name: "사귄지 150일"),
        Anniversary(dDay: 28, date: "2022년 6월 30일", name: "OOO생일")
    ]
    
    var body: some View {
        NavigationView{
            VStack{
                ForEach(anniversaryList, id: \.self) { item in
                    VStack{
                        HStack{
                            Text("D-\(item.dDay)")
                                .font(Font.custom("SpoqaHanSansNeo-Bold", size: 30))
                                .foregroundColor(Color("plicPink"))
                                .padding(.leading, 5)
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\(item.date)")
                                    .font(Font.custom("SpoqaHanSansNeo-Regular", size: 13))
                                    .foregroundColor(Color("plicGrey"))
                                Text("\(item.name)")
                                    .font(Font.custom("SpoqaHanSansNeo-Bold", size: 16))
                            }
                        }
                        .padding(.horizontal, 20)
                        Divider()
                            .padding(.horizontal, 20)
                    }
                }
                Spacer()
            }
            .navigationBarTitle(Text("기념일"), displayMode: .inline)
        }
    }
}



struct UserAnniversaryView_Previews: PreviewProvider {
    static var previews: some View {
        UserAnniversaryView()
    }
}

