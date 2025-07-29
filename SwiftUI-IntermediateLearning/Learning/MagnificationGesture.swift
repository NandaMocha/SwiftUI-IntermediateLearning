//
//  MagnificationGesture.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 29/07/25.
//

import SwiftUI

struct MagnificationGesture: View {
    //Practice One
    @GestureState private var magnifyValue: CGFloat = 1.0
    @State private var lastAmount: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 10) {
            titleSection

            Rectangle()
                .frame(height: 300)
                .scaleEffect(lastAmount * magnifyValue)
                .gesture(
                    MagnifyGesture()
                        .updating($magnifyValue) { value, state, transaction in
                            state = value.magnification
                        }
                )
            
            actionSection
            
            Text("Just describe your idea and we’ll design your presentation in mere seconds. Every presentation is uniquely tailored to bring your ideas to life with fast AI-guided design.")
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Spacer()
        }
    }
}

//Practice Two
extension MagnificationGesture {
    private var titleSection: some View {
        HStack {
            Circle().frame(width: 35, height: 35)
            Text("Swiftful Thinking")
            Spacer()
            Image(systemName: "ellipsis")
        }
        .padding(.horizontal)
    }
    
    private var actionSection: some View {
        HStack(spacing: 16) {
            HStack(spacing: 2) {
                Image(systemName: "heart")
                Text("2020")
                    .font(.headline)
                    .fontWeight(.medium)
            }
            
            HStack(spacing: 2) {
                Image(systemName: "text.bubble")
                Text("10")
                    .font(.headline)
                    .fontWeight(.medium)
            }
            
            HStack(spacing: 2) {
                Image(systemName: "paperplane")
                Text("910")
                    .font(.headline)
                    .fontWeight(.medium)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

//Practice One
extension MagnificationGesture {
    private var practiceOne: some View {
        Text("Hello, World!")
            .font(.title)
            .padding(40)
            .background(
                Color.red
                    .clipShape(.rect(cornerRadius: 10))
            )
            .scaleEffect(lastAmount * magnifyValue)
            .gesture(
                MagnifyGesture()
                    .updating($magnifyValue) { value, state, transaction in
                        state = value.magnification
                    }
                    .onEnded { value in
                        lastAmount *= value.magnification
                    }
            )
    }
}

#Preview {
    MagnificationGesture()
}
