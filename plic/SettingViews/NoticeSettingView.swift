//
//  NoticeSettingView.swift
//  plic
//
//  Created by 김승훈 on 2022/06/14.
//

import SwiftUI



struct NoticeSettingView: View {
    
    @State private var togetherScheduleToggle = false
    @State private var opponentScheduleToggle = false
    
    var body: some View {
        VStack{
            HStack{
                Text("커플 일정 등록 알림")
                    .font(Font.custom("SpoqaHanSansNeo-Medium", size: 17))
                    .foregroundColor(Color("plicGrey"))
                Spacer()
                Toggle("", isOn: $togetherScheduleToggle)
                    .toggleStyle(SwitchToggleStyle(tint: Color("plicPink")))
                if togetherScheduleToggle {
                    Text("")
                } else {
                    Text("")
                }
            }.padding(.horizontal, 20)
            
            
            
            
            HStack{
                Text("상대방 일정 등록 알림")
                    .font(Font.custom("SpoqaHanSansNeo-Medium", size: 17))
                    .foregroundColor(Color("plicGrey"))
                Spacer()
                Toggle("",isOn: $opponentScheduleToggle)
                    .toggleStyle(SwitchToggleStyle(tint: Color("plicPink")))
                
                if opponentScheduleToggle {
                    Text("")
                } else {
                    Text("")
                }
            }.padding(.horizontal, 20)
            Spacer()
        }.padding(.top, 65)
    }
}


struct NoticeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeSettingView()
    }
}
