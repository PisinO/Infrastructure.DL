//
//  UnitOfWorkRegister.swift
//  Infrastructure.DL
//
//  Created by Ondřej Pišín on 06/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation

class UnitOfWorkRegister {
    static let shared = UnitOfWorkRegister()
    
    typealias ReadyToSave = Bool
    
    private var referenceCount = [String: ushort]()
    
    func register<T: UnitOfWorkIdentifiable>(_ unitOfWork: T) {
        if let references = self.referenceCount[unitOfWork.id] {
            self.referenceCount[unitOfWork.id] = references + 1
        } else {
            self.referenceCount[unitOfWork.id] = 1
        }
    }
    
    /// Unregisters unit of work
    /// - Parameter unitOfWork: unitOfWork
    /// - Returns: If queue with specified id is ready to be saved
    func unregister<T: UnitOfWorkIdentifiable>(_ unitOfWork: T) -> ReadyToSave {
        guard let references = self.referenceCount[unitOfWork.id] else { return false }
        
        if references == 1 {
            self.referenceCount[unitOfWork.id] = 0
            return true
        } else {
            self.referenceCount[unitOfWork.id] = references - 1
            return false
        }
    }
}
