//
//  SoundBootcamp.swift
//  SwiftUI-IntermediateLearning
//
//  Created by Nanda Mochammad on 30/07/25.
//

import SwiftUI
import AVKit

enum SoundOption: String {
    case tada
    case badum
}

class SoundManager {
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error play sound \(error.localizedDescription)")
        }
    }
}

struct SoundBootcamp: View {
    
    var soundManager = SoundManager()
    var body: some View {
        VStack(spacing: 40) {
            Button("Sound 1") {
                soundManager.playSound(sound: .tada)
            }
            
            Button("Sound 2") {
                soundManager.playSound(sound: .badum)
            }
        }
    }
}

#Preview {
    SoundBootcamp()
}
