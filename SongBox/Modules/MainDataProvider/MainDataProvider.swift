//
//  MainDataProvider.swift
//  SongBox
//
//  Created by Cenk Bahadır Çark on 22.08.2023.
//

import Foundation


final class MainDataProvider: MainDataProviderProtocol {
    
    private let serviceManager: Networking
    
    init(serviceManager: Networking) {
        self.serviceManager = serviceManager
    }
    
    func fetchSongs(endPoint: APIEndPoint, completion: @escaping (Result<MostPlayedSongResponse, Error>) -> Void) {
        serviceManager.fetchData(endPoint: endPoint, completion: completion)
    }
    
}
