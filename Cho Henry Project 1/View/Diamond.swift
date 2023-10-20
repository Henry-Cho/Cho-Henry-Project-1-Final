//
//  Diamond.swift
//  Cho Henry Project 1
//
//  Created by Henry Cho on 10/16/23.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.midY)
        let firstPoint = CGPoint(x: rect.midX, y: rect.minY)
        let secondPoint = CGPoint(x: rect.maxX, y: rect.midY)
        let end = CGPoint(x: rect.midX, y: rect.maxY)
        
        var p = Path()
        p.move(to: start)
        p.addLine(to: firstPoint)
        p.addLine(to: secondPoint)
        p.addLine(to: end)
        p.addLine(to: start)
        p.addLine(to: firstPoint)
        
        return p
    }
}

#Preview {
    HStack {
        ForEach(0..<3) { _ in
            ZStack {
                Diamond().stroke(lineWidth: 8)
                Diamond().opacity(0.25)
            }
            .aspectRatio(1/3, contentMode: .fit)
            .padding(.trailing)
        }
    }
    .foregroundColor(.purple)
    .padding()
    .rotationEffect(Angle(degrees: 90))
}
