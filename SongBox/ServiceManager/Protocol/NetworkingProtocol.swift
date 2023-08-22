//
//  NetworkingProtocol.swift
//  SongBox
//
//  Created by Cenk Bahadır Çark on 22.08.2023.
//

import Foundation

protocol Networking {
    func fetchData<T: Decodable>(endPoint: APIEndPoint, completion: @escaping (Result<T, Error>) -> Void)
}
