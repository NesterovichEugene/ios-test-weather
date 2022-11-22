import Foundation
import UIKit

// MARK: - Weather
struct Weather: Codable {
    let city, temperature, weatherDescription: String
    let weatherPerDay: [WeatherPerDay]
    let forecast: [Forecast]

    enum CodingKeys: String, CodingKey {
        case city, temperature
        case weatherDescription = "description"
        case weatherPerDay = "weather_per_day"
        case forecast
    }
}

// MARK: - WeatherPerDay
struct WeatherPerDay: Codable {
    let timestamp, temperature: String
    let weatherType: WeatherType
    let sunset: Bool?

    enum CodingKeys: String, CodingKey {
        case timestamp
        case weatherType = "weather_type"
        case temperature, sunset
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let date: String
    let minTemperature, maxTemperature: Int
    let weatherType: WeatherType

    enum CodingKeys: String, CodingKey {
        case date
        case minTemperature = "min_temperature"
        case maxTemperature = "max_temperature"
        case weatherType = "weather_type"
    }
    
    func getDayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        guard let date = formatter.date(from: self.date) else { return "" }
        formatter.dateFormat = "EE"
        let dayOfTheWeekString = formatter.string(from: date)
        return dayOfTheWeekString
    }
}

enum WeatherType: String, Codable {
    case cloudly
    case snowy
    
    func getImage() -> UIImage {
        switch self {
        case .cloudly:
            return Images.cloud!
        case .snowy:
            return Images.snow!
        }
    }
}
