//
//  Webservice.swift
//  MovieLiest
//
//  Created by Karl Jacob Ang on 6/1/22.
//

import Foundation

class Webservices {
    
    func fetchMovies(completion: @escaping (Results<[MoviesModel]>) -> ()) {
        MovieListProvider.request(.search("movie")) { result in
            switch result {
            case .success(let response):
                do {
                    let resp = try MovieListResults(data: response.data)
                    completion(.success(resp.movieList))
                } catch RequestError.UnknownError(let error) {
                    completion(.failure(error))
                } catch {}
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            }
        }
    }
}
