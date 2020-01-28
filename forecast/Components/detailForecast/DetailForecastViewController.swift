//
//  DetailForecastViewController.swift
//  forecast
//
//  Created by Odet Alexandre on 26/01/2020.
//  Copyright © 2020 SHAPE A/S. All rights reserved.
//

import Foundation
import UIKit

protocol DetailForecastViewControllerOutput: class {
    func viewDidLoad()
    func didClickCloseButton()
}

fileprivate enum collectionViewSection: CaseIterable {
    case main
}

fileprivate enum tableViewSection: CaseIterable {
    case main
}

final class DetailForecastViewController: UIViewController {
    var output: DetailForecastViewControllerOutput!
    
    private lazy var backgroundView = UIImageView(frame: .zero)
    
    //Current Weather
    private lazy var cityNameLabel = UILabel(frame: .zero)
    private lazy var currentWeatherLabel = UILabel(frame: .zero)
    private lazy var currentTemperatureLabel = UILabel(frame: .zero)
    private lazy var todayLabel = UILabel(frame: .zero)
    private lazy var maxTemperatureLabel = UILabel(frame: .zero)
    private lazy var minTemperatureLabel = UILabel(frame: .zero)
    
    //24h forecast
    private let collectionViewItemsReuseIdentifier = "todayWeatherItem"
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 5, height: 120)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.register(DetailForecastCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewItemsReuseIdentifier)
        return collectionView
    }()
    
    @available(iOS 13.0, *) //Create diffableDataSource if possible
    private lazy var collectionViewDataSource = setUpCollectionViewDataSource()
    
    private var items = [ListBusiness]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //5 days forecast
    private let tableViewCellReuseIdentifier = "fiveDayForecastCell"
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(FiveDaysForecastTableViewCell.self, forCellReuseIdentifier: tableViewCellReuseIdentifier)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    @available(iOS 13.0, *) //Create diffableDataSource if possible
    private lazy var tableViewDataSource = setUpTableViewDataSource()
    
    private var forecastItems = [ListBusiness]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        output.viewDidLoad()
    }
    
    private func setUp() {
        setUpBackgroundView()
        setUpWeatherLabels()
        setUpTodayTemperatureLabels()
        setUpCollectionView()
        setUpTableView()
    }
    
    private func setUpBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpWeatherLabels() {
        view.addSubview(cityNameLabel)
        view.addSubview(currentWeatherLabel)
        view.addSubview(currentTemperatureLabel)
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 40)
        currentTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 50)
        
        cityNameLabel.textColor = .white
        currentWeatherLabel.textColor = .white
        currentTemperatureLabel.textColor = .white
        
        cityNameLabel.textAlignment = .center
        currentWeatherLabel.textAlignment = .center
        currentTemperatureLabel.textAlignment = .center
        
        cityNameLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            currentWeatherLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 10),
            currentWeatherLabel.centerXAnchor.constraint(equalTo: cityNameLabel.centerXAnchor),
            
            currentTemperatureLabel.topAnchor.constraint(equalTo: currentWeatherLabel.bottomAnchor, constant: 20),
            currentTemperatureLabel.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor)
        ])
    }
    
    private func setUpTodayTemperatureLabels() {
        view.addSubview(todayLabel)
        view.addSubview(maxTemperatureLabel)
        view.addSubview(minTemperatureLabel)
        
        todayLabel.textColor = .white
        todayLabel.font = UIFont.boldSystemFont(ofSize: 20)
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        maxTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 20)
        maxTemperatureLabel.textColor = .white

        minTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        minTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 20)
        minTemperatureLabel.textColor = .lightGray
        
        
        NSLayoutConstraint.activate([
            todayLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 40),
            todayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            minTemperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            minTemperatureLabel.topAnchor.constraint(equalTo: todayLabel.topAnchor),
            
            maxTemperatureLabel.trailingAnchor.constraint(equalTo: minTemperatureLabel.leadingAnchor, constant: -20),
            maxTemperatureLabel.topAnchor.constraint(equalTo: minTemperatureLabel.topAnchor)
        ])
    }
    
    // MARK: - UICollectionView
    
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        let topBorder = UIView()
        let bottomBorder = UIView()
        
        if #available(iOS 13.0, *) {
            topBorder.backgroundColor = .systemGray5
            bottomBorder.backgroundColor = .systemGray5
        } else {
            topBorder.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1) //Very light gray
            bottomBorder.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        }
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topBorder)
        view.addSubview(bottomBorder)
        if #available(iOS 13.0, *) {
            collectionView.dataSource = collectionViewDataSource
        } else {
            // Fallback on earlier versions
            collectionView.dataSource = self
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: minTemperatureLabel.bottomAnchor, constant: 10),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 120),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            topBorder.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            topBorder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topBorder.widthAnchor.constraint(equalTo: view.widthAnchor),
            topBorder.heightAnchor.constraint(equalToConstant: 1),
            
            bottomBorder.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            bottomBorder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomBorder.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    @available(iOS 13.0, *)
    private func setUpCollectionViewDataSource() -> UICollectionViewDiffableDataSource<collectionViewSection, ListBusiness> {
        return UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, object in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewItemsReuseIdentifier, for: indexPath) as! DetailForecastCollectionViewCell
            if indexPath.row == 0 {
                cell.setUpView(with: object, andIsNow: true)
            } else {
                 cell.setUpView(with: object, andIsNow: false)
            }
            cell.backgroundColor = .clear
            return cell
        })
    }
    
    // MARK: - UITableViewRelated
    
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        if #available(iOS 13.0, *) {
            tableView.dataSource = tableViewDataSource
        } else {
            // Fallback on earlier versions
            tableView.dataSource = self
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        let bottomBorder = UIView()
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            bottomBorder.backgroundColor = .systemGray5
        } else {
            bottomBorder.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1) //Very light gray
        }
        view.addSubview(bottomBorder)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 2),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bottomBorder.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            bottomBorder.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1),
            
            tableView.bottomAnchor.constraint(equalTo: bottomBorder.topAnchor)
        ])
    }
    
    @available(iOS 13.0, *)
    private func setUpTableViewDataSource() -> UITableViewDiffableDataSource<tableViewSection, ListBusiness> {
        return UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, object in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellReuseIdentifier) as! FiveDaysForecastTableViewCell
            cell.setUp(with: object)
            cell.backgroundColor = .clear
            return cell
        })
    }
}

// MARK: - UICollectionViewDataSource

extension DetailForecastViewController: UICollectionViewDataSource {  //If under iOS 13 implement the dataSource protocol.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let object = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewItemsReuseIdentifier, for: indexPath) as! DetailForecastCollectionViewCell
        if indexPath.row == 0 {
            cell.setUpView(with: object, andIsNow: true)
        } else {
             cell.setUpView(with: object, andIsNow: false)
        }
        cell.backgroundColor = .clear
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DetailForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01 //Return a really small value otherwise Apple will use UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 //Return a really small value otherwise Apple will use UITableView.automaticDimension
    }
    
}

// MARK: - UITableViewDataSource

extension DetailForecastViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseIdentifier) as! FiveDaysForecastTableViewCell
        let object = forecastItems[indexPath.row]
        cell.setUp(with: object)
        cell.backgroundColor = .clear
        return cell
    }
    
    
}

// MARK: - Presenter output

extension DetailForecastViewController: DetailForecastPresenterOutput {
    func displayTodayDate() {
        todayLabel.text = "\(DateUtils.getFormattedDayName())\tTODAY"
    }
    
    func display(cityName: String) {
        cityNameLabel.text = cityName
    }
    
    func display(temperature: Double) {
        let formattedTemperature = String(format: "%.0f", temperature)
        currentTemperatureLabel.text = "\(formattedTemperature)°"
    }
    
    func display(weather: String) {
        currentWeatherLabel.text = weather
    }
    
    func set(backgroundViewWith weather: Weather) {
        backgroundView.alpha = 0.5
        backgroundView.image = weather.backgroundView
    }
    
    func display(minTemp: Double) {
        let formattedTemperature = String(format: "%.0f", minTemp)
        minTemperatureLabel.text = formattedTemperature
    }
    
    func display(maxTemp: Double) {
        let formattedTemperature = String(format: "%.0f", maxTemp)
        maxTemperatureLabel.text = formattedTemperature
    }
    
    func displayTodayWeather(_ list: [ListBusiness]) {
        if #available(iOS 13.0, *) {
            var snapshot = NSDiffableDataSourceSnapshot<collectionViewSection, ListBusiness>()
            snapshot.appendSections([collectionViewSection.main])
            snapshot.appendItems(list, toSection: .main)
            collectionViewDataSource.apply(snapshot)
        } else {
            // Fallback on earlier versions
            items = list
        }
    }
    
    func displayForecast(_ list: [ListBusiness]) {
        if #available(iOS 13.0, *) {
            var snapshot = NSDiffableDataSourceSnapshot<tableViewSection, ListBusiness>()
            snapshot.appendSections([tableViewSection.main])
            snapshot.appendItems(list, toSection: .main)
            tableViewDataSource.apply(snapshot)
        } else {
            // Fallback on earlier versions
            forecastItems = list
        }
    }
}
