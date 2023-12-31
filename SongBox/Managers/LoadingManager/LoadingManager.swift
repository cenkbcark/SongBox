//
//  LoadingManager.swift
//  SongBox
//
//  Created by Cenk Bahadır Çark on 23.08.2023.
//

import UIKit

// MARK: - Loading
protocol Loading {
    func show()
    func hide()
}

// MARK: - LoadingManager
final class LoadingManager: Loading {
    
    // MARK: Properties
    static let shared: LoadingManager = .init()
    
    enum Constants {
        static let cornerRadius = 8.0
        static let loadingViewWidth = 65.0
        static let loadingViewHeight = 65.0
        static let activtyIndicatorWidth = 55.0
        static let activtyIndicatorHeight = 55.0
    }
    
    // MARK: Views
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .black
        return activityIndicator
    }()
}

// MARK: - Functions
extension LoadingManager {
    /// Show loading view
    func show() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.setupLoadingView(on: window)
                }
            }
        }
    }
    
    /// Hide loading view
    func hide() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else { return }
                    
                    self.loadingView.removeFromSuperview()
                    window.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    private func setupLoadingView(on window: UIWindow) {
        window.addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        window.bringSubviewToFront(loadingView)
        window.isUserInteractionEnabled = false
        
        loadingView.setConstarint(
            centerX: window.centerXAnchor,
            centerY: window.centerYAnchor,
            width: Constants.loadingViewWidth,
            height: Constants.loadingViewHeight
        )
        
        activityIndicator.setConstarint(
            centerX: loadingView.centerXAnchor,
            centerY: loadingView.centerYAnchor,
            width: Constants.activtyIndicatorWidth,
            height: Constants.activtyIndicatorHeight
        )
    }
}
