//
//  MovieListingVC.swift
//  MovieMania
//
//  Created by EPIC on 02/10/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import UIKit

class MovieListingVC: UIViewController {
    
    @IBOutlet weak var collectionMovies: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
        
    private let resusableIdentifier: String = "MovieListingCVC"
    //VIEWMODEL OBJECT
    private let viewModel: MovieListingViewModel = MovieListingViewModel()
    
    var movies: [Movie] = []
    
    var pageCount: Int = 1
    var totalCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
        collectionMovies.delegate = self
        collectionMovies.dataSource = self
        searchBar.delegate = self
        collectionMovies.register(UINib(nibName: resusableIdentifier, bundle: nil), forCellWithReuseIdentifier: resusableIdentifier)
        
        fetchMovies()
    }
    
        
    func fetchMovies(){
        viewModel.fetchMovies(pageCount) {
           self.totalCount = self.viewModel.totalResult
           self.movies = self.viewModel.Movies
           self.collectionMovies.reloadData()
       }
    }
}

extension MovieListingVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(search), object: nil)
        perform(#selector(search), with: self, afterDelay: 0.2)

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchMovies(1) {
            self.pageCount = 1
            self.movies = self.viewModel.Movies
            self.collectionMovies.reloadData()
        }
    }
    
    
    @objc func search(){
        if self.searchBar.text != ""{
            viewModel.searchMovie(self.searchBar.text!, page: 1) {
                self.pageCount = 1
                self.totalCount = self.viewModel.totalResult
                self.movies = self.viewModel.Movies
                self.collectionMovies.reloadData()
            }
        }else{
            viewModel.fetchMovies(1) {
                self.totalCount = self.viewModel.totalResult
                self.movies = self.viewModel.Movies
                self.collectionMovies.reloadData()
            }
        }
    }
}

//MARK:- COLLECTIONVIEW EXTENSION
extension MovieListingVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == movies.count - 1 && movies.count < totalCount{
            pageCount += 1
            // Call API here
            if searchBar.text != ""{
                viewModel.searchMovie(searchBar.text!, page: self.pageCount) {
                    self.movies += self.viewModel.Movies
                    self.collectionMovies.reloadData()
                }
            }else{
                viewModel.fetchMovies(pageCount) {
                    self.movies += self.viewModel.Movies
                    self.collectionMovies.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resusableIdentifier, for: indexPath) as! MovieListingCVC
        cell.setUpCell(movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWd = (collectionView.frame.width / 3) - 20
        return CGSize(width: itemWd, height: itemWd * 2.2)
    }
    
    
}
