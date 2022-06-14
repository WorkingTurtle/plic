//
//  MainTimeTableView.swift
//  plic
//
//  Created by 이주화 on 2022/06/13.
//

import SwiftUI

struct MainTimeTableView: View {
    var month: String = "6"
    var day: String = "23"
    let firstNick: String = "디기"
    let secondNick: String = "벳져"
    
    var body: some View {
        VStack{
            HStack{
                MainTimeTableTitleView(month: month, day: day)
            }
            .padding(.bottom, 15)
            HStack{
                TimeTableNameView(firstNick: firstNick, secondNick: secondNick)
            }.padding([.leading,.trailing], 60)
            HStack{
                TimeTableMiniView()
            }
        }
        .padding([.leading,.trailing], 20)
        .frame(height: 230)
    }
}

struct MainTimeTableView_Previews: PreviewProvider {
    static var previews: some View {
        MainTimeTableView()
    }
}

struct MainTimeTableTitleView: View {
    let month: String
    let day: String
    
    var body: some View {
        HStack{
            Text("\(month)월 \(day)일의 일정")
                .font(.custom("SpoqaHanSansNeo-Bold",size: 16))
                .foregroundColor(Color("plicBlack"))
            Spacer()
            Image(systemName: "chevron.right")
                .font(.custom("SpoqaHanSansNeo-Bold",size: 16))
                .foregroundColor(Color("plicGrey"))
        }
    }
}

struct TimeTableNameView: View {
    let firstNick: String
    let secondNick: String
    
    var body: some View {
        HStack{
            Text(firstNick)
                .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                .foregroundColor(Color("plicTime"))
            Spacer()
            Image(systemName: "heart.fill")
                .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                .foregroundColor(Color("plicPink"))
            Spacer()
            Text(secondNick)
                .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                .foregroundColor(Color("plicTime"))
        }
    }
}

struct TimeTableMiniView : View {
    let firstTime: String = "09:00"
    let secondTime: String = "10:00"
    let thirdTime: String = "11:00"
    let fourthTime: String = "12:00"

    
    var body: some View {
        VStack{
            Text(firstTime)
                .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                .foregroundColor(Color("plicTime"))
            Spacer()
            Text(secondTime)
                .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                .foregroundColor(Color("plicTime"))
            Spacer()
            Text(thirdTime)
                .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                .foregroundColor(Color("plicTime"))
            Spacer()
            Text(fourthTime)
                .font(.custom("SpoqaHanSansNeo-Bold",size: 12))
                .foregroundColor(Color("plicTime"))
        }
        Spacer()
        VStack{
                Line()
                           .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                           .frame(height: 1)
                           .foregroundColor(Color("plicLine"))
                           .padding(.top, 8)
            Spacer()
                Line()
                           .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                           .frame(height: 1)
                           .foregroundColor(Color("plicLine"))
            Spacer()
                Line()
                           .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                           .frame(height: 1)
                           .foregroundColor(Color("plicLine"))
            Spacer()
                Line()
                       .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                       .frame(height: 1)
                       .foregroundColor(Color("plicLine"))
                       .padding(.bottom, 8)
        }
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
