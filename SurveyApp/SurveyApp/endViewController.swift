//
//  endViewController.swift
//  SurveyApp
//
//  Created by Sean O'mahoney on 19/03/2019.
//  Copyright © 2019 Yap Moi Hoon. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class endViewController: UIViewController, CLLocationManagerDelegate {
    
    var data:dataStruct?
    let locationManager = CLLocationManager() // Needed for location
    @IBOutlet weak var txtTest: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break // If accessed allowed
        }
        
        // Request Access to Location
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    @IBAction func finishClick(_ sender: Any) {
        saveData();
    }
    
    
    @IBAction func btnClick(_ sender: UIButton) {
        if (txtPassword.text == "Password1") {
            self.performSegue(withIdentifier: "end-stats", sender: self);
        } else {
            // Invalid input
        }
    }
    
    // 1 Print location if available
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            data?.lat = currentLocation.coordinate.latitude;
            data?.long = currentLocation.coordinate.longitude;
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func saveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext;
        let userEntity = NSEntityDescription.entity(forEntityName: "Data", in: managedContext);
        let userData = NSManagedObject(entity: userEntity!, insertInto: managedContext);
        
        // Setting all the values need of the entity
        userData.setValue(data!.id, forKeyPath: "id");
        userData.setValue(data!.dob, forKey: "dob");
        userData.setValue(data!.q1, forKey: "q1");
        userData.setValue(data!.q2a, forKey: "q2a");
        userData.setValue(data!.q2b, forKey: "q2b");
        userData.setValue(data!.q3, forKey: "q3");
        userData.setValue(data!.lat, forKey: "lat");
        userData.setValue(data!.long, forKey: "long");
        
        do { // saving the entity
            try managedContext.save();
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)");
        }
    }

}
