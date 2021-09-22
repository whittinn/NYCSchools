//
//  SATScoreTableViewCell.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import UIKit

class SATScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var averageWriting: UILabel!
    @IBOutlet weak var averageReading: UILabel!
    @IBOutlet weak var averageMath: UILabel!
    
    @IBOutlet weak var schooltesters: UILabel!
    @IBOutlet weak var schoolName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
