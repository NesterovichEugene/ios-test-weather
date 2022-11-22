import UIKit

class ForecastTableCell: UITableViewCell {
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.inter18
        label.textColor = .white
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.inter16
        label.textAlignment = .right
        label.textColor = UIColor(red: 0.584, green: 0.631, blue: 0.694, alpha: 1)
        return label
    }()
    
    private lazy var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.inter16
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 33
        
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(weatherImage)
        stackView.addArrangedSubview(minTemperatureLabel)
        stackView.addArrangedSubview(maxTemperatureLabel)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        weatherImage.image = nil
        dayLabel.text = nil
        minTemperatureLabel.text = nil
        maxTemperatureLabel.text = nil
    }
    
    func configure(_ forecast: Forecast) {
        self.dayLabel.text = forecast.getDayOfWeek()
        self.weatherImage.image = forecast.weatherType.getImage()
        self.minTemperatureLabel.text = "\(forecast.minTemperature)°"
        self.maxTemperatureLabel.text = "\(forecast.maxTemperature)°"
    }
}

// MARK: - UI setup
extension ForecastTableCell {
    
    private func setupView() {
        self.backgroundColor = .clear
        self.isOpaque = false

        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.heightAnchor.constraint(equalToConstant: 28).isActive = true
        weatherImage.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        minTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        minTemperatureLabel.widthAnchor.constraint(equalToConstant: 43).isActive = true
        
        maxTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 43).isActive = true
    }
}
