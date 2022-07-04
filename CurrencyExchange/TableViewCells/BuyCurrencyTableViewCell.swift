import UIKit

class BuyCurrencyTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var exchangeImage: UIImageView!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var currencyType: UILabel!
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var currencyChooserButton: UIButton!
    var buttonTouchedClosure : (()->Void)?
    var amt: Int = 0
    var urlString = "http://api.evp.lt/currency/commercial/exchange/%7BfromAmount%7D-%7BfromCurrency%7D/%7BtoCurrency%7D/latest"
    
    static let identifier = "BuyCurrencyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BuyCurrencyTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextFiled()
        textFiled.resignFirstResponder()
        textFiled.becomeFirstResponder()
    }
    
    func setTextFiled() {
        textFiled.delegate = self
        textFiled.borderStyle = .none
        textFiled.placeholder = updateAmount()
        textFiled.font = .systemFont(ofSize: 20)
        textFiled.textAlignment = .right
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        textFiled.inputAccessoryView = toolBar
    }
    
    @objc private func didTapDone() {
        textFiled.resignFirstResponder()
        fetchJSON()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let digit = Int(string) {
            amt = amt * 10 + digit
            
            if amt > 1_000_000_000 {
                textField.text = ""
                amt = 0
            } else {
                textField.text = updateAmount()
            }
        }
        if string == "" {
            amt = amt / 10
            textField.text = amt == 0 ? "" : updateAmount()
        }
        return false
    }
    
    func fetchJSON() {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if  error != nil {
                print(error)
                return
            }
            guard let safeData = data else { return }
            
            do {
                let results = try JSONDecoder().decode(Currency.self, from: safeData)
                print(results.amount)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func updateAmount() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.currencySymbol = ""
        let amount = Double(amt / 100) + Double(amt % 100) / 100
        return formatter.string(from: NSNumber(value: amount))
    }
    
    @IBAction func tapToCurrencyChooser() {
        self.buttonTouchedClosure?()
    }
    
    
    @IBAction func textFiledEditingChanged(_ sender: UITextField) {
        print(textFiled.text)
    }
}
