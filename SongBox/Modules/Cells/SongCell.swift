//
//  SongCell.swift
//  SongBox
//
//  Created by Cenk Bahadır Çark on 22.08.2023.
//

import UIKit

final class SongCell: UITableViewCell {

    @IBOutlet weak private var songImage: UIImageView!
    @IBOutlet weak private var songNameLabel: UILabel!
    @IBOutlet weak private var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setSong(_ model: MusicModel?) {
        guard let model = model else { return }
        self.songNameLabel.text = model.name
        self.contentLabel.text = model.artistName
        ImageDownloader.downloadImage(from: model.artworkUrl100) { image in
            DispatchQueue.main.async {
                self.songImage.image = image
            }
        }
    }
}

