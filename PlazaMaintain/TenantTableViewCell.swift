//
//  TenantTableViewCell.swift
//  PlazaMaintain
//
//  Created by Buwaneka Galpoththawela on 11/5/15.
//  Copyright © 2015 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class TenantTableViewCell: UITableViewCell {
    
    @IBOutlet var repairDisplayLabel :UILabel!
    @IBOutlet var statusLabel :UILabel!
    @IBOutlet var detailsButton :UIButton!
    @IBOutlet var UtilityImage :UIImageView!
    @IBOutlet var statusImage :UIImageView! 
    
    
    
    //MARK: - LIFE CYCLE METHOD

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

            }

}
