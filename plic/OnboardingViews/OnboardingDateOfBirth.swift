//
//  OnboardingDateOfBirth.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI


struct OnboardingDateOfBirth: View {
    @State var titleText: String = "본인의 생년월일을 \n입력해 주세요"
    @State var subtitleText: String = "커플 달력에 표시될 생일 날짜입니다"
    @State var buttonText: String = "다음 단계"
    @State var dateOfBirth = Date()
    
    //날짜 포맷 함수
    static let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    
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
                        RecycleDatePicker(dateOfBirth: $dateOfBirth)
                        RecycleNextButton(buttonText: $buttonText)
                    }
                Spacer()
            }
        }
    }
}

struct OnboardingDateOfBirth_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDateOfBirth()
    }
}
