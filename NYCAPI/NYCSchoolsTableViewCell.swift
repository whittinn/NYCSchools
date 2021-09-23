//
//  NYCSchoolsTableViewCell.swift
//  NycSchools
//
//  Created by Nathaniel Whittington on 9/22/21.
//

import UIKit

class NYCSchoolsTableViewCell: UITableViewCell {

    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //Created a function to assign properties of NewYorkSchool to school parameter. This function is called from our UITableViewDataScource function cellforrow function. This function populates each cell with the selected school's data. Cells are layout based on our xib file created.
    func set(with school: NewYorkSchool) {
        schoolLabel.text = school.schoolName
        addressLabel.text = school.location
        numberLabel.text = school.phoneNumber
    }
    
}
