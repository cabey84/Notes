//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Chandi Abey  on 8/19/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    //REMEMBER: Key to making the new view appear in the table view after bodytext is saved
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return NotesController.sharedController.notesArray.count
    }

    //change the identity of the cell based on what is inputted in storyboard
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

        //before you configure the cell, where is the information located, in the array so access that array first
       let note = NotesController.sharedController.notesArray[indexPath.row]
        
        // Configure the cell...what information do you want in the cell? the text from the bodyView of the destination view controller
        cell.textLabel?.text = note.bodyText
        
        return cell
    }
    


   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Also remember to delete the object that was in the row deleted below. Otherwise the app will crash with inconsistent number in array vs. number of rows. Remember we need to access the note that was selected
            let selectedNote = NotesController.sharedController.notesArray[indexPath.row]
            
            //Use the delete funct/Users/chandiabey/Desktop/DevMountain/Day 5/ios-challenge-notes-master/Notes/Notesion defined in the model controller to delete the row
            NotesController.sharedController.deleteNote(selectedNote)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   

   
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //identify the correct segue, in this case it is the segue when you tap the cell 
        if segue.identifier == "editNoteSegue" {
            
        //REMEMBER: which cell did the user select, note that this is an optional because its possible the user doesnt select any cell
            
        // Get the new view controller using segue.destinationViewController so we can access the property in the destination VC to pass the text from the source tableVC to the destination detailVC
        if let notesDetailVC = segue.destination as? NotesDetailViewController,
            let index = tableView.indexPathForSelectedRow?.row  {

            
        // Pass the selected object to the new view controller. Make sure to create an optional property in the destination VC to grab this value
         notesDetailVC.note = NotesController.sharedController.notesArray[index]
        }
      }
    }
   

}
