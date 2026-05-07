//
//  ContentView.swift
//  HackPue
//
//  Created by Liz Bello on 17/08/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingHome = false
    @StateObject private var dataManager = DataManager()

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
                    // Header con botón atrás y logo pequeño
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.204, green: 0.420, blue: 0.671))
                                .padding(10)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                        Spacer()
                        Image("Safesteps")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 44)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                    Spacer()

                    // Card de login
                    VStack(spacing: 20) {
                        // Título
                        VStack(spacing: 6) {
                            Text("Iniciar Sesión")
                                .font(.custom("Georgia-Bold", size: 24))
                                .foregroundColor(Color(red: 0.204, green: 0.420, blue: 0.671))
                            Text("Bienvenido de vuelta")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding(.bottom, 4)

                        // Campo Usuario
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Usuario o correo")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.gray)
                            TextField("Ingresa tu usuario", text: $username)
                                .padding(.horizontal, 14)
                                .frame(height: 50)
                                .background(Color.gray.opacity(0.08))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(wrongUsername > 0 ? Color.red : Color.clear, lineWidth: 1.5)
                                )
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }

                        // Campo Contraseña
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Contraseña")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.gray)
                            SecureField("Ingresa tu contraseña", text: $password)
                                .padding(.horizontal, 14)
                                .frame(height: 50)
                                .background(Color.gray.opacity(0.08))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(wrongPassword > 0 ? Color.red : Color.clear, lineWidth: 1.5)
                                )
                                .autocapitalization(.none)
                                .textContentType(.password)
                        }

                        // Botón Entrar
                        Button(action: { authenticateUser() }) {
                            Text("Entrar")
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
                        .padding(.top, 4)

                        // Divider "O continúa con"
                        HStack(spacing: 12) {
                            Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.25))
                            Text("O continúa con")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .fixedSize()
                            Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.25))
                        }

                        // Botón Google
                        Button(action: { /* Google Sign-In */ }) {
                            HStack(spacing: 10) {
                                // Icono G de Google (simulado con SF Symbols o texto)
                                Text("G")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(Color(red: 0.91, green: 0.26, blue: 0.21))
                                Text("Continuar con Google")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.black.opacity(0.75))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.white)
                            .cornerRadius(14)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(28)
                    .shadow(color: .black.opacity(0.06), radius: 16, x: 0, y: 8)
                    .padding(.horizontal, 20)

                    Spacer()
                }
            }
            .navigationDestination(isPresented: $showingHome) {
                HomeView(username: username, dataManager: dataManager)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .onAppear {
            if let saved = UserDefaults.standard.string(forKey: "username") {
                username = saved
            }
        }
    }

    func authenticateUser() {
        let savedUsername = UserDefaults.standard.string(forKey: "username")
        let savedPassword = UserDefaults.standard.string(forKey: "password")
        guard username == savedUsername else { wrongUsername = 2; return }
        wrongUsername = 0
        guard password == savedPassword else { wrongPassword = 2; return }
        wrongPassword = 0
        showingHome = true
    }
}

#Preview { ContentView() }
