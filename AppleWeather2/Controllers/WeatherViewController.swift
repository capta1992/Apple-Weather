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
    static let reuseIdentifier: String = "CityTableViewCell"
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
    private lazy var tapRecognizer: UITapGestureRecognizer = .init(target: self, action: #selector(handleDismissKeyboard))
    private lazy var searchbar: SearchBarNavigationView = .init(placeholder: Constants.placeholder)
    private let weatherDetailsView = WeatherDetailsView()
    
    private let hourlyForecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        // TODO: - [OF] Register cell classes, set delegate and data source
        return collectionView
    }()
    
    private let dailyForecastTableView: UITableView = {
        let tableView = UITableView()
        // TODO: - [OF] Register cell classes, set delegate and dataSource
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle
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
        configureGradientBackground()
        configureUI()
        initializeWeatherData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - API
    
    private func fetchWeatherForCity(city: String) async  {
        do {
            let cityWeather = try await weatherService.weather(for: city)
            let viewModel = WeatherViewModel(model: cityWeather)
            DispatchQueue.main.async {
                self.updateUIWithWeather(viewModel)
            }
        } catch {
            DispatchQueue.main.async {
                // TODO: - [OF] Handle error, show alert or update UI accordingly
            }
        }
    }
    
    private func updateUIWithWeather(_ viewModel: WeatherViewModel) {
        // Update your cities array or other UI Components
        weatherDetailsView.update(using: viewModel)
        
    }
    
    private func initializeWeatherData() {
        Task {
            await fetchWeatherForCity(city: "Chicago")
        }
    }
    
    // MARK: - Helpers
    private func configureUI() {
        configureNavigation()
        configureSearchBarAndStacks()
        
        view.addSubview(weatherDetailsView)
        weatherDetailsView.anchor(top: searchbar.bottomAnchor, paddingTop: Constants.padding)
        weatherDetailsView.centerX(inView: view)
    }
    
    private func configureNavigation() {
        navigationItem.title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func configureSearchBarAndStacks() {
        searchbar.setSearchBarDelegate(self)
        view.addSubview(searchbar)
        
        searchbar.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: Constants.padding,
            paddingLeft: Constants.Searchbar.sideMargins,
            paddingRight: Constants.Searchbar.sideMargins
        )
    }
    
    private func setupHourlyForecast() {
        view.addSubview(hourlyForecastCollectionView)
        hourlyForecastCollectionView.anchor(top: weatherDetailsView.bottomAnchor, paddingTop: Constants.padding)
        hourlyForecastCollectionView.centerX(inView: view)
        hourlyForecastCollectionView.setHeight(height: 100)
        hourlyForecastCollectionView.fillSuperview()
    }
    
    private func setupDailyForecast() {
        view.addSubview(dailyForecastTableView)
        dailyForecastTableView.anchor(top: hourlyForecastCollectionView.bottomAnchor, paddingTop: Constants.padding)
        dailyForecastTableView.fillSuperview()
    }
    
    private func configureTableView() {
        
    }
    
    // MARK: - Actions
    @objc private func handleDismissKeyboard() {
        
   }
}

// MARK: - UITableViewDelegate, UITableViewDataSource


// MARK: - SearchBarDelegate
extension WeatherViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            print(text)
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        handleDismissKeyboard()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        guard let searchtext = searchBar.text else { return true }
        return searchtext == Constants.placeholder ? false : true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // TODO: [OF] Implement Logic
    }
}
