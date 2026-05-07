//
//  SplashView.swift
//  HackPue
//
//  Created by Liz Bello on 06/05/26.
//

import SwiftUI

struct SplashView: View {
    @State private var logoScale: CGFloat = 0.4
    @State private var logoOpacity: Double = 0
    @State private var textOpacity: Double = 0
    @State private var isActive = false

    var body: some View {
        if isActive {
            WelcomeView()
        } else {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.93, green: 0.97, blue: 1.0),
                        Color(red: 0.85, green: 0.95, blue: 0.88)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 16) {
                    Image("Safesteps")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .scaleEffect(logoScale)
                        .opacity(logoOpacity)

                    Text("Navegando juntos con seguridad")
                        .font(.custom("Georgia", size: 15))
                        .foregroundColor(Color(red: 0.35, green: 0.60, blue: 0.35))
                        .opacity(textOpacity)
                }
            }
            .onAppear {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                    logoScale = 1.0
                    logoOpacity = 1.0
                }
                withAnimation(.easeIn(duration: 0.6).delay(0.5)) {
                    textOpacity = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
