//
//  ServiceError.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

enum ServiceError: Error, Equatable {
    case urlDoesNotExist
    case noDataFound
    case serviceFailed(ErrorResponse)
}
