//
//  AuthServiceError.swift
//  HyTracker
//
//  Created by Jeffrey Sweeney on 3/17/24.
//

import Foundation

enum AuthServiceError: Error {
    case invalidCredentials
    case invalidEmailFormat
    
    // Catch all
    case generic
}
