//
//  GeometryReaderMaterials.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 30/07/25.
//

import SwiftUI

struct GeometryReaderMaterials: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(
                            cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 25),
                                axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 200, height: 200)
                    .padding()
                }
            }
        }
    }
    
    private func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    private var practiceOne: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(.red)
                    .frame(width: geometry.size.width * 0.8)
                Rectangle()
                    .fill(.blue)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    GeometryReaderMaterials()
}
