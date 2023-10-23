//
//  Oval.swift
//  Cho Henry Project 1
//
//  Created by Henry Cho on 10/16/23.
//

import SwiftUI

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


#Preview
{
    VStack {
        ForEach(0..<3) { _ in
            ZStack {
                GeometryReader { geometry in
                    Oval()
                        .scale(2.0)
                        .stroke(lineWidth: 8)
                }
                GeometryReader { geometry in
                    Oval()
                        .scale(2.0)
                        .opacity(0.25)
                }
                    
            }
            .rotationEffect(Angle(degrees: 90))
            .aspectRatio(1/3, contentMode: .fit)
            
        }
    }
    .foregroundColor(.purple)
    .padding(100)
    .background()
}
