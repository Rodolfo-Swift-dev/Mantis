//
//  ViewController.swift
//  Mantis
//
//  Created by rodoolfo gonzalez on 10-05-23.

import UIKit

class HomeViewController: UIViewController, ObservableObject {
    
    @IBOutlet weak var viewTextField: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    @IBOutlet weak var searchTextfield: UITextField!
        
    @IBOutlet weak var checkView1: UIImageView!
    @IBOutlet weak var checkView2: UIImageView!
    @IBOutlet weak var checkView3: UIImageView!
    @IBOutlet weak var checkView4: UIImageView!
    @IBOutlet weak var checkView5: UIImageView!
    @IBOutlet weak var checkView6: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTextField.round()
        view1.round()
        view2.round()
        view3.round()
        view4.round()
        view5.round()
        view6.round()
        
        networkManager.delegate = self
        searchTextfield.delegate = self
      
    }
}
//MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextfield.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextfield.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
         
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)  {
       
        if let nameUser = searchTextfield.text {
          print(nameUser)
            Task {
                await self.networkManager.processNetwork(name: nameUser)
            }
            
         
        }
        
        searchTextfield.text = ""
        
    }
}
//MARK: - NetworkManagerDelegate
extension HomeViewController: NetworkManagerDelegate {
    
    func didUpdateNetwork(_ networkManager: NetworkManager, network: [NetworkModel]) {
        DispatchQueue.main.async {
            self.checkView1.image = UIImage(systemName: network[0].condition.sFSymbolName)
            self.checkView2.image = UIImage(systemName: network[1].condition.sFSymbolName)
            self.checkView3.image = UIImage(systemName: network[2].condition.sFSymbolName)
            self.checkView4.image = UIImage(systemName: network[3].condition.sFSymbolName)
            self.checkView5.image = UIImage(systemName: network[4].condition.sFSymbolName)
            self.label1.text = network[0].condition.conditionString
            self.label2.text = network[1].condition.conditionString
            self.label3.text = network[2].condition.conditionString
            self.label4.text = network[3].condition.conditionString
            self.label5.text = network[4].condition.conditionString
    
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

