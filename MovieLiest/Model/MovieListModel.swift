//
//  MovieListModel.swift
//  MovieLiest
//
//  Created by Karl Jacob Ang on 6/1/22.
//

import Foundation
import SwiftyJSON

struct MovieListResults {
    var movieList: [MoviesModel] = []
    init(data: Data) throws {
        let json = JSON(data)
        let resultCount = json["resultCount"].intValue
        let results = json["results"].arrayValue
        if resultCount > 0 {
            for result in results {
                let artistName = result["artistName"].stringValue
                let trackName = result["trackName"].stringValue
                let image = result["artworkUrl100"].stringValue// image
                let releaseDate = result["releaseDate"].stringValue
                let longDescription = result["longDescription"].stringValue
                let trackPrice = result["trackPrice"].stringValue
                let trackRentalPrice = result["trackRentalPrice"].stringValue
                let model = MoviesModel(artistName: artistName, trackName: trackName, image: image, releaseDate: releaseDate, longDescription: longDescription, trackPrice: trackPrice, trackRentalPrice: trackRentalPrice, lastView: "")
                movieList.append(model)
            }
        } else {
            throw RequestError.UnknownError(error: "NO List")
        }
    }
}

class MoviesModel {
    let artistName: String
    let trackName: String
    let image: String
    let releaseDate: String
    let longDescription: String
    let trackPrice: String
    let trackRentalPrice: String
    var lastView: String
    
    init(artistName: String, trackName: String, image: String, releaseDate: String, longDescription: String, trackPrice: String, trackRentalPrice: String, lastView: String) {
        self.artistName = artistName
        self.trackName = trackName
        self.image = image
        self.releaseDate = releaseDate
        self.longDescription = longDescription
        self.trackPrice = trackPrice
        self.trackRentalPrice = trackRentalPrice
        self.lastView = lastView
    }
}

enum RequestError: Error {
    case UnknownError(error: String)
}
