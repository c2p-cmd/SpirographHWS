//
//  ArrowView.swift
//  SpirographHWS
//
//  Created by Sharan Thakur on 06/01/24.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.midY + rect.midY / 4))
        
        path.addLine(to: CGPoint(x: rect.maxX * 0.5, y: rect.midY + rect.midY / 4))
        path.addLine(to: CGPoint(x: rect.maxX * 0.5, y: rect.midY - rect.midY / 2))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        path.addLine(to: CGPoint(x: rect.maxX * 0.5, y: rect.midY + rect.midY / 2))
        path.addLine(to: CGPoint(x: rect.maxX * 0.5, y: rect.midY - rect.midY / 4))
        
        path.addLine(to: CGPoint(x: 0, y: rect.midY - rect.midY / 4))
        
        path.addLine(to: CGPoint(x: 0, y: rect.midY + rect.midY / 4))
        
        path.closeSubpath()
        return path
    }
}

struct ArrowView: View {
    @State private var lineWidth = 10.0
    
    var body: some View {
        VStack {
            Text("Create an Arrow shape – having it point straight up is fine. This could be a rectangle/triangle-style arrow, or perhaps three lines, or maybe something else depending on what kind of arrow you want to draw.")
                .font(.system(.headline, design: .rounded, weight: .semibold))
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Arrow()
                .stroke(Color.yellow, lineWidth: lineWidth)
                .fill(LinearGradient(
                    colors: [.red, .purple, .blue],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .animation(.bouncy, value: lineWidth)
                .frame(width: 200, height: 300)
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Stepper("LineWidth: \(lineWidth.formatted())", value: $lineWidth, in: 1...20, step: 0.5)
            }
        }
        .padding(.horizontal)
        .navigationTitle("Arrow Challenge View")
    }
}

#Preview {
    NavigationStack {
        ArrowView()
            .preferredColorScheme(.dark)
    }
}
