//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Sterre Smit on 03/12/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit

// when checked, done
@objc protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    var delegate: ToDoCellDelegate?
    // button and title outlets
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    // checked button function, changing img
    @IBAction func completedButtonTapped(_ sender: Any) {
        delegate?.checkmarkTapped(sender: self)
        
    }
}
