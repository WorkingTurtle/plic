//
//  UserAnniversaryView.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/11.
//

import SwiftUI



struct UserAnniversaryView: View {
    @EnvironmentObject var coupleViewModel: CoupleViewModel
    @State var isPresentedAddAnniversary: Bool = false
    let dDay = Date()
    
    
    var body: some View {
            VStack{
                ForEach(coupleViewModel.schedules, id: \.self) { item in
                    if(item.isSpecialDay){
                        VStack{
                            HStack{
                                Text("D-\(dDaycal(item.startDate) ?? 0)")
                                    .font(Font.custom("SpoqaHanSansNeo-Bold", size: 30))
                                    .foregroundColor(Color("plicPink"))
                                    .padding(.leading, 5)
                                Spacer()
                                VStack(alignment: .trailing){
                                    Text("\(dateToString(item.startDate))")
                                        .font(Font.custom("SpoqaHanSansNeo-Regular", size: 13))
                                        .foregroundColor(Color("plicGrey"))
                                    Text("\(item.title)")
                                        .font(Font.custom("SpoqaHanSansNeo-Bold", size: 16))
                                }
                            }
                            .padding(.horizontal, 20)
                            Divider()
                                .padding(.horizontal, 20)
                        }
                    }
                    
                }
                Spacer()
            }
            .navigationBarTitle(Text("기념일"), displayMode: .inline)
                .font(.custom("SpoqaHanSansNeo-Bold", size: 17))
            .navigationBarItems(trailing: Button(action: {isPresentedAddAnniversary = true}) {
                    Image(systemName: "plus")
            }
            .foregroundColor(Color("plicPink")))
            .sheet(isPresented: $isPresentedAddAnniversary) {
                UserAnniversaryAddView()
            }
            .padding(.top, 30)
    }
    
    func dDaycal(_ date: Date) -> Int{
        return (Calendar.current.dateComponents([.day], from: dDay, to: date).day!) + 1
    }
    
    func dateToString(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY년 M월 d일"
            let date = formatter.string(from: date)
            
            return date
    }
}


