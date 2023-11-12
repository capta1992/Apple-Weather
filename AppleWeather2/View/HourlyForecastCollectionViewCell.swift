//
//  HourlyForecastCollectionViewCell.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/10/23.
//

import UIKit

private enum Constants {
    static let reuseIdentifier: String = "HourlyTimeCollectionViewCell"
}

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    let conditionalsLabel = UILabel()
    
    private let dividerView: UIView = {
         let view = UIView()
         view.backgroundColor = UIColor.white.withAlphaComponent(0.3) // Adjust opacity as needed
         return view
     }()

    let hourlyForecastCollectionView: UICollectionView
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    override init(frame: CGRect) {
        hourlyForecastCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupLayout()
        configureCollectionView()
        setupDividerView()
        
        // TODO: - [OF] Set Cell Appearance: Encapsualte in method to keep view did load clean
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        // Configure Conditionals Label
        conditionalsLabel.font = .systemFont(ofSize: 14)
        conditionalsLabel.textColor = .white
        conditionalsLabel.textAlignment = .left
        conditionalsLabel.numberOfLines = 0
        addSubview(conditionalsLabel)
        conditionalsLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 8, paddingRight: 8)
        
        // Configure and add the hourly forecast collection view
        hourlyForecastCollectionView.backgroundColor = .clear
        addSubview(hourlyForecastCollectionView)
        hourlyForecastCollectionView.anchor(top: conditionalsLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4)
    }
    
    private func setupDividerView() {
        addSubview(dividerView)
        dividerView.anchor(left: leftAnchor, bottom: conditionalsLabel.bottomAnchor, right: rightAnchor, paddingLeft: 8, paddingBottom: -8, paddingRight: 8, height: 1)
    }
    
    private func configureCollectionView() {
        hourlyForecastCollectionView.register(HourlyTimeCollectionViewCell.self, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        hourlyForecastCollectionView.dataSource = self
        hourlyForecastCollectionView.delegate = self
        hourlyForecastCollectionView.showsHorizontalScrollIndicator = true
        hourlyForecastCollectionView.alwaysBounceHorizontal = true 
    }
    
    func configure(with cityData: [CityWeather], conditionsText: String) {
        conditionalsLabel.text = conditionsText
        hourlyForecastCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension HourlyForecastCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as? HourlyTimeCollectionViewCell else {
            fatalError("Unable to dequeue HourlyTimeCollectionViewCell")
        }
        cell.temperatureLabel.text = "74°" 
        cell.imageView.image = UIImage(systemName: "cloud")
        cell.timeLabel.text = "Now"
        return cell
    }
}

// MARK: -
extension HourlyForecastCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 80, height: collectionView.bounds.height)
    }
}
