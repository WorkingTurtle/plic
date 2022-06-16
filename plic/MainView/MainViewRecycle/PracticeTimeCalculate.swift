//
//  PracticeTimeCalculate.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/15.
//

import SwiftUI

struct PracticeTimeCalculate: View {
    var currentTimeArr: [Int] = [0, 1, 2, 3]
    var currentTime = Date()
    
    //현재 날짜로부터의 시간의 흐름: 단위가 초이기 때문에 간편화 (4시간 * 60초 * 60초)
    let laterDate = Date(timeIntervalSinceNow: 4 * 60 * 60)
    
    static let HourDateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }()
    
    
    var body: some View {
        
        //    00:00
        //    01:00
        //    02:00
        //    03:00
        //    ForEach를 써서 (x * 60초 * 60초)를 사용. x를 i라 생각하고 사용
        //    자동으로 배열에 담아주는 ForEach문 생성
        
        ForEach(currentTimeArr, id: \.self) { x in
            let laterDate = Date(timeIntervalSinceNow: TimeInterval(x * 60 * 60))
            Text("\(laterDate, formatter: PracticeTimeCalculate.HourDateformat):00")
        }
    }
}

struct PracticeTimeCalculate_Previews: PreviewProvider {
    static var previews: some View {
        PracticeTimeCalculate()
    }
}
