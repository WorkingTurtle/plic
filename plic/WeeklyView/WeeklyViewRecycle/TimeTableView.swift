//
//  TimeTableView.swift
//  plic
//
//  Created by 이주화 on 2022/06/14.
//

import SwiftUI

struct TimeTableView: View {
    let letter: String
    let num: Int
    let width: CGFloat = 60.0
    let coupleWidth: CGFloat = 210.0
    var height: CGFloat = 43.0
    let who: Int
    
    var body: some View {
        if(who == 0){
            VStack{
                Text(letter)
                    .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                    .foregroundColor(Color("plicTimeyellow"))
                    .padding(.top, 5)
                Spacer()
            }
            .frame(width: width, height: height * CGFloat(num))
            .background(Color("plicYellow"))
            .cornerRadius(3)
        }else if(who == 1){
            VStack{
                Text(letter)
                    .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                    .foregroundColor(Color("plicPink"))
                    .padding(.top, 5)
                Spacer()
            }
            .frame(width: coupleWidth, height: height * CGFloat(num))
            .background(Color("plicTimepink"))
            .cornerRadius(3)
        }else if(who == 2){
            VStack{
                Text(letter)
                    .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                    .foregroundColor(Color("plicNavy"))
                    .padding(.top, 5)
                Spacer()
            }
            .frame(width: width, height: height * CGFloat(num))
            .background(Color("plicTimeblue"))
            .cornerRadius(3)
        }
            
            
        }
}


