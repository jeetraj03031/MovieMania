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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
        collectionMovies.delegate = self
        collectionMovies.dataSource = self
        searchBar.delegate = self
        collectionMovies.register(UINib(nibName: resusableIdentifier, bundle: nil), forCellWithReuseIdentifier: resusableIdentifier)
        
        viewModel.fetchMovies(1) {
            self.collectionMovies.reloadData()
        }
    }
    
}

extension MovieListingVC: UISearchBarDelegate{
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text != ""{
            viewModel.searchMovie(searchBar.text!) {
                self.collectionMovies.reloadData()
            }
        }
    }
    
}

//MARK:- COLLECTIONVIEW EXTENSION
extension MovieListingVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.Movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resusableIdentifier, for: indexPath) as! MovieListingCVC
        cell.setUpCell(viewModel.Movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWd = (collectionView.frame.width / 3) - 20
        return CGSize(width: itemWd, height: itemWd * 2.2)
    }
    
    
}
