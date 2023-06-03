//
//  ToDosTableViewCell.swift
//  ToDoListApp
//
//  Created by BhuvanaR on 5/31/23.
//

import UIKit

class ToDosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var toDoTitle: UILabel!
    @IBOutlet weak var toDoDescription: UILabel!
    
    @IBAction func checkBoxButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        checkBoxButton.setImage(UIImage(systemName: "record.circle.fill"), for: .selected)
        checkBoxButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
