//
//  Member.swift
//  HackPue
//
//  Created by Liz Bello on 17/08/25.
//

import Foundation

struct Member: Identifiable, Hashable, Codable {
    let id = UUID()
    var firstName: String
    var lastName: String
    var birthdate: Date
    var shouldBeSleeping: Bool
    var sleepStart: Date?
    var sleepEnd: Date?
    var shouldBeStudying: Bool
    var studyStart: Date?
    var studyEnd: Date?
    var screenTime: [Double] = []
    var alerts: [String] = []
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    var age: Int {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
        return ageComponents.year ?? 0
    }
    
    // Computed property para generar alertas de ejemplo si no hay
    var alertsWithExamples: [String] {
        if alerts.isEmpty {
            return generateSampleAlerts()
        }
        return alerts
    }
    
    private func generateSampleAlerts() -> [String] {
        var sampleAlerts: [String] = []
        
        // Generar alertas basadas en la edad y configuraciones
        if age <= 8 {
            sampleAlerts.append("Tiempo excesivo en pantalla detectado: 4.5 horas en YouTube Kids durante el día")
            sampleAlerts.append("Contenido no apropiado para la edad visualizado en aplicación de videos")
            sampleAlerts.append("Intento de descarga de aplicación sin supervisión parental")
        } else if age <= 12 {
            sampleAlerts.append("Uso prolongado de redes sociales durante horario escolar")
            sampleAlerts.append("Tiempo de pantalla superó los límites recomendados: 6 horas de uso continuo")
            sampleAlerts.append("Descarga de aplicaciones no autorizadas detectada")
            sampleAlerts.append("Interacción con contenido de riesgo moderado en plataformas sociales")
        } else {
            sampleAlerts.append("Actividad en redes sociales durante altas horas de la madrugada")
            sampleAlerts.append("Búsquedas relacionadas con contenido riesgoso detectadas")
            sampleAlerts.append("Comunicación con contactos no verificados en aplicaciones de mensajería")
            sampleAlerts.append("Múltiples intentos de acceso a sitios web restringidos")
        }
        
        // Agregar alertas específicas si tiene configuraciones especiales
        if shouldBeSleeping {
            sampleAlerts.append("Uso de dispositivos durante horario de sueño establecido (\(formatTime(sleepStart)) - \(formatTime(sleepEnd)))")
        }
        
        if shouldBeStudying {
            sampleAlerts.append("Distracción con juegos y redes sociales durante horario de estudio (\(formatTime(studyStart)) - \(formatTime(studyEnd)))")
        }
        
        // Alertas generales comunes
        sampleAlerts.append("Múltiples intentos de acceso a sitios web bloqueados")
        sampleAlerts.append("Tiempo de uso nocturno excesivo afectando patrones de sueño")
        
        // Retornar máximo 5 alertas para no saturar
        return Array(sampleAlerts.prefix(5))
    }
    
    private func formatTime(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // Método para agregar una alerta real
    mutating func addAlert(_ alert: String) {
        alerts.append(alert)
    }
    
    // Método para limpiar alertas
    mutating func clearAlerts() {
        alerts.removeAll()
    }
    
    // Método para obtener el nivel de riesgo basado en la edad
    var riskLevel: String {
        switch age {
        case 0...8:
            return "Básico"
        case 9...12:
            return "Moderado"
        case 13...15:
            return "Alto"
        default:
            return "Desconocido"
        }
    }
}
