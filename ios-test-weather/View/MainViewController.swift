import UIKit

class MainViewController: UIViewController, MainViewProtocol {

    private let presenter: MainPresenterProtocol = MainPresenter()
    private let cellIdentifier: String = "TableCell"
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = Fonts.inter30
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        label.font = Fonts.inter16
        return label
    }()
    
    private lazy var dailyView: UIView = {
        var view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.backgroundColor = UIColor(red: 0.235, green: 0.306, blue: 0.396, alpha: 0.6)
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Fonts.inter14
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dailyWeatherSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(red: 0.43, green: 0.472, blue: 0.529, alpha: 1)
        return separator
    }()
    
    private lazy var dailyWeatherStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 14
        return stackView
    }()
    
    private lazy var forecastView: UIView = {
        var view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.backgroundColor = UIColor(red: 0.235, green: 0.306, blue: 0.396, alpha: 0.6)
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var forecastIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Images.calendar!
        return imageView
    }()
    
    private lazy var forecastLabel: UILabel = {
        let label = UILabel()
        label.text = "10-DAY FORECAST"
        label.font = Fonts.inter14
        label.textColor = UIColor(red: 0.584, green: 0.631, blue: 0.694, alpha: 1)
        return label
    }()
    
    private lazy var forecastSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(red: 0.43, green: 0.472, blue: 0.529, alpha: 1)
        return separator
    }()
    
    private lazy var forecastTable: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(ForecastTableCell.self, forCellReuseIdentifier: self.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.separatorColor = .white
        return tableView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.setView(self)
        self.setupView()
        self.setupConstraints()
        self.presenter.fetchWeatherData()
    }
    
    public func setCityText(_ text: String) {
        self.cityLabel.text = text
    }
    
    public func setTemperatureText(_ text: String) {
        self.temperatureLabel.text = text
    }
    
    public func setDescriptionText(_ text: String) {
        self.descriptionLabel.text = text
    }
    
    public func setDailyWeather(_ dailyWeather: [WeatherPerDay]) {
        for dayWeather in dailyWeather {
            let weatherView = DailyWeatherView()
            weatherView.configureWeatherView(dayWeather)
            
            dailyWeatherStack.addArrangedSubview(weatherView)
        }
    }
}

// MARK: - UITableView Data Source
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ForecastTableCell
        guard let forecast = self.presenter.getForecast(for: indexPath.row) else { return UITableViewCell() }
        cell?.configure(forecast)
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRowsInSection
    }
}

// MARK: - UITableView Delegate
extension MainViewController: UITableViewDelegate {}

// MARK: - UI Setup
extension MainViewController {
    
    private func setupView() {
        view.backgroundColor = UIColor(patternImage: Images.background ?? UIImage())
        
        view.addSubview(cityLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(dailyView)
        view.addSubview(forecastView)
        
        dailyView.addSubview(descriptionLabel)
        dailyView.addSubview(dailyWeatherSeparator)
        dailyView.addSubview(dailyWeatherStack)
        
        forecastView.addSubview(forecastIcon)
        forecastView.addSubview(forecastLabel)
        forecastView.addSubview(forecastSeparator)
        forecastView.addSubview(forecastTable)
    }
    
    private func setupConstraints() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.72).isActive = true
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 6.28).isActive = true
        
        dailyView.translatesAutoresizingMaskIntoConstraints = false
        dailyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        dailyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        dailyView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 57).isActive = true
        dailyView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: dailyView.leadingAnchor, constant: 14).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: dailyView.trailingAnchor, constant: -10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: dailyView.topAnchor, constant: 14).isActive = true
        
        dailyWeatherSeparator.translatesAutoresizingMaskIntoConstraints = false
        dailyWeatherSeparator.leadingAnchor.constraint(equalTo: dailyView.leadingAnchor, constant: 14).isActive = true
        dailyWeatherSeparator.trailingAnchor.constraint(equalTo: dailyView.trailingAnchor, constant: -10).isActive = true
        dailyWeatherSeparator.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 14).isActive = true
        dailyWeatherSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        dailyWeatherStack.translatesAutoresizingMaskIntoConstraints = false
        dailyWeatherStack.leadingAnchor.constraint(equalTo: dailyView.leadingAnchor, constant: 14).isActive = true
        dailyWeatherStack.trailingAnchor.constraint(equalTo: dailyView.trailingAnchor, constant: -10).isActive = true
        dailyWeatherStack.topAnchor.constraint(equalTo: dailyWeatherSeparator.bottomAnchor, constant: 12).isActive = true
        
        forecastView.translatesAutoresizingMaskIntoConstraints = false
        forecastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        forecastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        forecastView.topAnchor.constraint(equalTo: dailyView.bottomAnchor, constant: 9).isActive = true
        forecastView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -17.92).isActive = true
        
        forecastIcon.translatesAutoresizingMaskIntoConstraints = false
        forecastIcon.leadingAnchor.constraint(equalTo: forecastView.leadingAnchor, constant: 16).isActive = true
        forecastIcon.topAnchor.constraint(equalTo: forecastView.topAnchor, constant: 14).isActive = true
        forecastIcon.heightAnchor.constraint(equalToConstant: 14).isActive = true
        forecastIcon.widthAnchor.constraint(equalToConstant: 14).isActive = true
        
        forecastLabel.translatesAutoresizingMaskIntoConstraints = false
        forecastLabel.leadingAnchor.constraint(equalTo: forecastIcon.trailingAnchor, constant: 7).isActive = true
        forecastLabel.trailingAnchor.constraint(equalTo: forecastView.trailingAnchor, constant: -14).isActive = true
        forecastLabel.topAnchor.constraint(equalTo: forecastIcon.topAnchor).isActive = true
        forecastLabel.bottomAnchor.constraint(lessThanOrEqualTo: forecastView.bottomAnchor, constant: -14).isActive = true
        
        forecastSeparator.translatesAutoresizingMaskIntoConstraints = false
        forecastSeparator.leadingAnchor.constraint(equalTo: forecastIcon.leadingAnchor).isActive = true
        forecastSeparator.trailingAnchor.constraint(equalTo: dailyView.trailingAnchor, constant: -14).isActive = true
        forecastSeparator.topAnchor.constraint(equalTo: forecastIcon.bottomAnchor, constant: 14).isActive = true
        forecastSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        forecastTable.translatesAutoresizingMaskIntoConstraints = false
        forecastTable.leadingAnchor.constraint(equalTo: forecastIcon.leadingAnchor).isActive = true
        forecastTable.trailingAnchor.constraint(equalTo: forecastView.trailingAnchor, constant: -14).isActive = true
        forecastTable.topAnchor.constraint(equalTo: forecastIcon.bottomAnchor, constant: 14).isActive = true
        forecastTable.bottomAnchor.constraint(equalTo: forecastView.bottomAnchor, constant: -34).isActive = true
    }
}
