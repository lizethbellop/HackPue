//
//  WelcomeView.swift
//  HackPue
//
//  Created by Liz Bello on 06/05/26.
//

import SwiftUI

struct WelcomeView: View {
    @State private var goToLogin = false
    @State private var goToRegister = false
    @State private var imageOpacity: Double = 0
    @State private var buttonsOffset: CGFloat = 40
    @State private var buttonsOpacity: Double = 0

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.93, green: 0.97, blue: 1.0),
                        Color(red: 0.88, green: 0.96, blue: 0.90)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Logo pequeño arriba
                    HStack {
                        Image("Safesteps")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 52)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)

                    Spacer()

                    // Imagen central con familia
                    Image("parentalMonitoring")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 320)
                        .opacity(imageOpacity)
                        .padding(.horizontal, 20)

                    Spacer()

                    // Textos y botones
                    VStack(spacing: 12) {
                        Text("Bienvenido a SafeSteps")
                            .font(.custom("Georgia-Bold", size: 22))
                            .foregroundColor(Color(red: 0.204, green: 0.420, blue: 0.671))
                            .multilineTextAlignment(.center)

                        Text("Protege a tu familia en el mundo digital")
                            .font(.custom("Georgia", size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 8)

                        Button(action: { goToLogin = true }) {
                            Text("Iniciar Sesión")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.204, green: 0.420, blue: 0.671),
                                            Color(red: 0.1, green: 0.35, blue: 0.75)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(14)
                        }

                        Button(action: { goToRegister = true }) {
                            Text("Crear Cuenta")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.204, green: 0.420, blue: 0.671))
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(Color.white)
                                .cornerRadius(14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color(red: 0.204, green: 0.420, blue: 0.671), lineWidth: 1.5)
                                )
                        }
                    }
                    .padding(.horizontal, 24)
                    .offset(y: buttonsOffset)
                    .opacity(buttonsOpacity)
                    .padding(.bottom, 48)
                }
            }
            .navigationDestination(isPresented: $goToLogin) {
                ContentView()
            }
            .navigationDestination(isPresented: $goToRegister) {
                RegisterView()
            }
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {
                withAnimation(.easeOut(duration: 0.7)) { imageOpacity = 1.0 }
                withAnimation(.spring(response: 0.7, dampingFraction: 0.75).delay(0.3)) {
                    buttonsOffset = 0
                    buttonsOpacity = 1.0
                }
            }
        }
    }
}

#Preview { WelcomeView() }
