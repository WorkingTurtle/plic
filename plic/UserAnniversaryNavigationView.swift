//
//  UserAnniversaryNavigationView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/11.
//

import SwiftUI

// 기념일 네비게이션 바 생성
struct UserAnniversaryNavigationView: View {
        
    var body: some View {
        NavigationView{
            AnniversaryView()
                .navigationBarTitle("기념일", displayMode: .inline)
        }
    }
}
//
//struct UserAnniversaryNavigationView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserAnniversaryNavigationView()
//    }
//}


struct AnniversaryView: View {
    @State var anniversaryDday: [Int] = [3,27, 28]
    @State var anniversaryFullDate: [String] = ["2022년 6월 5일", "2022년 6월 29일", "2022년 6월 30일"]
    @State var anniversaryName: [String] = ["서울 여행", "사귄지 150일", "OOO생일"]
    
    var body: some View {
        ForEach(anniversaryDday, id: \.self) { item in
            
            VStack(alignment: .leading, spacing: 35){
                ForEach(anniversaryDday, id: \.self) { item in
                    HStack{
                        Text("D-\(item)")
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 30))
                            .foregroundColor(Color("plicPink"))
                        
//                        Text(anniversaryFullDate[item])
                    }
                }
            }
        }
    }
}
