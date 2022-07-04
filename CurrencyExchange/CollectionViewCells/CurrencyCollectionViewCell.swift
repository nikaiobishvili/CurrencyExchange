import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var currencyAmmount: UILabel!
    @IBOutlet weak var currencyType: UILabel!
    
    static let identifier = "CurrencyCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CurrencyCollectionViewCell",
                     bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with model: Currency) {
        self.currencyAmmount.text = "\(model.amount)"
        self.currencyType.text = model.currency
    }
}
