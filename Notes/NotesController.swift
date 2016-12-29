//
//  NotesController.swift
//  Notes
//
//  Created by Chandi Abey  on 8/19/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

//model controller for the Note type model
class NotesController {
    
    //to save and retrieve data, store key
    fileprivate let kStoredNote = "storedNote"
    
    //singleton of the Notes Controller
    static let sharedController = NotesController()
    
    //variable array to hold notes added and deleted, initialized to empty
    var notesArray: [Notes] = []
    
    //REMEMBER- initializing values for the array
    init() {
        loadFromPersistentData()
    }
    
    
    //method to add a note to the notes array variable above
    func addNote(_ note: Notes) {
        notesArray.append(note)
        //call the save function each time we add or delete something so this change will be saved to NSUserDefaults
        saveToPersistentData()
    }
    
    
    //method to delete a note from the notes array variable above. remember to make this an if let because indexOf returns an optional value that needs to be unwrapped
    func deleteNote(_ note: Notes) {
        if let index = notesArray.index(of: note) {
            notesArray.remove(at: index)
        }
        //call the save function each time we add or delete something so this change will be saved to NSUserDefaults
        saveToPersistentData()
    }
    
    
    //MARK- NSUserDefaults- saving and retrieving data that has been saved. Define a key above that we can use to save and retreive the data.
    func saveToPersistentData() {
        UserDefaults.standard.set(notesArray.map({$0.dictionaryRepresentation}), forKey: kStoredNote)
        
    }
    
    //REMEMBER - since we are retrieving dictionaries from a source that may or may not have the key we are looking for, it may be an optional so use a guard statement
    func loadFromPersistentData() {
        guard let notesDictionaryArray = UserDefaults.standard.object(forKey: kStoredNote) as? [[String: AnyObject]] else {
            return
        }
        //now assign what we get here to the existing notes array, go through the array of dictionaries and cast as a Note
        notesArray = notesDictionaryArray.flatMap({Notes(dictionary:$0)})
        
        
    }


    
}
