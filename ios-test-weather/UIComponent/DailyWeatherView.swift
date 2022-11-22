import Foundation
import UIKit

class DailyWeatherView: UIView {
    
    public func configureWeatherView(_ weather: WeatherPerDay) {
        let dayLabel: UILabel = {
            let label = UILabel()
            label.font = Fonts.inter14
            label.textColor = .white
            label.textAlignment = .center
            label.text = weather.timestamp
            return label
        }()
        
        let weatherIcon: UIImageView = {
            let imageView = UIImageView()
            imageView.image = (weather.sunset ?? false)
                ? Images.sunset
                : weather.weatherType.getImage()
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        let temperatureLabel: UILabel = {
            let label = UILabel()
            label.font = (weather.sunset ?? false) ? Fonts.inter18 : Fonts.inter16
            label.textColor = .white
            label.textAlignment = .center
            label.text = (weather.sunset ?? false) ? "Заход солнца" : "\(weather.temperature)°"
            return label
        }()
        
        self.addSubview(dayLabel)
        self.addSubview(weatherIcon)
        self.addSubview(temperatureLabel)
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        dayLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        dayLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dayLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
        
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        weatherIcon.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 3.09).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 28).isActive = true
        weatherIcon.widthAnchor.constraint(equalToConstant: 28).isActive = true
        weatherIcon.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 2.94).isActive = true
        temperatureLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
    }
}
