//
//  WeeklyView.swift
//  plic
//
//  Created by 이주화 on 2022/06/14.
//

import SwiftUI

struct WeeklyView: View {
    
    
    var body: some View {
        
        VStack{
            HStack{
                DayPickerView()
            }
            HStack{
                WeeklyTimeTable()
            }    
        }
    }
}

struct WeeklyView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyView()
    }
}
