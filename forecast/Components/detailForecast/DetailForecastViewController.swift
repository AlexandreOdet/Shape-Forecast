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
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 5, height: 60)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    @available(iOS 13.0, *)
    private lazy var collectionViewDataSource = setUpCollectionViewDataSource()
    
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
    
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        if #available(iOS 13.0, *) {
            collectionView.dataSource = collectionViewDataSource
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 13.0, *)
    private func setUpCollectionViewDataSource() -> UICollectionViewDiffableDataSource<ListBusiness, collectionViewSection> {
        return UICollectionViewDiffableDataSource(collectionView: self.collectionView,
                                                  cellProvider: { collectionView, indexPath, object in
                                    return UICollectionViewCell()
        })
    }
}

extension DetailForecastViewController: UICollectionViewDelegate {
    
}

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
}
