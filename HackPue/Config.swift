//
//  Config.swift
//  HackPue
//
//  Created by Liz Bello on 17/08/25.
//

import Foundation

struct Config {
    // Tu API key de Google AI Studio
    static let geminiAPIKey = "AIzaSyB6M9GFqmdgR20vaiWFBvUJ1n8-Rd1MML8"
    
    // Método para verificar si la API Key está configurada
    static var isAPIKeyConfigured: Bool {
        return !geminiAPIKey.isEmpty && geminiAPIKey.hasPrefix("AIza")
    }
}
