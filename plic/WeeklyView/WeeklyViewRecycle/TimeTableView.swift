//
//  TimeTableView.swift
//  plic
//
//  Created by 이주화 on 2022/06/14.
//

import SwiftUI

struct TimeTableView: View {
    let letter: String = "점심 약속"
    let num: Int = 1
    let width: CGFloat = 60.0
    var height: CGFloat = 35.0
    
    var body: some View {
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
            
        }
}

struct TimeTableView_Previews: PreviewProvider {
    static var previews: some View {
        TimeTableView()
    }
}
