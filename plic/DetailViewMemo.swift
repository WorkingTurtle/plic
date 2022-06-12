//
//  DetailViewMemo.swift
//  plic
//
//  Created by Youngseo Yoon on 2022/06/11.
//

import SwiftUI


// 작성된 메모 확인란
struct DetailViewMemo: View {
    @State var memoText: String?
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "square.and.pencil")
                    .frame(width: 16, height: 18)
                    .foregroundColor(Color("plicPink"))
                    .padding(.leading, 24)
                Text("메모")
                    .font(.custom("SpoqaHanSansNeo-Regular",size: 14))
                    .padding(.leading, 5)
                Spacer()
            }
            
            ZStack(alignment: .topLeading){
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350, height: 146)
                    .foregroundColor(Color("plicLightestgrey"))
                Text("\(memoText ?? "비어 있는 메모")")
                    .font(.custom("SpoqaHanSansNeo-Regular",size: 14))
                    .foregroundColor((memoText != nil) ? .black : .gray)
                    .padding(12)
            }
        }
    }
}

struct DetailViewMemo_Previews: PreviewProvider {
    static var previews: some View {
        DetailViewMemo()
    }
}
