//
//  HomeViewModel.swift
//  Business
//
//  Created by Tulakshana Weerasooriya on 2022-02-02.
//

import Foundation
import CoreLocation

protocol HomeDelegate: NSObjectProtocol {
    func homeDidThrowAnError(model: HomeViewModel, error: HomeViewModel.Error)
}

class HomeViewModel: NSObject {
    
    enum Error {
        case locationServicesDisabled
        
        func message() -> String {
            switch self {
            case .locationServicesDisabled:
                return NSLocalizedString("error_location_services_disabled",
                                         comment: "Location services are disabled")
            }
        }
    }
    
    private let locManager = CLLocationManager.init()
    weak var delegate: HomeDelegate?
    
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
    
    private func throwLocationServicesDisabledError() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.delegate?.homeDidThrowAnError(model: strongSelf, error: HomeViewModel.Error.locationServicesDisabled)
        }
    }
}

extension HomeViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorization()
    }
}
