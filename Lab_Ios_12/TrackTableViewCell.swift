//
//  TrackTableViewCell.swift
//  MusicDownloader
//
//  Created by erumaru on 4/18/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

protocol TrackTableViewCellDelegate: class {
    func didPressPlay(track: Track)
   
}

class TrackTableViewCell: UITableViewCell {
    // MARK: - Outlets
   
    @IBOutlet var nameLabel: UILabel!
    
    // MARK: - Variables
    var track: Track! {
        didSet {
            self.nameLabel.text = track.trackName
           
            
           
            
            
        }
    }
    weak var delegate: TrackTableViewCellDelegate?
    
    // MARK: - Actions
   
    
    
    @IBAction func play(_ sender: UIButton) {
        delegate?.didPressPlay(track: track)
    }
   
    }

