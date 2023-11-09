//
//  WeatherViewController.swift
//  AppleWeather2
//
//  Created by Lawson Falomo on 11/8/23.
//

import UIKit

private enum Constants {
    enum Searchbar {
        static let sideMargins: CGFloat = 8.0
    }
    static let padding: CGFloat = 16.0
    static let rowHeight: CGFloat = 50.0
    static let placeholder: String = "Search for a city"
}

class WeatherViewController: UIViewController {
    
    // MARK: - Dependencies
    private let locationService: LocationService
    private let weatherService: WeatherService
    
    // MARK: - Properties
    private var viewModel: WeatherViewModel?
    private var cities: [CityWeather] = []
    
    init(viewModel: WeatherViewModel? = nil, weatherService: WeatherService, locationService: LocationService) {
        self.viewModel = viewModel
        self.weatherService = weatherService
        self.locationService = locationService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
}
