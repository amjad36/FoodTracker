//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Amjad Khan on 24/12/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {

    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample data
        loadSampleMeals()
    }
    
    // MARK: Private Methods
    
    private func loadSampleMeals() {
        
        guard let meal1 = Meal.init(name: "Caprese Salad", photo: UIImage(named: "meal1"), rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal.init(name: "Chicken and Potatoes", photo: UIImage(named: "meal2"), rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal.init(name: "Pasta with Meatballs", photo: UIImage(named: "meal3"), rating: 3) else {
            fatalError("Unable to instantiate meal3")
        }
        
        meals += [meal1, meal2, meal3]
    }
    
    
    // MARK: Action
    
    @IBAction func unwindToMealList(segue: UIStoryboardSegue) {
        
        if let sourceViewController = segue.source as? MealViewController, let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                
                // Add a new meal
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new meal", log: OSLog.default, type: .debug)
        
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    

}
