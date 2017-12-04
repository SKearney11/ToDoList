//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Sean Kearney on 03/12/2017.
//  Copyright © 2017 Sean Kearney. All rights reserved.
//

import Foundation
import UIKit

@objc protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell{
    
    var delegate: ToDoCellDelegate?
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.checkmarkTapped(sender: self)
    }
    @IBOutlet weak var titleLabel: UILabel!    
}
