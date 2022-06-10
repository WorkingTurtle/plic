//
//  DetailScheduleView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/10.
//

import SwiftUI

struct DetailScheduleView: View {
    var body: some View {
        NavigationView{
            Text("뷰 들어갈 곳")
            //네비게이션 설정 (임의로 ContentView)
                .navigationBarTitle("세부 일정", displayMode: .inline)
                .navigationBarItems(
                    leading: NavigationLink(destination: ContentView(), label: {
                        Image(systemName: "chevron.left")
                        Text("오늘의 일정")
                            .offset(x: -5)
                    }),
                    trailing: NavigationLink(destination: ContentView(), label: {
                        Text("Edit")
                    })
                )
        }
    }
}

struct DetailScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        DetailScheduleView()
    }
}
