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
            Color.blue.ignoresSafeArea()
            Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
            Circle().scale(1.35).foregroundColor(.white)
            
            VStack {
                Text("Registro").font(.largeTitle).bold().padding()
                
                TextField("Nuevo usuario", text: $newUsername)
                    .padding().frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05)).cornerRadius(10)
                    .autocapitalization(.none).disableAutocorrection(true)
                
                SecureField("Contraseña", text: $newPassword)
                    .padding().frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05)).cornerRadius(10)
                    .textContentType(.newPassword)
                    .autocapitalization(.none)
                
                SecureField("Confirmar contraseña", text: $confirmPassword)
                    .padding().frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05)).cornerRadius(10)
                    .textContentType(.newPassword)
                    .autocapitalization(.none)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }
                
                Button("Registrarse") { registerUser() }
                    .foregroundColor(.white).frame(width: 300, height: 50)
                    .background(Color.blue).cornerRadius(10).padding(.top, 10)
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

#Preview {
    RegisterView()
}
