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
    
        

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpCell(_ data: Movie){
        self.lblTitle.text = data.title
        if let posterPath = data.posterPath{
            let posterURL = basePosterURL + posterPath
            self.imgPoster.sd_setImage(with: URL(string: posterURL), completed: nil)
        }
    }
}
