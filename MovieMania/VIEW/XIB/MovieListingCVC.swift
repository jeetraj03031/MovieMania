//
//  MovieListingCVC.swift
//  MovieMania
//
//  Created by EPIC on 02/10/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListingCVC: UICollectionViewCell {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    
    var movieVM: MovieListingViewModel = MovieListingViewModel()
    
    var id: String = ""
    
    var likedConfiguration: ButtonConfiguration  = (symbol: "fav_added",buttonTint: .white)
    
    var normalConfiguation: ButtonConfiguration  = (symbol: "fav",buttonTint: .white)
    
    let buttonAnimationFactory: ButtonAnimationFactory = ButtonAnimationFactory()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpCell(_ data: Movie){
        if let ID = data.id{
            id = String(ID)
        }
        self.lblTitle.text = data.title
        if let posterPath = data.posterPath{
            let posterURL = basePosterURL + posterPath
            self.imgPoster.sd_setImage(with: URL(string: posterURL), completed: nil)
        }
        
        let status = movieVM.checkIfFavorite(id: id)
        if status{
            buttonAnimationFactory.makeActivateAnimation(for: btnFav, likedConfiguration)
        }else{
            buttonAnimationFactory.makeDeactivateAnimation(for: btnFav, normalConfiguation)
        }
    }
    
    @IBAction func btnFavouritePressed(_ sender: Any) {
        let status = movieVM.likePressed(id: id)
        if (status) {
            buttonAnimationFactory.makeActivateAnimation(for: btnFav, likedConfiguration)
        } else {
            buttonAnimationFactory.makeDeactivateAnimation(for: btnFav, normalConfiguation)
        }
    }
    
    
}
