//
//  AlertManager.swift
//  SongBox
//
//  Created by Cenk Bahadır Çark on 23.08.2023.
//

import UIKit

protocol AlertShowable {
    func showAlert(with error: String)
}

// MARK: - AlertManager
final class AlertManager: AlertShowable {
    
    // MARK: Properties
    static let shared: AlertManager = .init()
    
    func showAlert(with error: String) {

        let alert = UIAlertController(
            title: "Opps!",
            message: error,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            
        }))

        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true)
        }
    }
}
