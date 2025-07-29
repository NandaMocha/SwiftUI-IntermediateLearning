//
//  1-LongPressGesture.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 29/07/25.
//

import SwiftUI

struct LongPressGesture: View {
    @State private var isComplete: Bool = false
    @State private var isSuccess: Bool = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth: isComplete ? .infinity : 0 )
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
            
            HStack {
                Text("Click Here")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 10))
                    .onLongPressGesture(
                        minimumDuration: 1,
                        maximumDistance: 50,
                        pressing: { isPressing in
                            if isPressing {
                                withAnimation(.easeInOut(duration: 1)) {
                                    isComplete = true
                                }
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    if !isSuccess {
                                        withAnimation(.easeInOut) {
                                            isComplete = false
                                        }
                                    }
                                }
                            }
                            
                        }, perform: {
                            withAnimation(.easeInOut(duration: 1)) {
                                isSuccess = true
                            }
                        })
                
                Text("Reset")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 10))
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isSuccess = false
                            isComplete = false
                        }
                    }
            }
        }
    }
}

extension LongPressGesture {
    private var practiceOne: some View {
        Text(isComplete ? "Completed" : "Hello, World!")
            .padding()
            .padding(.horizontal)
            .background(isComplete ? .green : .gray)
            .clipShape(.rect(cornerRadius: 10))
//            .onTapGesture {
//                isComplete.toggle()
//            }
            .onLongPressGesture(minimumDuration: 1, maximumDistance: 1) {
                isComplete.toggle()
            }
    }
}

#Preview {
    LongPressGesture()
}
