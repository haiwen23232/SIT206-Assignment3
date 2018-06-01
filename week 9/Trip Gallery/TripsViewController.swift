//
//  TripsViewController.swift
//  Trip Gallery
//
//  Created by HANSON ZHOU on 24/4/18.
//  Copyright © 2018 HANSON ZHOU. All rights reserved.
//

import UIKit

class TripsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Trips.loadTrips(completion: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Trips.trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        let trip = Trips.getTrip(at: indexPath.row)!
        cell.textLabel?.text = trip.tripDestination
        cell.detailTextLabel?.text = trip.tripDate!.description
        cell.imageView?.image = UIImage(data: trip.img!)
        return cell
    }
    
    //Trigger the segue for the selected cell, and send the trip object to the details view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueTripDetails", sender: Trips.trips[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        //I created a segue from the call to the Trip Info and changed the identifier to segueTripDetails
        if segue.identifier == "segueTripDetails"{
            (segue.destination as! TripsDetailsViewController).trip = Trips.trips[self.tableView.indexPathForSelectedRow![1]]
        }
    }
    
    //called in the unwind segue - exit Trip Info
    @IBAction func unWindSegue(segue : UIStoryboardSegue)
    {
        self.tableView.reloadData()
    }
    
    //editing table view - tape left on the table to see
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Trips.trips.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
