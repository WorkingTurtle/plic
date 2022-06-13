//
//  RecycleTitleText.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI

struct RecycleTitleText: View {
    @Binding var titleText: String
    @Binding var subtitleText: String
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text("\(titleText)")
                .font(Font.custom("SpoqaHanSansNeo-Bold", size: 25))
                .padding(EdgeInsets(top: 308, leading: 20, bottom: 0, trailing: 0))
            Text("\(subtitleText)")
                .font(Font.custom("SpoqaHanSansNeo-Regular", size: 13))
                .foregroundColor(Color("plicGrey"))
                .padding(.leading, 20)
        }
    }
}
