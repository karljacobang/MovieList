//
//  ViewController.swift
//  MovieLiest
//
//  Created by Karl Jacob Ang on 6/1/22.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var movieList: [MoviesModel] = []
    var service = Webservices()
    weak var lastVisited: MoviesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MoviesTableViewCell.self)
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        fetchMovieList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = lastVisited == nil ? "" : "Last screen visited: \(lastVisited!.trackName)"
    }
    
    func fetchMovieList() {
        service.fetchMovies { [unowned self] result in
            switch result {
            case .success(let list):
                self.movieList = list
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Extensions

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MoviesTableViewCell
        cell.moviesModel = movieList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = movieList[indexPath.row]
        
        let sb = UIStoryboard(name:"Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MovieViewControllerID") as! MovieViewController
        vc.moviesModel = item
        vc.delegate = self
        lastVisited = item
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.reloadData()
    }
}

extension ViewController: BackDelegate {
    func back() {
        tableView.reloadData()
    }
}
