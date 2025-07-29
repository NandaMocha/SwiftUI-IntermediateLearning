//
//  DragGestures2.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 29/07/25.
//

import SwiftUI

struct DragGestures2: View {
    
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.825
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            MySignedUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring) {
                                currentDragOffsetY = value.translation.height
                            }
                        })
                    
                        .onEnded({ value in
                            withAnimation(.spring) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                
                                currentDragOffsetY = 0
                            }
                        })
                )
            
//            Text("\(currentDragOffsetY)")
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    DragGestures2()
}

struct MySignedUpView: View {
    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "chevron.up")
                .padding(.top, 8)
            
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description for our app. This is my Favorite SwiftUI course and I recommend to all of my friends to subscribe to Swiftful Thinking!")
                .multilineTextAlignment(.center)
            
            Text("Create an Account")
                .foregroundStyle(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(
                    Color.black.clipShape(.rect(cornerRadius: 10))
                )
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            Color.white.clipShape(.rect(cornerRadius: 30))
        )
    }
}
