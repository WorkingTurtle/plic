//
//  OnboardingFirstDayWeMet.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI

struct OnboardingFirstDayWeMet: View {
    @State private var isButtonClicked = false
    @State var firstDayWeMet = Date()
    let titleText: String = "처음 사귀게 된 \n기념일은 언제인가요?"
    let subtitleText: String = "기념일 날짜를 세고 위젯에 표시합니다"
    let buttonText: String = "다음단계"
    
    var body: some View {
        ZStack{
            Image("onboardingBackgroundImage2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0){
                
                Spacer()
                
                RecycleTitleText(titleText: titleText, subtitleText: subtitleText)
                
                VStack{
                    
                    RecycleDatePicker(date: $firstDayWeMet)
                    
                    NavigationLink(destination: TapBarMainView(tabbarIndex: 0), isActive: $isButtonClicked){ EmptyView() }
                        .disabled(true)
                    
                    Button(action: {
                        isButtonClicked = true
                    }) {
                        Text("\(buttonText)")
                            .font(Font.custom("SpoqaHanSansNeo-Bold", size: 18))
                            .foregroundColor(Color("plicPink"))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white).cornerRadius(10))
                            .padding(.horizontal, 20)
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 23)
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
                    Spacer()
                }
                .padding(.bottom, 31)
            }
        }.navigationBarHidden(true)
    }
}

struct OnboardingFirstDayWeMet_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFirstDayWeMet()
    }
}
