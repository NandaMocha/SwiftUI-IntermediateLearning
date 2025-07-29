//
//  ScrollViewReaderMaterials.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 29/07/25.
//

import SwiftUI

struct ScrollViewReaderMaterials: View {
    @State var numberValue: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            TextField("Enter a # here ...", text: $numberValue)
                .padding()
                .frame(height: 55)
                .border(.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Scroll Now") {
                withAnimation(.spring) {
                    if let index = Int(numberValue) {
                        scrollToIndex = index
                    }
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.white.clipShape(.rect(cornerRadius: 10))
                            )
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                            .onChange(of: scrollToIndex) { oldValue, newValue in
                                withAnimation(.spring) {
                                    proxy.scrollTo(scrollToIndex, anchor: .center)
                                }
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderMaterials()
}
