//
//  GeminiService.swift
//  HackPue
//
//  Created by Liz Bello on 17/08/25.
//

import Foundation

class GeminiService {
    private let apiKey = Config.geminiAPIKey
    private let baseURL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent"
    
    func generateContent(prompt: String) async throws -> String {
        guard Config.isAPIKeyConfigured else {
            throw GeminiError.invalidAPIKey
        }
        
        guard let url = URL(string: "\(baseURL)?key=\(apiKey)") else {
            throw GeminiError.invalidURL
        }
        
        let requestBody = GeminiRequest(
            contents: [
                GeminiContent(
                    parts: [GeminiPart(text: prompt)],
                    role: nil
                )
            ]
        )
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 60.0
        
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
            throw GeminiError.encodingError
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw GeminiError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200:
                break
            case 400:
                throw GeminiError.badRequest
            case 401:
                throw GeminiError.unauthorized
            case 403:
                throw GeminiError.forbidden
            case 429:
                throw GeminiError.rateLimitExceeded
            case 500...599:
                throw GeminiError.serverError(httpResponse.statusCode)
            default:
                throw GeminiError.httpError(httpResponse.statusCode)
            }
            
            let geminiResponse = try JSONDecoder().decode(GeminiResponse.self, from: data)
            
            guard let firstCandidate = geminiResponse.candidates.first,
                  let firstPart = firstCandidate.content.parts.first else {
                throw GeminiError.noContent
            }
            
            return firstPart.text
            
        } catch let error as GeminiError {
            throw error
        } catch let decodingError as DecodingError {
            print("Error de decodificación: \(decodingError)")
            throw GeminiError.decodingError
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                throw GeminiError.networkError("Sin conexión a internet")
            case .timedOut:
                throw GeminiError.networkError("Timeout - La solicitud tardó demasiado")
            case .cannotFindHost:
                throw GeminiError.networkError("No se puede encontrar el servidor")
            case .cannotConnectToHost:
                throw GeminiError.networkError("No se puede conectar al servidor")
            default:
                throw GeminiError.networkError(urlError.localizedDescription)
            }
        } catch {
            throw GeminiError.networkError(error.localizedDescription)
        }
    }
}

// MARK: - Data Models
struct GeminiRequest: Codable {
    let contents: [GeminiContent]
}

struct GeminiContent: Codable {
    let parts: [GeminiPart]
    let role: String?
}

struct GeminiPart: Codable {
    let text: String
}

struct GeminiResponse: Codable {
    let candidates: [GeminiCandidate]
    let usageMetadata: GeminiUsageMetadata?
    let modelVersion: String?
    let responseId: String?
}

struct GeminiCandidate: Codable {
    let content: GeminiContent
    let finishReason: String?
    let avgLogprobs: Double?
    let safetyRatings: [GeminiSafetyRating]?
}

struct GeminiUsageMetadata: Codable {
    let promptTokenCount: Int?
    let candidatesTokenCount: Int?
    let totalTokenCount: Int?
}

struct GeminiSafetyRating: Codable {
    let category: String
    let probability: String
}

// MARK: - Error Types
enum GeminiError: Error, LocalizedError {
    case invalidURL
    case invalidAPIKey
    case encodingError
    case decodingError
    case invalidResponse
    case httpError(Int)
    case badRequest
    case unauthorized
    case forbidden
    case rateLimitExceeded
    case serverError(Int)
    case noContent
    case networkError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .invalidAPIKey:
            return "API Key no configurada o inválida"
        case .encodingError:
            return "Error al codificar la solicitud"
        case .decodingError:
            return "Error al decodificar la respuesta"
        case .invalidResponse:
            return "Respuesta inválida del servidor"
        case .httpError(let code):
            return "Error HTTP: \(code)"
        case .badRequest:
            return "Solicitud incorrecta (400). Verifica el formato del request."
        case .unauthorized:
            return "No autorizado (401). Verifica tu API Key."
        case .forbidden:
            return "Prohibido (403). API Key inválida o sin permisos."
        case .rateLimitExceeded:
            return "Límite de solicitudes excedido (429). Intenta más tarde."
        case .serverError(let code):
            return "Error del servidor (\(code)). Intenta más tarde."
        case .noContent:
            return "No se recibió contenido de la API"
        case .networkError(let message):
            return "Error de red: \(message)"
        }
    }
}
