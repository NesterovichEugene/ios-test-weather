import Foundation

protocol MainViewProtocol: AnyObject {
    func setCityText(_ text: String)
    func setTemperatureText(_ text: String)
    func setDescriptionText(_ text: String)
    func setDailyWeather(_ dailyWeather: [WeatherPerDay])
}

protocol MainPresenterProtocol {
    var numberOfRowsInSection: Int {get}
    func setView(_ view: MainViewProtocol)
    func fetchWeatherData()
    func getForecast(for index: Int) -> Forecast?
}

class MainPresenter: MainPresenterProtocol {
    
    weak private var view: MainViewProtocol?
    private var weatherModel: Weather?
    
    var numberOfRowsInSection: Int {
        self.weatherModel?.forecast.count ?? 0
    }
    
    public func setView(_ view: MainViewProtocol) {
        self.view = view
    }
    
    public func fetchWeatherData() {
        self.weatherModel = DataReader.getWeather()
        
        self.view?.setCityText(weatherModel?.city ?? "")
        self.view?.setTemperatureText(weatherModel?.temperature ?? "")
        self.view?.setDescriptionText(weatherModel?.weatherDescription ?? "")
        self.view?.setDailyWeather(weatherModel?.weatherPerDay ?? [])
    }
    
    public func getForecast(for index: Int) -> Forecast? {
        return self.weatherModel?.forecast[index]
    }
}
