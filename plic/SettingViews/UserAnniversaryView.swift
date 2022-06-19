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
                    VStack{
                        HStack{
                            // Text("D-\(item.dDay)")
                            Text("D-10")
                                .font(Font.custom("SpoqaHanSansNeo-Bold", size: 30))
                                .foregroundColor(Color("plicPink"))
                                .padding(.leading, 5)
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\(item.startDate)")
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
//    
//    func days(date: Date) -> _ Int {
//        return Calendar.current.dateComponents([.day], from: date, to: dDay).day + 1
//    }
    
}



struct UserAnniversaryView_Previews: PreviewProvider {
    static var previews: some View {
        UserAnniversaryView()
    }
}

