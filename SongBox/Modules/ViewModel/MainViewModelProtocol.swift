//
//  MainViewModelProtocol.swift
//  SongBox
//
//  Created by Cenk Bahadır Çark on 22.08.2023.
//

import Foundation

protocol MainViewModelProtocol {
    var view: MainViewProtocol? { get set }
    var delegate: MainViewModelDelegate? { get set }
    var songs: [MusicModel] { get set }
    var cellType: [TablecellType] { get set }
    
    func viewDidLoad()
    func fetchSongs()
    func didSelectRowAt(at indexPath: IndexPath)
    
}

enum MainViewNotify {
    case didFetchSongs
    case errorFetchSongs(error: String)
    case reloadTableView
}

protocol MainViewModelDelegate: AnyObject {
    func handle(notify: MainViewNotify)
}
