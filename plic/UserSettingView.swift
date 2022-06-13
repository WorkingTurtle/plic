//
//  UserSettingView2.swift
//  plic
//
//  Created by 김승훈 on 2022/06/12.
//

import SwiftUI

extension Color {
    static let Symbole_Color = Color("plicCirclepink")
    static let SettingView_FontColor = Color("plicGrey")
    static let SettingView_FontColor2 = Color("plicDarkgrey")
    
    
}

struct UserSettingView: View {
    let letterArr: [String] = ["기념일", "알림 설정", "캘린더 연동", "커플 연결", "로그아웃"]
    
    var body: some View {
        ScrollView {
            VStack(spacing:30){
                Image("TabMain").frame(width: .infinity)
//                    .offset(y:-195)
            
               
                HStack(spacing:50){
                    Circle()
                        .frame(width:65, height:65).foregroundColor(.Symbole_Color)
                VStack(alignment:.leading){
                    Text("뱃저♥디기").font(.title).foregroundColor(.Symbole_Color).offset(x:-30)
                   
                        Text("123일째 연애중").font(.subheadline).foregroundColor(.Symbole_Color)
                        .offset(x:-30)
                        
                    
                    
                        
                    }
                    Image(systemName: "chevron.forward").foregroundColor(.SettingView_FontColor2)
                }
                
                VStack(){
                    ForEach(letterArr, id: \.self){ value in
                        SettingListView(letter: value)
                    }
            }
                    
            }
        
        }.ignoresSafeArea()
     
            
  }
}


struct SettingListView : View{
    var letter : String
    var body: some View {
        HStack(){
            Text("\(letter)").font(.system(size: 17, weight: .medium)).foregroundColor(.SettingView_FontColor2)
                
            Image(systemName: "chevron.forward").foregroundColor(.SettingView_FontColor2)
                .frame(maxWidth:255, maxHeight: 30, alignment: .trailing)
                       .listRowInsets(EdgeInsets())
        }
    }
}






        


struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingView()
    }
}
