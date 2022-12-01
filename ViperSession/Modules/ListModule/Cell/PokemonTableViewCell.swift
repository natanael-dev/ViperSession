//
//  PokemonTableViewCell.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 8/11/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.cardView.layer.cornerRadius = 10
        self.cardView.layer.shadowRadius = 5
        self.cardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
