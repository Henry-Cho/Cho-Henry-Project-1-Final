//
//  Oval.swift
//  Practice SetGame
//
//  Created by Henry Cho on 10/24/23.
//

import SwiftUI

struct OvalView: View {
    var body: some View {
        HStack {
            ForEach(0..<1) { _ in
                ZStack {
                    Oval()
                        .opacity(0.25)
                    Oval().stroke(lineWidth: 8)
                }
                .padding(120)
                .aspectRatio(1/2, contentMode: .fit)
            }
            .rotationEffect(Angle(degrees: 180))
        }
        .rotationEffect(Angle(degrees: 90))
        .foregroundStyle(.purple)
        .padding()
    }
}


struct Oval: Shape {

    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width / 2, rect.height / 2)
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY / 2))
        
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY / 2),
            radius: radius,
            startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 0),
            clockwise: false
        )
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.75))
    
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.maxY * 0.75),
            radius: radius,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 180),
            clockwise: false
        )
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY / 2))

        return path
    }
}



#Preview {
    OvalView()
}
