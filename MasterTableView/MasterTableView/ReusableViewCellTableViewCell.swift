//
//  ReusableViewCellTableViewCell.swift
//  MasterTableView
//
//  Created by Bao Long on 26/12/2022.
//

import UIKit

class ReusableViewCellTableViewCell: UITableViewCell {

    @IBOutlet weak var viewML: UIView!
    @IBOutlet weak var animalsLbl: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
