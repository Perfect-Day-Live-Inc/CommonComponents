//
//  MessagesConstants.swift
//  Scholarship
//
//  Created by MacBook Retina on 10/26/17.
//  Copyright © 2017 PNC. All rights reserved.
//

import Foundation

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This class contains all msgs which are using in this application
///it contains Error msgs,
///Success msgs
///Warning msgs etc

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

class MessagesConstants{
    private init(){}
    
    static let postCreatedSuccess = "Post created successfully!"
    static let thoughtCreatedSuccess = "Reflection created successfully!"
    static let thoughtEditedSuccess = "Reflection edited successfully!"
    static let unAuthenticatedError = "Your account recently signed inn from another device, to proceed please signin again."
    static let wentWrongError = "Something went wrong, Please try again!"
    static let internetError = "Please check your internet connection"
    
    static let registeredSuccessfully = "Registered Successfully!"
    
    static let passwordLimitationsMsg = "The password must have at least 8 characters and should contain each of the following: uppercase letters, lowercase letters, numbers and symbols."
    
    //CHANGE PASSWORD VC
    static let updatedPassword = "Password updated successfully"
    static let passwordDoesntMatch = "Password does not match"
    static let oldPassword = "Please enter old Password"
    static let newPassword = "Please enter new Password"
    static let confirmPassword = "Please enter confirm Password"
    
    //FAQ
    static let noFAQ = "There are no FAQs"
    
    //Edit Profile
    static let updatedProfileSuccess = "Profile updated successfully"
    static let emptyFirstName = "Please enter first name"
    static let emptyLastName = "Please enter last name"
    static let emptyEmailNumber = "Please enter email address"
    static let emptyNickName = "Please enter nick name"
    
    //Phone Number Picker VC
    static let invalidNumber = "Please enter valid number"
    
    //Verification Code
    static let enterPin = "Please enter Pin"
    
    
    //invalid email
    static let invalidEmail = "Please enter valid email"
    
    //SIGN UP
    static let emailEmpty = "Please enter email"
    static let emptyPassword = "Please enter password"
    static let passMustBe6Digits = "Password must contains at least 8 characters"
    
}
