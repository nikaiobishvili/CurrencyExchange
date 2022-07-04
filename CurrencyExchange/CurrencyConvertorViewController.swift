import UIKit

class CurrencyConvertorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var submitButton: UIButton!
    
    var currencies = [Currency]()
    
    var selectedCurrencyFrom: Currency? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var selectedCurrencyto: Currency? {
        didSet {
            self.tableView.reloadData()
        }
    }

    var activeCurrency = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        appendToCurrencies()
        updateUI()
        cellRegister()
    }
    
    @objc func updateViews(input: Double) {
        
    }
    
    func updateUI() {
        submitButton.layer.cornerRadius = 25
        tableView.separatorStyle = .none
        submitButton.isEnabled = false
        submitButton.backgroundColor = .lightGray
    }
    
    func cellRegister() {
        tableView.register(LabelTableviewCell.nib(),
                           forCellReuseIdentifier: "LabelTableviewCell")
        tableView.register(CurrenciesScrollTableViewCell.nib(),
                           forCellReuseIdentifier: "CurrenciesScrollTableViewCell")
        tableView.register(BuyCurrencyTableViewCell.nib(),
                           forCellReuseIdentifier: "BuyCurrencyTableViewCell")
    }
    
    func appendToCurrencies() {
        currencies.append(Currency(amount: 1000.00, currency: "EUR"))
        currencies.append(Currency(amount: 0.0, currency: "USD"))
        currencies.append(Currency(amount: 0.0, currency: "JPY"))
    }
    
    func createSheetForFrom() {
        let actionSheet = UIAlertController(title: "", message: "Choose the currency", preferredStyle: .actionSheet)
        currencies.forEach { currency in
            actionSheet.addAction(UIAlertAction(title: currency.currency, style: .default, handler: {[weak self] action in
                self?.selectedCurrencyFrom = currency
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func createSheetForTo() {
        let actionSheet = UIAlertController(title: "", message: "Choose the currency", preferredStyle: .actionSheet)
        currencies.forEach { currency in
            actionSheet.addAction(UIAlertAction(title: currency.currency, style: .default, handler: {[weak self] action in
                self?.selectedCurrencyto = currency
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableviewCell.identifier,
                                                     for: indexPath) as! LabelTableviewCell
            cell.myLabel.text = "MY BALANCES"
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrenciesScrollTableViewCell.identifier, for: indexPath) as! CurrenciesScrollTableViewCell
            cell.configure(with: currencies)
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyCurrencyTableViewCell.identifier,
                                                     for: indexPath) as! BuyCurrencyTableViewCell
            cell.imageView?.image = UIImage(named: "image-2")
            cell.exchangeLabel.text = "Sell"
            cell.buttonTouchedClosure = { [weak self] in
                self?.createSheetForFrom()
            }
            if selectedCurrencyFrom?.currency != nil &&
                selectedCurrencyFrom?.currency != selectedCurrencyto?.currency {
                cell.currencyType.text = selectedCurrencyFrom?.currency
            } else {
                cell.currencyType.text = "EUR"
            }
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyCurrencyTableViewCell.identifier,
                                                     for: indexPath) as! BuyCurrencyTableViewCell
            cell.exchangeLabel.text = "Receive"
            cell.imageView?.image = UIImage(named: "image-1")
            cell.buttonTouchedClosure = { [weak self] in
                self?.createSheetForTo()
            }
            if selectedCurrencyto?.currency != nil {
                cell.currencyType.text = selectedCurrencyto?.currency
            } else {
                cell.currencyType.text = "EUR"
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableviewCell.identifier,
                                                 for: indexPath) as! LabelTableviewCell
        cell.myLabel.text = "CURRENCY EXCHANGE"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    @IBAction func tapTpSubmitButton() {
        /*
         if Sell(გასაყიდი)-ის ველიუ < არსებულ ვალუტის ემაუნთზე && ტრანზაქცია > 5 {
            არსებულ ვალუტის ემაუნთს - Sell(გასაყიდი) -ის ემაუნთი
            Receiver-ის ვალუტის ემაუნთს + არსებულ შესაბამის ვალუტის ემაუნთს
            let alert = UIAlertController(title: "Currency converted",
                                       message: "You have converted \("nika") \("nika") to \("nika") \("nika"). Commision Fee - \("nika") \("nika")",
                                       preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "DONE",
                                       style: .default,
                                       handler: nil))
            self.present(alert, animated: true, completion: nil)
            submitButton.isEnabled = true
            submitButton.backgroundColor = .systemBlue
         } else if Sell(გასაყიდი)-ის ველიუ < არსებულ ვალუტის ემაუნთზე && ტრანზაქცია <= 5 {
            არსებულ ვალუტის ემაუნთს - Sell(გასაყიდი) -ის ემაუნთი
            Receiver-ის ვალუტის ემაუნთს + არსებულ შესაბამის ვალუტის ემაუნთს
            let alert = UIAlertController(title: "Currency converted",
                                    message: "You have converted \("nika") \("nika") to \("nika") \("nika"). Commision Fee - 0 \("CURRENCY")",
                                    preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "DONE",
                                    style: .default,
                                    handler: nil))
            self.present(alert, animated: true, completion: nil)
            submitButton.isEnabled = true
            submitButton.backgroundColor = .systemBlue
         } else {
            submitButton.isEnabled = false
         }
         self.tableView.reloadData()
         */
    }
}
