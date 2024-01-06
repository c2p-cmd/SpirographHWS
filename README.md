# Spirograph HWS

![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fgoogle%2Fgenerative-ai-swift%2Fbadge%3Ftype%3Dswift-versions)

## An app to draw spirograph using SwiftUI
- Followed Hacking With Swift's [tutorial](https://www.youtube.com/watch?v=V2fxC92HGnQ)
- My Additions:
  - Added rotation support to the app: [link](https://developer.apple.com/documentation/swiftui/rotategesture)
  ```swift
    @State private var rotation: Angle = .degrees(.zero)
    
    var myGesture: some Gesture {
        RotateGesture()
            .onChanged { newValue in
                rotation = newValue.rotation
            }
    }


    /// rest of the code

    // main spirograph view
    .rotationEffect(rotation, anchor: .center)
    .gesture(myGesture)
  ```
  - Math taken from: [WikiPedia](https://en.wikipedia.org/wiki/Spirograph#Mathematical_basis)