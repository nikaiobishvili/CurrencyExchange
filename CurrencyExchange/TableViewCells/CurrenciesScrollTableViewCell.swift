import UIKit

class CurrenciesScrollTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "CurrenciesScrollTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CurrenciesScrollTableViewCell", bundle: nil)
    }
    
    var models = [Currency]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func configure(with models: [Currency]) {
        self.models = models
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(CurrencyCollectionViewCell.nib(), forCellWithReuseIdentifier: CurrencyCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.identifier, for: indexPath) as! CurrencyCollectionViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 80)
    }
}
