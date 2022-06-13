//
//  OnboardingUsernameView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/13.
//

import SwiftUI

struct OnboardingUsernameView: View {
    @Binding var show: Bool
    var body: some View {
        Button(action: {
            self.show.toggle()
        }){
            Text("Move")
        }
    }
}

struct OnboardingUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingUsernameView(show: .constant(true))
    }
}
