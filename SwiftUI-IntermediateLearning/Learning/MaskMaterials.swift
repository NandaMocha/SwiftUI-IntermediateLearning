//
//  MaskMaterials.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 30/07/25.
//

import SwiftUI

struct MaskMaterials: View {
    @State var rating: Int = 0
    var body: some View {
        itemTomask
            .overlay { overlayView.mask(itemTomask)}
    }
    
    private var itemTomask: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.title)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
//                    .foregroundStyle(.blue)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .pink]), startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
                
            }
        }
        .allowsHitTesting(false)
    }
}

#Preview {
    MaskMaterials()
}
