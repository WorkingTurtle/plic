//
//  UserSettingView2.swift
//  plic
//
//  Created by 김승훈 on 2022/06/12.
//

import SwiftUI

struct UserSettingView: View {
    let letterArr: [String] = ["기념일", "알림 설정", "캘린더 연동", "커플 연결", "로그아웃"]
    let myNickName: String = "디기"
    let opponentNickName: String = "뱃저"
    let firstDay: String = "123"
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(spacing:30){
                    Image("TabMain").frame(width: .infinity)
                    
                    HStack {
                        Circle()
                            .frame(width:65, height:65)
                            .foregroundColor(Color("plicPink"))
                        Spacer()
                        NavigationLink(destination: SettingProfileView(), label: {
                            VStack(alignment:.leading){
                                Text("\(myNickName)♥\(opponentNickName)")
                                    .font(.custom("SpoqaHanSansNeo-Bold", size: 24))
                                    .foregroundColor(Color("plicPink"))
                                Text("\(firstDay)째 연애중")
                                    .font(.custom("SpoqaHanSansNeo-Regular", size: 13))
                                    .foregroundColor(Color("plicPink"))
                            }
                            .padding(.leading, 15)
                            .padding(.top, 15)
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color("plicGrey"))
                        })
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 10)
                    
                    VStack(spacing:30){
                        NavigationLink(destination: UserAnniversaryView(), label: {
                            SettingListView(letter : letterArr[0])
                        })
                        NavigationLink(destination: UserSettingNotificationView(), label: {
                            SettingListView(letter : letterArr[1])
                        })
                        NavigationLink(destination: UserAnniversaryView(), label: {
                            SettingListView(letter : letterArr[2])
                        })
                        NavigationLink(destination: UserAnniversaryView(), label: {
                            SettingListView(letter : letterArr[3])
                        })
                        NavigationLink(destination: UserAnniversaryView(), label: {
                            SettingListView(letter : letterArr[4])
                        })
                    }
                }
            }.ignoresSafeArea()
        }
        .accentColor(Color("plicPink"))
    }
}

struct SettingListView : View{
    var letter : String
    var body: some View {
        HStack(){
            Text("\(letter)")
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(Color("plicGrey"))
                .frame(maxWidth:200,alignment:.leading)
                .padding(.leading,30)
            
            Image(systemName: "chevron.forward")
                .foregroundColor(Color("plicGrey"))
                .frame(maxWidth:255, maxHeight: 30, alignment: .trailing)
                .listRowInsets(EdgeInsets())
                .padding(.trailing,30)
        }
    }
}

struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingView()
    }
}
