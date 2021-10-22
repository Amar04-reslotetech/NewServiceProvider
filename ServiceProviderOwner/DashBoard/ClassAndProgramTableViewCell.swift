//
//  ClassAndProgramTableViewCell.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 07/09/21.
//

import UIKit

class ClassAndProgramTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSpaceName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var myOuterView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI( with obj:ClassAndProgram)
    {
        lblTime.text = obj.time
        lblName.text = obj.className
        lblSpaceName.text = obj.progrma
    }

}
