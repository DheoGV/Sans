//
//  MantraViewController.swift
//  SANS - NC1
//
//  Created by Dheo Gildas Varian on 05/05/21.
//

import UIKit

class MantraViewController: UIViewController {

    
    @IBOutlet weak var mantraLbl: UILabel!
    
    var tf: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func mantraAction(_ sender: Any) {
        let alert = UIAlertController(title: "Change The Mantra", message: "You can change the mantra's and repeating that can make it easier to express difficult emotions.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            self.tf = textField
        }
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
            self.mantraLbl.text = self.tf?.text
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
