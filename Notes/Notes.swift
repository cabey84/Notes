//
//  Notes.swift
//  Notes
//
//  Created by Chandi Abey  on 8/19/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

//class model of type Notes that conforms to the Equatable protocol defined below 
class Notes: Equatable {
    
    
    fileprivate let kBodyText = "bodyText"
    
    //create a variable that holds the text typed in notes
    var bodyText: String
    
    //initialize the bodyText variable
    init(bodyText: String) {
        self.bodyText = bodyText
    }
    

//create computed property to be used to convert Note type to dictionary reference in order to save to NSUserDefaults
//also create a private key above to prevent from typing errors when dealing with keys
    
    
    var dictionaryRepresentation: [String: AnyObject] {
        return [kBodyText: bodyText as AnyObject]
    }

//create failable initializer to convert a dictionary type back to a type Note when we retrieve it from NSUserDefaults. it takes an array of dictionaries and returns the note
    
    init?(dictionary: [String: AnyObject]) {
        guard let bodyText = dictionary[kBodyText] as? String
 
        else {return nil }
        
        self.bodyText = bodyText
    }
}

//create an equatable function b/c we will be using NSUserDefaults to save data and will also need this to access the indexOf function

func ==(lhs: Notes, rhs: Notes) -> Bool {
 return lhs.bodyText == rhs.bodyText

}

