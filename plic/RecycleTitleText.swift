//
//  RecycleTitleText.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI

struct RecycleTitleText: View {
    var titleText: String
    var subtitleText: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("\(titleText)")
                .font(Font.custom("SpoqaHanSansNeo-Bold", size: 25))
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .padding(.leading, 20)
                .padding(.bottom, 15)
            Text("\(subtitleText)")
                .font(Font.custom("SpoqaHanSansNeo-Regular", size: 13))
                .foregroundColor(Color("plicGrey"))
                .padding(.leading, 20)
                .padding(.bottom, 30)
        }
    }
}
