//
//  OnboardingFirstDayWeMet.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI

struct OnboardingFirstDayWeMet: View {
    @State var titleText: String = "처음 사귀게 된 \n기념일은 언제인가요?"
    @State var subtitleText: String = "기념일 날짜를 세고 위젯에 표시합니다"
    @State var firstDayWeMet = Date()
    @State var buttonText: String = "다음단계"
    
    var body: some View {
        ZStack{
            Image("onboardingBackgroundImage2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 30){
                RecycleTitleText(titleText: $titleText, subtitleText: $subtitleText)
                VStack{
                    RecycleDatePicker(date: $firstDayWeMet)
                    RecycleNextButton(buttonText: $buttonText)
                }
                HStack(spacing: 12){
                    Spacer()
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color("plicLightgrey"))
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color("plicLightgrey"))
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color("plicPink"))
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color("plicLightgrey"))
                    Spacer()
                }
                .padding(.bottom, 31)
            }
        }
    }
}

struct OnboardingFirstDayWeMet_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFirstDayWeMet()
    }
}
