//
//  ContentView.swift
//  Tutorial
//
//  Created by Kristhian De Oliveira on 9/30/20.
//

import SwiftUI
struct ContentView: View {
    @State var percent:Float
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                Circle().stroke(Color.white, lineWidth: 30)
                    .opacity(0.1)
                    .scaleEffect(CGSize(width: 0.8, height: 0.8))
                Arc(startAngle: .degrees(percentCalculations()), endAngle: .degrees(90), clockwise: true)
                    .stroke(Color.green, lineWidth: 30)
                    .scaleEffect(CGSize(width: 0.8, height: 0.8))
                    .rotationEffect(.init(degrees: 200.0))
                    .shadow(color: .green, radius: 10, x: 0.0, y: 0.1)
                Image(systemName: "bolt.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
                    .foregroundColor(.green)
            }.frame(width: UIScreen.main.bounds.width, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("\(percent)% Charged").foregroundColor(.white)
        }.background(
            Image("").data(url: URL(string: "https://www.kolpaper.com/wp-content/uploads/2020/10/iPhone-12-Pro-Wallpaper.jpg")!)
                .scaledToFill()
                .blur(radius: 20.0)
        )
    }
    func percentCalculations() -> Double {
        if 0.0...25.0 ~= percent {
            return -50
        }
        if 26.0...50.0 ~= percent {
            return -100
        }
        if 51.0...75.0 ~= percent {
            return -200
        }
        if 76.0...100.0 ~= percent {
            return -300
        }
        return -300
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(percent: 50)
    }
}
struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        return path
    }
}
extension Image {
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!).resizable()
        }
        return self.resizable()
    }
}
