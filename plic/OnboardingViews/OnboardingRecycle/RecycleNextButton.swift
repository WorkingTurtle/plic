//
//  RecycleNextButton.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI

struct RecycleNextButton: View {
    @Binding var buttonText: String
    var body: some View {
        Button(action: {
            
        }) {
            Text("\(buttonText)")
                .font(Font.custom("SpoqaHanSansNeo-Bold", size: 18))
                .foregroundColor(buttonText.isEmpty ? Color("plicGrey") : Color("plicPink"))
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white).cornerRadius(10))
                .padding(.horizontal, 20)
        }
    }
}

