//
//  NewView.swift
//  AwardsCollectionApp
//
//  Created by Юлия Ястребова on 27.06.2023.
//

import SwiftUI

struct CustomAwardView: View {
    @State private var trianglesAreRotating = false
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let minimumSize = min(width, height)
            let middle = minimumSize / 2 //100
            let quarter = minimumSize / 4 //50
            
            ZStack {
                CircleView(
                    foregroundColor: .none,
                    radius: height - 10,
                    strokeColor: .purple,
                    strokeLineWidth: 10)
                
                Path { path in
                    path.move(to: CGPoint(x: quarter, y: middle))
                    path.addQuadCurve(
                        to: CGPoint(x: middle, y: quarter),
                        control: CGPoint(x: quarter, y: quarter))
                    path.addQuadCurve(
                        to: CGPoint(x: quarter * 3, y: middle),
                        control: CGPoint(x: quarter * 3, y: quarter))
                    path.addQuadCurve(
                        to: CGPoint(x: middle, y: quarter * 3),
                        control: CGPoint(x: quarter * 3, y: quarter * 3))
                    path.addQuadCurve(
                        to: CGPoint(x: quarter, y: middle),
                        control: CGPoint(x: quarter, y: quarter * 3))
                }
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.pink, .blue]),
                        startPoint: UnitPoint(x: 0, y: 0),
                        endPoint: UnitPoint(x: 1, y: 1)
                    )
                )
                ForEach(0..<12) { iteration in
                    Path { path in
                        path.move(to: CGPoint(x: quarter, y: middle))
                        path.addLine(to: CGPoint(x: 0, y: quarter * 1.5))
                        path.addLine(to: CGPoint(x: quarter, y: quarter))
                    }
                    .fill(
                        LinearGradient(
                            colors: [.yellow, .green],
                            startPoint: UnitPoint(x: 1, y: 1),
                            endPoint: UnitPoint(x: 0, y: 1)
                        )
                    )
                    .rotationEffect(.degrees(Double(iteration) * 30))
                    .shadow(color: .yellow.opacity(0.5), radius: 15)
                    .rotationEffect(trianglesAreRotating ? .degrees(360) : .degrees(0))
                }
                
                CircleView(
                    foregroundColor: .cyan,
                    radius: quarter,
                    strokeColor: .purple,
                    strokeLineWidth: 4
                )
                CircleView(
                    foregroundColor: .none,
                    radius: quarter / 2,
                    strokeColor: .indigo,
                    strokeLineWidth: 2
                )
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                trianglesAreRotating = true
            }
        }
    }
}

struct CustomAwardView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAwardView()
            .frame(width: 200, height: 200)
    }
}

struct CircleView: View {
    let foregroundColor: Color?
    let radius: Double
    let strokeColor: Color
    let strokeLineWidth: Double
    
    var body: some View {
        Circle()
            .foregroundColor(foregroundColor ?? .none)
            .frame(width: radius)
            .overlay(Circle().stroke(strokeColor, lineWidth: strokeLineWidth))
    }
}


