//
//  ViewController.swift
//  PixelsNews
//
//  Created by Berkay Sancar on 12.05.2022.
//

import UIKit
import CoreData

class SelectTopicsViewController: UIViewController {
    
    @IBOutlet weak var businessButton: UIButton!
    @IBOutlet weak var entertainmentButton: UIButton!
    @IBOutlet weak var generalButton: UIButton!
    @IBOutlet weak var healthButton: UIButton!
    @IBOutlet weak var scienceButton: UIButton!
    @IBOutlet weak var sportButton: UIButton!
    @IBOutlet weak var technologyButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        businessButton.setTitle("Follow", for: .normal)
        entertainmentButton.setTitle("Follow", for: .normal)
        generalButton.setTitle("Follow", for: .normal)
        healthButton.setTitle("Follow", for: .normal)
        scienceButton.setTitle("Follow", for: .normal)
        sportButton.setTitle("Follow", for: .normal)
        technologyButton.setTitle("Follow", for: .normal)
        
        businessButton.addTarget(self, action: #selector(bussinesButtonTapped), for: .touchUpInside)
        entertainmentButton.addTarget(self, action: #selector(entertaintmentButtonTapped), for: .touchUpInside)
        generalButton.addTarget(self, action: #selector(generalButtonTapped), for: .touchUpInside)
        healthButton.addTarget(self, action: #selector(healthButtonTapped), for: .touchUpInside)
        scienceButton.addTarget(self, action: #selector(scienceButtonTapped), for: .touchUpInside)
        sportButton.addTarget(self, action: #selector(sportButtonTapped), for: .touchUpInside)
        technologyButton.addTarget(self, action: #selector(technologyButtonTapped), for: .touchUpInside)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchRequestForButtonStatus()  //if topics in CoreData, button status update.
        
    }
    
    // -------- COREDATA: SAVETOPIC && DELETETOPIC && FETCHTOPIC --------
    
    func saveTopic(name: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let SelectedTopics = NSEntityDescription.insertNewObject(forEntityName: "SelectedTopics", into: context)
        
        SelectedTopics.setValue(name, forKey: "name")
        
        do {
            try context.save()
            print("\(name) saved.")
        } catch {
            print("\(name) not saved: \(error.localizedDescription)")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataEntered"), object: nil)
    }
    
    func deleteTopic(name: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SelectedTopics")
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let topics = result.value(forKey: "name") as? String {
                        
                        if topics == name {
                            
                            context.delete(result)
                            
                            do {
                                
                                try context.save()
                                print("\(name) deleted and saved")
                                
                            }catch {
                                print("After delete operation saveing error \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
            
        } catch {
            print("error fetchRequest: \(error.localizedDescription)")
        }
    }
    
    func fetchRequestForButtonStatus() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SelectedTopics")
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let topics = result.value(forKey: "name") as? String {
                        
                        if topics == "Business" {
                            
                            businessButton.setTitle("Unfollow", for: .normal)
                            businessButton.backgroundColor = .red
                        }
                        if topics == "Entertaintment" {
                            
                            entertainmentButton.setTitle("Unfollow", for: .normal)
                            entertainmentButton.backgroundColor = .red
                        }
                        if topics == "General" {
                            
                            generalButton.setTitle("Unfollow", for: .normal)
                            generalButton.backgroundColor = .red
                        }
                        if topics == "Health" {
                            
                            healthButton.setTitle("Unfollow", for: .normal)
                            healthButton.backgroundColor = .red
                        }
                        if topics == "Science" {
                            
                            scienceButton.setTitle("Unfollow", for: .normal)
                            scienceButton.backgroundColor = .red
                        }
                        if topics == "Sport" {
                            
                            sportButton.setTitle("Unfollow", for: .normal)
                            sportButton.backgroundColor = .red
                        }
                        if topics == "Technology" {
                            
                            technologyButton.setTitle("Unfollow", for: .normal)
                            technologyButton.backgroundColor = .red
                        }
                        
                    }
                }
            }
            
        } catch {
            print("error fetchRequest: \(error.localizedDescription)")
        }
        
    }
    
    // -------- BUTTON FUNCTIONS--------
    
    @objc func bussinesButtonTapped() {
        
        
        if businessButton.currentTitle == "Follow" {
            
            saveTopic(name: "Business")
            
            businessButton.setTitle("Unfollow", for: .normal)
            businessButton.backgroundColor = .red
            
        } else if businessButton.currentTitle == "Unfollow" {
            
            deleteTopic(name: "Business")
            
            businessButton.setTitle("Follow", for: .normal)
            businessButton.backgroundColor = AppColor.pixelsColor
            
        }
    
    }
    @objc func entertaintmentButtonTapped() {
        
        
        if entertainmentButton.currentTitle == "Follow" {
            
            saveTopic(name: "Entertaintment")
            
            entertainmentButton.setTitle("Unfollow", for: .normal)
            entertainmentButton.backgroundColor = .red
            
        } else if entertainmentButton.currentTitle == "Unfollow" {
            
            deleteTopic(name: "Entertaintment")
            
            entertainmentButton.setTitle("Follow", for: .normal)
            entertainmentButton.backgroundColor = AppColor.pixelsColor
            
        }
    
    }
   
    @objc func generalButtonTapped() {
        
        
        if generalButton.currentTitle == "Follow" {
            
            saveTopic(name: "General")
            
            generalButton.setTitle("Unfollow", for: .normal)
            generalButton.backgroundColor = .red
            
        } else if generalButton.currentTitle == "Unfollow" {
            
            deleteTopic(name: "General")
            
            generalButton.setTitle("Follow", for: .normal)
            generalButton.backgroundColor = AppColor.pixelsColor
            
        }
    
    }
    
    @objc func healthButtonTapped() {
        
        
        if healthButton.currentTitle == "Follow" {
            
            saveTopic(name: "Health")
            
            healthButton.setTitle("Unfollow", for: .normal)
            healthButton.backgroundColor = .red
            
        } else if healthButton.currentTitle == "Unfollow" {
            
            deleteTopic(name: "Health")
            
            healthButton.setTitle("Follow", for: .normal)
            healthButton.backgroundColor = AppColor.pixelsColor
            
        }
    
    }
    
    @objc func scienceButtonTapped() {
    
        
        if scienceButton.currentTitle == "Follow" {
            
            saveTopic(name: "Science")
            
            scienceButton.setTitle("Unfollow", for: .normal)
            scienceButton.backgroundColor = .red
            
        } else if scienceButton.currentTitle == "Unfollow" {
            
            deleteTopic(name: "Science")
            
            scienceButton.setTitle("Follow", for: .normal)
            scienceButton.backgroundColor = AppColor.pixelsColor
            
        }
    
    }
    
    @objc func sportButtonTapped() {
        
        if sportButton.currentTitle == "Follow" {
            
            saveTopic(name: "Sport")
            
            sportButton.setTitle("Unfollow", for: .normal)
            sportButton.backgroundColor = .red
            
        } else if sportButton.currentTitle == "Unfollow" {
            
            deleteTopic(name: "Science")
            
            sportButton.setTitle("Follow", for: .normal)
            sportButton.backgroundColor = AppColor.pixelsColor
            
        }
    
    }
    
    @objc func technologyButtonTapped() {
        
        
        if technologyButton.currentTitle == "Follow" {
            
            saveTopic(name: "Technology")
            
            technologyButton.setTitle("Unfollow", for: .normal)
            technologyButton.backgroundColor = .red
            
        } else if technologyButton.currentTitle == "Unfollow" {
            
            deleteTopic(name: "Technology")
            
            technologyButton.setTitle("Follow", for: .normal)
            technologyButton.backgroundColor = AppColor.pixelsColor
            
        }
    
    }
    
    @IBAction func didTapContinueButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toHomeVC", sender: nil)
        
    }
    
    
}

