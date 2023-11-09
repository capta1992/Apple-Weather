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
    private var cities: [CityWeather] = [
        CityWeather(from: .init(name: "Test City", main: .init(temp: 76.0, feels_like: 82.0, humidity: 30), weather: [.init(id: 1, description: "overcast clouds")]))
    ]
    private lazy var tapRecognizer: UITapGestureRecognizer = .init(target: self, action: #selector(handleDismissKeyboard))
    private lazy var searchbar: SearchBarNavigationView = .init(placeholder: Constants.placeholder)
    private let notificationView = NotificationView()
    
    private let weatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
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
        view.backgroundColor = .black
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Helpers
    private func configureUI() {
        configureNavigation()
        configureSearchBarAndStacks()
        configureTableView()
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
    
    private func configureTableView() {
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        weatherTableView.rowHeight = Constants.rowHeight
        weatherTableView.register(CityTableViewCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
    }
    
    // MARK: - Actions
    @objc private func handleDismissKeyboard() {
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "Los Angeles"
        cell.textLabel?.textColor = .white
        return cell
    }
}

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
