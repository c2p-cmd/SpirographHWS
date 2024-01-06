//
//  ArrowView.swift
//  SpirographHWS
//
//  Created by Sharan Thakur on 06/01/24.
//

import SwiftUI

// MARK: Arrow Insettable Shape
struct Arrow: InsettableShape {
    var insetAmount: CGFloat = 0.0
    
    var animatableData: CGFloat {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY + rect.midY / 4))
        
        path.addLine(to: CGPoint(x: rect.maxX * 0.5, y: rect.midY + rect.midY / 4))
        path.addLine(to: CGPoint(x: rect.maxX * 0.5, y: rect.midY - rect.midY / 2))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        path.addLine(to: CGPoint(x: rect.maxX * 0.5, y: rect.midY + rect.midY / 2))
        path.addLine(to: CGPoint(x: rect.maxX * 0.5, y: rect.midY - rect.midY / 4))
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY - rect.midY / 4))
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY + rect.midY / 4))
        
        path.closeSubpath()
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

// MARK: - Arrow's Host View
struct ArrowView: View {
    @State private var insetAmount = 10.0
    @State private var rotate = 0.0
    
    var body: some View {
        VStack {
            List {
                Text("1. Create an Arrow shape – having it point straight up is fine. This could be a rectangle/triangle-style arrow, or perhaps three lines, or maybe something else depending on what kind of arrow you want to draw.")
                
                Text("2. Make the line thickness of your Arrow shape animatable.")
            }
            .scrollDisabled(true)
            .listStyle(.grouped)
            .font(.system(.headline, design: .rounded, weight: .semibold))
            .multilineTextAlignment(.leading)
            
            Arrow()
                .strokeBorder(
                    Color.accent,
                    style: StrokeStyle(lineWidth: insetAmount, lineCap: .round, lineJoin: .round)
                )
                .fill(.ultraThinMaterial)
                .rotationEffect(.degrees(rotate), anchor: .center)
                .frame(width: 200, height: 300)
                .padding(.bottom, 50)
                .tabItem { Label("2", systemImage: "2.circle") }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Tap to Animate 😉", action: changeInset)
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.roundedRectangle(radius: 5))
                    }
                }
        }
        .navigationTitle("Arrow Challenge View")
    }
    
    func changeInset() {
        withAnimation(.bouncy(duration: 0.75, extraBounce: 0.5)) {
            insetAmount = insetAmount > 10 ? 10 : 20
        }
        
        withAnimation(.smooth(duration: 1, extraBounce: 0.5)) {
            rotate -= 90
        }
    }
}

#Preview {
    NavigationStack {
        ArrowView()
            .preferredColorScheme(.dark)
    }
}
