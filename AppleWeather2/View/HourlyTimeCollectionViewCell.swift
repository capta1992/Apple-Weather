//
//  HourlyTimeCollectionViewCell.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/12/23.
//

import UIKit

class HourlyTimeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    let timeLabel = UILabel()
    let imageView = UIImageView()
    let temperatureLabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setupLayout() {
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image?.withTintColor(.white)
        
        timeLabel.textColor = .white
        temperatureLabel.textColor = .white
        
        
        let stackView = UIStackView(arrangedSubviews: [
            timeLabel,
            imageView,
            temperatureLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8) // TODO: - [OF] Update constrains the time comes

    }
    
    func configure(with model: WeatherViewModel) {
        timeLabel.text = "Now"
        imageView.image = UIImage(named: model.conditionImageName)
        temperatureLabel.text = "\(model.temperatureString)" // TODO: [OF] Change in future
    }
}
