//
//  RecycleSubtitleTextOnly.swift
//  plic
//
//  Created by 이영준 on 2022/06/15.
//

import SwiftUI

struct RecycleSubtitleTextOnly: View {
    var subtitleText: String
    var body: some View {
        Text("\(subtitleText)")
            .font(Font.custom("SpoqaHanSansNeo-Regular", size: 13))
            .foregroundColor(Color("plicGrey"))
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
            .padding(.leading, 20)
    }
}
