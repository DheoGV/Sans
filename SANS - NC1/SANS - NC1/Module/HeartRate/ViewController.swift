//
//  ViewController.swift
//  SANS - NC1
//
//  Created by Dheo Gildas Varian on 05/05/21.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    @IBOutlet weak var heartRateLbl: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    
    let healthKitStore = HKHealthStore()
    var hr: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeHealthKit()
        descLbl.isHidden = true
    }
    
    func authorizeHealthKit() {
        
        let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
        
        healthKitStore.requestAuthorization(toShare: healthKitTypes,
                                            read: healthKitTypes) { _, _ in }
        
        self.latestHeartRate()
    
    }
    
    func latestHeartRate() {
        
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else{
            return
        }
        let startDate = Calendar.current.date(byAdding: .month, value: -1,to: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { sampleType, result, error in
            guard error == nil else{
                return
            }
            let data = result![0] as! HKQuantitySample
            let unit = HKUnit(from: "count/min")
            let latestHr = data.quantity.doubleValue(for: unit)
            print("Lastest Hr \(latestHr) BPM")
            DispatchQueue.main.async {
                self.hr = Int(latestHr)
                if self.hr >= 90{
                    self.heartImage.image = UIImage(named: "marah")
                    self.descLbl.isHidden = false
                }
                self.heartRateLbl.text = "\(self.hr)"
            }
            //self.heart = "\(latestHr)"
            
            let dateFormator = DateFormatter()
            dateFormator.dateFormat = "dd/MM/yyyy hh:mm s"
            let startDate = dateFormator.string(from: data.startDate)
            let endDate = dateFormator.string(from: data.endDate)
            print("StartDate \(startDate) : EndDate \(endDate)")

        }
        
        healthKitStore.execute(query)
    }
    

    @IBAction func deepBreathAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Breath", bundle: nil)
        let deepBreathVC = storyboard.instantiateViewController(identifier: "deetBreath") as! DeepBreathViewController
        let navController = UINavigationController(rootViewController: deepBreathVC)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func countDownAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CountDown", bundle: nil)
        let countDownVC = storyboard.instantiateViewController(identifier: "CountDown") as! CountDownViewController
        let navController = UINavigationController(rootViewController: countDownVC)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func repeatMantra(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Mantra", bundle: nil)
        let repeatMantraVC = storyboard.instantiateViewController(identifier: "Mantra") as! MantraViewController
        let navController = UINavigationController(rootViewController: repeatMantraVC)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func tunesAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "RelaxingTunes", bundle: nil)
        let tunesVC = storyboard.instantiateViewController(identifier: "RelaxingTunes") as! RelaxingTunesViewController
        let navController = UINavigationController(rootViewController: tunesVC)
        self.navigationController?.present(navController, animated: true, completion: nil)
        //self.navigationController?.pushViewController(tunesVC, animated: true)
    }
    
}

