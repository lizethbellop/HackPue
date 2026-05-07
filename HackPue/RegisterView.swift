//
//  RegisterView.swift
//  HackPue
//
//  Created by Liz Bello on 17/08/25.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var newUsername = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""

    var body: some View {
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
                // Header
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

                // Card de registro
                VStack(spacing: 20) {
                    VStack(spacing: 6) {
                        Text("Crear Cuenta")
                            .font(.custom("Georgia-Bold", size: 24))
                            .foregroundColor(Color(red: 0.204, green: 0.420, blue: 0.671))
                        Text("Únete a SafeSteps")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 4)

                    // Campo usuario
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Usuario o correo")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                        TextField("Ingresa tu usuario o correo", text: $newUsername)
                            .padding(.horizontal, 14)
                            .frame(height: 50)
                            .background(Color.gray.opacity(0.08))
                            .cornerRadius(12)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }

                    // Campo contraseña
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Contraseña")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                        SecureField("Crea tu contraseña", text: $newPassword)
                            .padding(.horizontal, 14)
                            .frame(height: 50)
                            .background(Color.gray.opacity(0.08))
                            .cornerRadius(12)
                            .textContentType(.newPassword)
                            .autocapitalization(.none)
                    }

                    // Confirmar contraseña
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Confirmar contraseña")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                        SecureField("Repite tu contraseña", text: $confirmPassword)
                            .padding(.horizontal, 14)
                            .frame(height: 50)
                            .background(Color.gray.opacity(0.08))
                            .cornerRadius(12)
                            .textContentType(.newPassword)
                            .autocapitalization(.none)
                    }

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    // Botón Registrarse
                    Button(action: { registerUser() }) {
                        Text("Registrarse")
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

                    // Divider
                    HStack(spacing: 12) {
                        Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.25))
                        Text("O regístrate con")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .fixedSize()
                        Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.25))
                    }

                    // Botón Google
                    Button(action: { /* Google Sign-In */ }) {
                        HStack(spacing: 10) {
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
        .toolbar(.hidden, for: .navigationBar)
    }

    func registerUser() {
        guard !newUsername.isEmpty && !newPassword.isEmpty else {
            errorMessage = "Llena todos los campos"; return
        }
        guard newPassword == confirmPassword else {
            errorMessage = "Las contraseñas no coinciden"; return
        }
        UserDefaults.standard.set(newUsername, forKey: "username")
        UserDefaults.standard.set(newPassword, forKey: "password")
        dismiss()
    }
}

#Preview { RegisterView() }
