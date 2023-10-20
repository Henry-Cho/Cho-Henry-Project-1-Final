//
//  Oval.swift
//  Cho Henry Project 1
//
//  Created by Henry Cho on 10/16/23.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.maxY)
        let firstPoint = CGPoint(x: rect.minX, y: rect.minY)    
        let secondPoint = CGPoint(x: rect.maxX, y: rect.minY)
        let end = CGPoint(x: rect.maxX, y: rect.maxY)
        
        var p = Path()
        p.move(to: start)
        p.addLine(to: firstPoint)
        p.addArc(center: CGPoint(x: rect.midX, y: rect.minY), radius: rect.width / 2, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: true)
        p.addLine(to: secondPoint)
        p.addArc(center: CGPoint(x: rect.midX, y: rect.maxY), radius: rect.width / 2, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 360), clockwise: true)
        p.addLine(to: end)
        
        return p
    }
}

#Preview
{
    Oval().aspectRatio(1/3, contentMode: .fit)
}
