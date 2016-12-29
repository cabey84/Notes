//
//  NotesDetailViewController.swift
//  Notes
//
//  Created by Chandi Abey  on 8/19/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class NotesDetailViewController: UIViewController, UITextViewDelegate {

    //optional that will grab the value coming in from the source tableViewController note 
    var note: Notes?
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //unwrapping the optional, if we receive a note from one of the table cells, then update the bodytext of the view
        if let note = note {
            self.bodyTextView.text = note.bodyText
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        //2 things can happen when the save button is pressed- either saving a brand new entry in which case we will need to create a new instance of type Note OR we are editing an existing note that was passed in from the tableViewCell
        
        //in the event there is existing info in the table view cell and we are trying to update it. this means something was passed into the note variable above which would have been done by selecting one of the cells triggered by the segue
        if let note = self.note {
            //whatever text was coming from that tableView cell of the source controller should now be in the view of the destination VC
            note.bodyText = self.bodyTextView.text
        } else {
         //in the event this is brand new note, then we need to save it into the notes array
         let newNote = Notes(bodyText: self.bodyTextView.text)
         NotesController.sharedController.addNote(newNote)
        }
        
        
        //REMEMBER, after saving the entry, we need to dismiss the current view
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    //MARK- UITextViewDelegate
    //REMEMBER- to dismiss the keyboard when we stop typing in the text view. Add UITextviewDelegate protocol above next to class name
    func textViewShouldReturnTextView(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
