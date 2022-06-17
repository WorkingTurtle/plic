//
//  TimeTableView.swift
//  plic
//
//  Created by 이주화 on 2022/06/14.
//

import SwiftUI

struct TimeTableView: View {
    let letter: String
    @State var num: Float
    let width: CGFloat = 60.0
    let coupleWidth: CGFloat = 210.0
    var height: CGFloat = 43.0
    let who: Int
    
    var body: some View {
        NavigationLink(destination: DetailScheduleView()){
            if(who == 0){
                VStack{
                    HStack{
                        Text(letter)
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                            .foregroundColor(Color("plicTimeyellow"))
                            .padding(.top, 5)
                            .padding(.leading, 5)
                        Spacer()
                    }
                    
                    Spacer()
                }
                .frame(width: width, height: height * CGFloat(num))
                .background(Color("plicYellow"))
                .cornerRadius(3)
            }else if(who == 1){
                VStack{
                    HStack{
                        Text(letter)
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                            .foregroundColor(Color("plicPink"))
                            .padding(.top, 5)
                            .padding(.leading, 5)
                        Spacer()
                    }
                    
                    Spacer()
                }
                .frame(width: coupleWidth, height: height * CGFloat(num))
                .background(Color("plicTimepink"))
                .cornerRadius(3)
            }else if(who == 2){
                VStack{
                    HStack{
                        Text(letter)
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                            .foregroundColor(Color("plicNavy"))
                            .padding(.top, 5)
                            .padding(.leading, 5)
                        Spacer()
                    }

                    Spacer()

                }
                .frame(width: width, height: height * CGFloat(num))
                .background(Color("plicTimeblue"))
                .cornerRadius(3)
            }
        }
    }
}


//func overFour(num: Float) -> Int {
//    @Binding num: Float
//    var a = Int(num)
//
//    if a > 4 {
//        a == 4
//        return a
//    }
//}
