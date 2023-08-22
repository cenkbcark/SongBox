//
//  MainViewModel.swift
//  SongBox
//
//  Created by Cenk Bahadır Çark on 22.08.2023.
//

import UIKit

final class MainViewModel: MainViewModelProtocol {

    weak var delegate: MainViewModelDelegate?
    weak var view: MainViewProtocol?
    var songs: [MusicModel] = []
    var cellType: [TablecellType] = []
    
    private let dataProvider: MainDataProviderProtocol
    
    init(dataProvider: MainDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func viewDidLoad() {
        view?.prepareTableView()
        view?.registerCellsForTableView()
        view?.registerHeaderForTableView()
    }
    
    func fetchSongs() {
        dataProvider.fetchSongs(endPoint: .music) { result in
            switch result {
            case .success(let success):
                if let songs = success.feed.results {
                    self.songs =  songs
                    self.cellType.append(.songs)
                    self.notify(with: .didFetchSongs)
                }else {
                    self.notify(with: .errorFetchSongs(error: "Şarkılar yüklenirken hata oluştu."))
                    self.notify(with: .reloadTableView)
                }
            case .failure(let error):
                self.notify(with: .errorFetchSongs(error: error.localizedDescription))
                self.notify(with: .reloadTableView)
            }
        }
    }
    
    func didSelectRowAt(at indexPath: IndexPath) {
        
        if let appURL = URL(string: songs[indexPath.row].url) {
            UIApplication.shared.open(appURL) { success in
                if success {
                    print("The URL was delivered successfully.")
                } else {
                    print("The URL failed to open.")
                }
            }
        } else {
            print("Invalid URL specified.")
        }
    }
    
    private func notify(with notify: MainViewNotify) {
        DispatchQueue.main.async {
            self.delegate?.handle(notify: notify)
        }
    }
    
}
