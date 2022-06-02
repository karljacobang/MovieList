//
//  MovieViewController.swift
//  MovieLiest
//
//  Created by Karl Jacob Ang on 6/1/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblLastViewed: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var longDescription: UILabel!
    @IBOutlet weak var trackPrice: UILabel!
    @IBOutlet weak var trackRentalPrice: UILabel!
    
    var delegate: BackDelegate?
    var moviesModel: MoviesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLastViewed.text = "Last Visited: " + moviesModel!.lastView
        artistName.text = moviesModel?.artistName
        trackName.text = moviesModel?.trackName
        releaseDate.text = moviesModel?.releaseDate
        trackPrice.text = moviesModel?.trackPrice
        trackRentalPrice.text = moviesModel?.trackRentalPrice
        longDescription.text = moviesModel?.longDescription
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            moviesModel?.lastView = "\(hour):\(minutes)"
            delegate?.back()
        }
    }

}


protocol BackDelegate {
    func back()
}
