//
//  AddSchedule.swift
//  plic
//
//  Created by 최홍준 on 2022/06/10.
//

import SwiftUI

struct AddSchedule: View {
    
    // Modal View 생성
    @State private var showModal = false
    
    var body: some View {
        Button(action: {self.showModal.toggle()}) {
            Text("Button")
                .sheet(isPresented: $showModal) {
                    AddSchedule1()
                }
        }
    }
}

struct AddSchedule_Previews: PreviewProvider {
    static var previews: some View {
        AddSchedule()
    }
}
