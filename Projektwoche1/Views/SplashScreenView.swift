//
//  SplashScreenView.swift
//  Projektwoche1
//

import SwiftUI
import AVKit

struct SplashScreenView: View {
    let onFinish: () -> Void

    @State private var player: AVPlayer? = {
        let url = Bundle.main.url(
            forResource: "CashFlow Splash",
            withExtension: "mp4",
            subdirectory: "Splash Screen"
        ) ?? Bundle.main.url(
            forResource: "CashFlow Splash",
            withExtension: "mp4"
        )
        guard let url else { return nil }
        return AVPlayer(url: url)
    }()
    @State private var showVideo = false
    @State private var opacity = 1.0

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black.ignoresSafeArea()

                if let player {
                    let size = max(proxy.size.width, proxy.size.height) * 0.704
                    VideoPlayer(player: player)
                        .frame(width: size, height: size)
                        .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .opacity(showVideo ? 1 : 0)
                }
            }
        }
        .opacity(opacity)
        .onAppear {
            guard player != nil else {
                // Fallback: don't block app launch if video asset is missing.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    withAnimation(.easeOut(duration: 0.2)) { opacity = 0 }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        onFinish()
                    }
                }
                return
            }
            player?.isMuted = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
                withAnimation(.easeIn(duration: 0.08)) { showVideo = true }
                player?.play()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)) { _ in
            withAnimation(.easeOut(duration: 0.25)) { opacity = 0 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                onFinish()
            }
        }
    }
}
