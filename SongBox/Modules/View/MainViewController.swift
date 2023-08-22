//
//  MainViewController.swift
//  SongBox
//
//  Created by Cenk Bahadır Çark on 22.08.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func prepareTableView()
    func registerCellsForTableView()
    func registerHeaderForTableView()
}

final class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var iconHeader: StretchyHeader?
    var viewModel: MainViewModelProtocol? {
        didSet {
            viewModel?.view = self
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        viewModel?.fetchSongs()
    }
}
extension MainViewController: MainViewModelDelegate {
    func handle(notify: MainViewNotify) {
        switch notify {
        case .didFetchSongs:
            tableView.reloadData()
        case .errorFetchSongs(error: let error):
            print(error)
        case .reloadTableView:
            tableView.reloadData()
        }
    }
}

extension MainViewController: MainViewProtocol {

    func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    func registerCellsForTableView() {
        let songCellName = String(describing: SongCell.self)
        let songCellNib = UINib(nibName: songCellName, bundle: .main)
        tableView.register(songCellNib, forCellReuseIdentifier: songCellName)
    }
    
    func registerHeaderForTableView() {
        iconHeader = StretchyHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 90))
        tableView.tableHeaderView = iconHeader
        tableView.contentInsetAdjustmentBehavior = .never
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let cellTypeCount = viewModel?.cellType.count else { return 0 }
        return cellTypeCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = viewModel?.cellType[section], let songs = viewModel?.songs.count else {
            return 0
        }
        switch section {
        case .songs:
            return songs
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = viewModel?.cellType[indexPath.section] else { return UITableViewCell() }
        switch section {
        case.songs:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongCell {
                cell.setSong(viewModel?.songs[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRowAt(at: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? StretchyHeader else { return }
        header.scrollViewDidScroll(scrollView: scrollView)
    }
}
