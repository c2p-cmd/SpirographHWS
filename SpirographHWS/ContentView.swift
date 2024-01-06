//
//  ContentView.swift
//  SpirographHWS
//
//  Created by Sharan Thakur on 06/01/24.
//

import SwiftUI

struct ContentView: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount = 1.0
    @State private var color: Color = .cyan
    @State private var rotation: Angle = .degrees(.zero)
    
    var myGesture: some Gesture {
        RotateGesture()
            .onChanged { newValue in
                rotation = newValue.rotation
            }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Spirograph(
                innerRadius: innerRadius.toInt(),
                outerRadius: outerRadius.toInt(),
                distance: distance,
                amount: amount
            )
            .stroke(color)
            .frame(width: 300, height: 300)
            .rotationEffect(rotation, anchor: .center)
            .gesture(myGesture)
            
            Spacer()
            
            Group {
                Text("Inner Radius: \(innerRadius.toInt())")
                Slider(value: $innerRadius, in: 10...150)
                    .padding([.horizontal, .bottom])
                
                Text("Outer Radius: \(outerRadius.toInt())")
                Slider(value: $outerRadius, in: 10...180)
                    .padding([.horizontal, .bottom])
                
                Text("Distance: \(distance.toInt())")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Amount: \(amount.formatted())")
                Slider(value: $amount)
                    .padding([.horizontal, .bottom])
                
                ColorPicker(selection: $color, supportsOpacity: false) {
                    Text("Color:")
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ContentView()
}
