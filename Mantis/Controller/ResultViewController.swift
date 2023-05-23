//
//  ResultViewController.swift
//  Mantis
//
//  Created by rodoolfo gonzalez on 10-05-23.
//

import UIKit

class ResultViewController: UIViewController {
    
    var label1Result : String?
    var label2Result : String?
    var label3Result : String?
    var label4Result : String?
    var label5Result : String?
    
    var image1 : UIImage?
    var image2 : UIImage?
    var image3 : UIImage?
    var image4 : UIImage?
    var image5 : UIImage?
    
   
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
   
    @IBOutlet weak var button: UIButton!
    
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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.rounded()
        view1.round()
        view2.round()
        view3.round()
        view4.round()
        view5.round()
        view6.round()
        
        checkView1.image = image1
        checkView2.image = image2
        checkView3.image = image3
        checkView4.image = image4
        checkView5.image = image5
        
        label1.text = label1Result
        label2.text = label2Result
        label3.text = label3Result
        label4.text = label4Result
        label5.text = label5Result
    }
    
   
    @IBAction func buttonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
   

}
