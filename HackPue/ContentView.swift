//
//  ContentView.swift
//  HackPue
//
//  Created by Liz Bello on 17/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingHome = false
    @State private var goToRegister = false
    @StateObject private var dataManager = DataManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                
                VStack {
                    Text("Inicia Sesión").font(.largeTitle).bold().padding()
                    
                    TextField("Usuario", text: $username)
                        .padding().frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05)).cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                        .autocapitalization(.none).disableAutocorrection(true)
                    
                    SecureField("Contraseña", text: $password)
                        .padding().frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05)).cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                        .autocapitalization(.none).disableAutocorrection(true)
                        .textContentType(.password)
                    
                    Button("Entrar") { authenticateUser() }
                        .foregroundColor(.white).frame(width: 300, height: 50)
                        .background(Color.blue).cornerRadius(10).padding(.bottom, 10)
                    
                    HStack {
                        Text("¿No tienes cuenta?")
                        Button("Regístrate aquí") { goToRegister = true }
                            .foregroundColor(.blue)
                    }
                }
            }
            
            .navigationDestination(isPresented: $showingHome) {
                HomeView(username: username, dataManager: dataManager)
            }
            
            .navigationDestination(isPresented: $goToRegister) {
                RegisterView()
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .onAppear {
            if let savedUsername = UserDefaults.standard.string(forKey: "username") {
                username = savedUsername
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

#Preview {
    ContentView()
}

