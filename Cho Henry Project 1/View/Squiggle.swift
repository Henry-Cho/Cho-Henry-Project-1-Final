//
//  SnuggleView.swift
//  Cho Henry Project 1
//
//  Created by Henry Cho on 10/16/23.
//

import SwiftUI

let segments = [
    (CGPoint(x: 630, y: 540), CGPoint(x: 1124, y: 369), CGPoint(x: 897, y: 688)),
    (CGPoint(x: 270, y: 530), CGPoint(x: 523, y: 513), CGPoint(x: 422, y: 420)),
    (CGPoint(x: 50, y: 400), CGPoint(x: 96, y: 656), CGPoint(x: 54, y: 583)),
    (CGPoint(x: 360, y: 120), CGPoint(x: 46, y: 220), CGPoint(x: 191, y: 97)),
    (CGPoint(x: 890, y: 140), CGPoint(x: 592, y: 152), CGPoint(x: 619, y: 315)),
    (CGPoint(x: 1040, y: 150), CGPoint(x: 953, y: 100), CGPoint(x: 1009, y: 69))
]

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        guard let lastSegment = segments.last else {
            return path
        }
        
        path.move(to: lastSegment.0)
        segments.forEach { path.addCurve(to: $0, control1: $1, control2: $2) }
        
        path = path.offsetBy(
            dx: rect.minX - path.boundingRect.minX,
            dy: rect.minY - path.boundingRect.minY)
        
        let scale = rect.height / path.boundingRect.width
        let transform = CGAffineTransform(scaleX: scale, y: scale)
            .rotated(by: Double.pi / 2)
        
        path = path.applying(transform)
        
        return path.offsetBy(dx: rect.width, dy: 0)
    }
}

#Preview {
    VStack {
        ForEach(0..<1) { _ in
            ZStack {
                GeometryReader { geometry in
                    Squiggle()
                        .offset(CGSize(width: -geometry.size.width * 3 / 8, height: 0))
                        .scale(2.0)
                        .stroke(lineWidth: 8)
                }
                GeometryReader { geometry in
                    Squiggle()
                        .offset(CGSize(width: -geometry.size.width * 3 / 8, height: 0))
                        .scale(2.0)
                        .opacity(0.25)
                }
                    
            }
            .rotationEffect(Angle(degrees: 90))
            .aspectRatio(2, contentMode: .fit)
            
        }
    }
    .foregroundColor(.purple)
    .padding()
}
