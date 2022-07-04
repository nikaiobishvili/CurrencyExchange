import UIKit

class LabelTableviewCell: UITableViewCell {
    
    static let identifier = "LabelTableviewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "LabelTableviewCell", bundle: nil)
    }
    
    @IBOutlet weak var myLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
