//
//  HomeViewModel.swift
//  Business
//
//  Created by Tulakshana Weerasooriya on 2022-02-02.
//

import Foundation
import CoreLocation

protocol HomeDelegate: NSObjectProtocol {
    func homeDidThrowAnError(model: HomeViewModel, error: String)
}

class HomeViewModel: NSObject {
    
    enum HomeError {
        case locationServicesDisabled
        case somethingWentWrong
        
        func message() -> String {
            switch self {
            case .locationServicesDisabled:
                return NSLocalizedString("error_location_services_disabled",
                                         comment: "Location services are disabled")
            case .somethingWentWrong:
                return NSLocalizedString("error_something_went_wrong",
                                         comment: "Something went wrong. Please try again!")
            }
        }
    }
    
    private let locManager = CLLocationManager.init()
    weak var delegate: HomeDelegate?
    
    // MARK: - Location handling
    
    func startLocationService() {
        guard CLLocationManager.locationServicesEnabled() else {
            throwLocationServicesDisabledError()
            return
        }
        locManager.delegate = self
        locManager.stopUpdatingLocation()
        handleAuthorization()
    }
    
    private func handleAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            throwLocationServicesDisabledError()
        case .authorizedWhenInUse:
            locManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    // MARK: - Errors
    
    private func throwSomethingWentWrongError() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.delegate?.homeDidThrowAnError(model: strongSelf, error: HomeViewModel.HomeError.somethingWentWrong.message())
        }
    }
    
    private func throwLocationServicesDisabledError() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.delegate?.homeDidThrowAnError(model: strongSelf, error: HomeViewModel.HomeError.locationServicesDisabled.message())
        }
    }
    
    // MARK: -
    
    func search(term: String) {
        guard let loc = locManager.location else {
            handleAuthorization()
            throwSomethingWentWrongError()
            return
        }
        API.search(term: term, location: loc) { [weak self] (error: Error?, response: SearchResponse?) in
            if error != nil {
                self?.throwSomethingWentWrongError()
                return
            }
            
            
        }
    }
}

extension HomeViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorization()
    }
}
