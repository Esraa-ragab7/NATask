//
//  IngredientTableViewCell.swift
//  NATask
//
//  Created by Esraa Mohamed Ragab on 09/09/2021.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var quantityUnitAndFoodLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
