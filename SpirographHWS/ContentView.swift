//
//  ContentView.swift
//  SpirographHWS
//
//  Created by Sharan Thakur on 06/01/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("innerRadius") private var innerRadius = 125.0
    @AppStorage("outerRadius") private var outerRadius = 75.0
    @AppStorage("distance") private var distance = 25.0
    
    @AppStorage("title") private var title = "Spirograph ⚛️"
    
    @State private var amount = 1.0
    @State private var color: Color = .cyan
    @State private var rotation: Angle = .degrees(.zero)
    @State private var show = false
    
    var myGesture: some Gesture {
        RotateGesture()
            .onChanged { newValue in
                rotation = newValue.rotation
            }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()
                
                mySpirograph()
                    .frame(width: 300, height: 300)
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
                    Slider(value: $distance, in: 1...200, step: 1)
                        .padding([.horizontal, .bottom])
                    
                    Text("Amount: \(amount.formatted())")
                    Slider(value: $amount, in: 0...1)
                        .padding([.horizontal, .bottom])
                    
                    ColorPicker(selection: $color, supportsOpacity: false) {
                        Text("Color:")
                    }
                    .padding(.horizontal)
                }
            }
            .sheet(isPresented: $show) {
                renderToImage { uiImage in
                    VStack {
                        Image(uiImage: uiImage)
                        
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    .font(.title.monospaced())
                    .symbolEffect(.variableColor.cumulative.dimInactiveLayers.reversing)
                    .tint(.mint)
                }
                .presentationDetents([.medium])
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle($title)
            .toolbar {
                Button {
                    show = true
                } label: {
                    Label("Save", systemImage: "photo.badge.arrow.down")
                        .animation(.default, value: show.description)
                        .contentTransition(.symbolEffect(.replace.upUp.byLayer))
                        .id(show.description)
                }
            }
        }
    }
    
    func mySpirograph() -> some View {
        Spirograph(
            innerRadius: innerRadius.toInt(),
            outerRadius: outerRadius.toInt(),
            distance: distance,
            amount: amount
        )
        .stroke(color)
        .rotationEffect(rotation, anchor: .center)
    }
    
    @MainActor
    func renderToImage<Label: View>(
        @ViewBuilder label: (UIImage) -> Label
    ) -> some View {
        let imageRenderer = ImageRenderer(content: mySpirograph())
        imageRenderer.scale = 2.0
        
        let backUp = UIImage(systemName: "doc.text.image.fill")!
        let uiImage = imageRenderer.uiImage ?? backUp
        
        return ShareLink(
            item: Image(uiImage: uiImage),
            preview: SharePreview(
                "Spirograph",
                image: Image(uiImage: uiImage),
                icon: Image(uiImage: backUp)
            ),
            label: {
                label(uiImage)
            }
        )
    }
}

#Preview {
    ContentView()
}
