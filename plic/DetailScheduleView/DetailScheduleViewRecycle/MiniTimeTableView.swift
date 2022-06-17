//
//  MiniTimeTableView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/16.
//

import SwiftUI


struct MiniTimeTableView: View {
    let testSchedule: DumyTime
                                         
    var currentTimeArr: [Int] = [0, 1, 2, 3]
    
    var body: some View {
        ZStack(alignment: .top){
            HStack{
                VStack{
                    ForEach(currentTimeArr, id: \.self) { x in
                        Text("\(Int(testSchedule.startTime) + x):00")
                            .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                            .foregroundColor(Color("plicTime"))
                            .frame(height: 10)
                            .padding(.bottom, 25)
                    }
                }
                
                Spacer()
                
                VStack{
                    ForEach(currentTimeArr, id: \.self){ item in
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .frame(height: 10)
                            .foregroundColor(Color("plicLine"))
                            .padding(.bottom, 25)
                    }
                }.padding(.top, 11)
            }
            
                VStack{
                    if(testSchedule.who == 0){
                        DetailTimeTableView(letter: testSchedule.name, num: testSchedule.endTime - testSchedule.startTime, who: testSchedule.who)
//                            .padding(.top, CGFloat((testSchedule.startTime - 9) * 43))
                            .offset(x: -60, y: 0)
                    }
                    else if(testSchedule.who == 1){
                        DetailTimeTableView(letter: testSchedule.name, num: testSchedule.endTime - testSchedule.startTime, who: testSchedule.who)
                            .offset(x: 15, y: 0)
//                            .padding(.top, CGFloat((testSchedule.startTime - 9) * 43))
                    }
                    else
                    {
                        DetailTimeTableView(letter: testSchedule.name, num: testSchedule.endTime - testSchedule.startTime, who: testSchedule.who)
                            .offset(x: 90, y: 0)
//                            .padding(.top, CGFloat((testSchedule.startTime - 1.3) * 43))
                    }
                    Spacer()
                }.padding(.top, 10)

        }
    }
}

//struct MiniTimeTableView_Previews: PreviewProvider {
//    static var previews: some View {
//        MiniTimeTableView()
//    }
//}
