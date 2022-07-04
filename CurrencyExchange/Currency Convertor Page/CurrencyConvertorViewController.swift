//
//  CurrencyConvertorViewController.swift
//  CurrencyExchange
//
//  Created by Nika on 6/27/22.
//

import UIKit

class CurrencyConvertorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    var currencies = [Currency]()

    override func viewDidLoad() {
        super.viewDidLoad()
        appendToCurrencies()
        title = "Currency convertor"
        tableView.dataSource = self
        tableView.delegate = self
        cellRegister()
    }
    
    func cellRegister() {
        tableView.register(LabelTableviewCell.self,
                           forCellReuseIdentifier: LabelTableviewCell.identifier)
        tableView.register(CurrencyCollectionViewCell.self,
                           forCellReuseIdentifier: CurrencyCollectionViewCell.identifier)
        tableView.register(BuyCurrencyTableViewCell.self,
                           forCellReuseIdentifier: BuyCurrencyTableViewCell.identifier)
    }
    
    func appendToCurrencies() {
        currencies.append(Currency(amount: 1000, currency: "EUR"))
        currencies.append(Currency(amount: 0, currency: "USD"))
        currencies.append(Currency(amount: 0, currency: "JPY"))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableviewCell.identifier, for: indexPath) as! LabelTableviewCell
            cell.textLabel?.text = "MY BALANCES"
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrenciesScrollTableViewCell.identifier, for: indexPath) as! CurrenciesScrollTableViewCell
            cell.configure(with: currencies)
            return cell
        } else if indexPath.row == 4 && indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyCurrencyTableViewCell.identifier, for: indexPath) as! BuyCurrencyTableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableviewCell.identifier, for: indexPath) as! LabelTableviewCell
        cell.textLabel?.text = "CURRENCY EXCHANGE"
        return cell
    }
}
