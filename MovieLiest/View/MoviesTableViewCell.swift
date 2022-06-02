//
//  MoviesTableViewCell.swift
//  MovieLiest
//
//  Created by Karl Jacob Ang on 6/1/22.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var lblLastVisit: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    
    var moviesModel: MoviesModel? {
        didSet {
            artistName.text = moviesModel?.artistName
            trackName.text = moviesModel?.trackName
            price.text = moviesModel?.trackPrice
            lblLastVisit.text = "Last Visited: " + moviesModel!.lastView
            self.imgView.image = nil
            if let url = moviesModel?.image {
                guard let request = URL(string: url) else { return }
                DispatchQueue.main.async { [weak self] in
                    if let imageData = try? Data(contentsOf: request) {
                        if let loadedImage = UIImage(data: imageData) {
                            self?.imgView.image = loadedImage
                        }
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
