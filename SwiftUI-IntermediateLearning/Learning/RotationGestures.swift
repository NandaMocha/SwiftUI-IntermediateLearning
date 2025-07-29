//
//  RotationGesture.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 29/07/25.
//

import SwiftUI

struct RotationGestures: View {
    @GestureState private var rotateValue = 0.0
    @State private var angleValue: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
            .foregroundStyle(.white)
            .padding(50)
            .background(Color.blue.clipShape(.rect(cornerRadius: 10)))
            .rotationEffect(angleValue)
            .gesture(
                RotateGesture()
//                    .updating($rotateValue, body: { value, state, transaction in
//                        state = value.rotation.degrees
//                    })
                    .onChanged({ value in
                        angleValue = value.rotation
                    })
                    .onEnded({ _ in
                        angleValue = Angle(degrees: 0)
                    })
            )
        
    }
}

#Preview {
    RotationGestures()
}
