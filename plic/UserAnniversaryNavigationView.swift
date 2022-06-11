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
            Text("기념일 뷰 들어갈 곳")
                .navigationBarTitle("기념일", displayMode: .inline)
            /* 앞에서 네비게이션 바를 생성할 건데 여기서 이걸 해야 할 필요가 있을까용? 일단 주석 처리할게요
             
                .navigationBarItems(leading: NavigationLink(destination: 이전뷰(), label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }))*/
        }
    }
}

struct UserAnniversaryNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        UserAnniversaryNavigationView()
    }
}
