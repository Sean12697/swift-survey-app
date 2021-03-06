//
//  q2aViewController.swift
//  SurveyApp
//
//  Created by Sean O'mahoney on 18/03/2019.
//  Copyright © 2019 Yap Moi Hoon. All rights reserved.
//

import UIKit

class q2aViewController: UIViewController {

    var data:dataStruct?
    @IBOutlet weak var btnWork: UIButton!
    @IBOutlet weak var btnGaming: UIButton!
    @IBOutlet weak var btnInternet: UIButton!
    @IBOutlet weak var btnSocial: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    let refreshAlert = UIAlertController(title: "Confirm", message: "Are you happy with your answer?", preferredStyle: UIAlertController.Style.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnNext.isEnabled = false;
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.performSegue(withIdentifier: "q2a-q3", sender: self)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel))
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        btnNext.isEnabled = true; // Once the user has selected an option then they can proceed

        switch sender.tag {
        case 0:
            data?.q2a = "Work";
            selectAllExecept(btnWork);
        case 1:
            data?.q2a = "Gaming";
            selectAllExecept(btnGaming);
        case 2:
            data?.q2a = "Internet";
            selectAllExecept(btnInternet);
        case 3:
            data?.q2a = "Social";
            selectAllExecept(btnSocial);
        case 4:
            data?.q2a = "Other";
            selectAllExecept(btnOther);
        default: print("Selection Error")
        }
    }
    
    // Switching to the selected version of the image used on the button
    func selectAllExecept(_ execept: UIButton) {
        btnWork.isSelected = false;
        btnGaming.isSelected = false;
        btnInternet.isSelected = false;
        btnSocial.isSelected = false;
        btnOther.isSelected = false;
        execept.isSelected = true;
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        present(refreshAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        guard let destination = segue.destination as? q3ViewController else {return}
        destination.data = self.data;
    }

}
