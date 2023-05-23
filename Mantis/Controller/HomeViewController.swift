//
//  ViewController.swift
//  Mantis
//
//  Created by rodoolfo gonzalez on 10-05-23.

import UIKit

class HomeViewController: UIViewController, ObservableObject {
    
    var networkResult : [DataInfo] = []
    
    @IBOutlet weak var viewTextField: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    @IBOutlet weak var searchTextfield: UITextField!
  
    
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
    
    func didUpdateNetwork(_ networkManager: NetworkManager, network: [DataInfo]) {
        self.networkResult = network
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            
            destinationVC.image1 = UIImage(systemName: networkResult[0].condition.sFSymbolName)
            destinationVC.image2 = UIImage(systemName: networkResult[1].condition.sFSymbolName)
            destinationVC.image3 = UIImage(systemName: networkResult[2].condition.sFSymbolName)
            destinationVC.image4 = UIImage(systemName: networkResult[3].condition.sFSymbolName)
            destinationVC.image5 = UIImage(systemName: networkResult[4].condition.sFSymbolName)
            
            destinationVC.label1Result = networkResult[0].condition.conditionString
            destinationVC.label2Result = networkResult[1].condition.conditionString
            destinationVC.label3Result = networkResult[2].condition.conditionString
            destinationVC.label4Result = networkResult[3].condition.conditionString
            destinationVC.label5Result = networkResult[4].condition.conditionString
            
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

