//
//  WeatherDetailsView.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/10/23.
//

import UIKit

class WeatherDetailsView: UIView {
    
    // MARK: - UI Components
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 80, weight: .thin)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let conditionalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Clear"
        return label
    }()
    
    private let highLowTempView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let highTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.text = "H:74°"  // Placeholder text, replace with your data source
        return label
    }()
    
    private let lowTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.text = "L:53°"  // Placeholder text, replace with your data source
        return label
    }()
    
    // MARK: - Lifecycycle
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        highLowTempView.addArrangedSubview(highTempLabel)
        highLowTempView.addArrangedSubview(lowTempLabel)
        
        let stack = UIStackView(arrangedSubviews: [cityNameLabel, temperatureLabel, conditionalLabel, highLowTempView])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.alignment = .center
        addSubview(stack)
        
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    func update(using viewModel: WeatherViewModel) {
        cityNameLabel.text = viewModel.cityName
        temperatureLabel.text = "\(viewModel.temperatureString)°"
        conditionalLabel.text = viewModel.description
    }
    
}
