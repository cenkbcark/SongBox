//
//  MainDataProviderProtocol.swift
//  SongBox
//
//  Created by Cenk Bahadır Çark on 22.08.2023.
//

import Foundation

protocol MainDataProviderProtocol {
    func fetchSongs(endPoint: APIEndPoint, completion: @escaping (Result<MostPlayedSongResponse, Error>) -> Void)
}
