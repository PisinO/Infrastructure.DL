//
//  ContextProvider.swift
//  Infrastructure.DL
//
//  Created by Ondřej Pišín on 04/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation
import CoreData

struct DataModelLocationFail: LocalizedError {
    var errorDescription: String? {
        return "Unable to locate Core Data model"
    }
}

class ContextProvider {
    // Returns the current container view context
    var context: NSManagedObjectContext {
        return self.persistentContainer!.viewContext
    }
    
    var datamodelName: String {
        return self.initializer.datamodelName
    }
    
    // The persistent container
    lazy private var persistentContainer: PersistentContainer? = {
        guard let modelURL = self.initializer.datamodelBundle.url(forResource: self.datamodelName, withExtension: "momd"), let model = NSManagedObjectModel(contentsOf: modelURL) else {
            self.initializer.onFinishedLoading?(DataModelLocationFail())
            return nil
        }
        
        let pc = PersistentContainer(name: self.datamodelName, managedObjectModel: model)

        pc.loadPersistentStores() { (description, error) in
            self.initializer.onFinishedLoading?(error)
        }
        
        return pc
    }()
    
    private let initializer: ContextInitializer
    
    init(_ initializer: ContextInitializer) {
        self.initializer = initializer
    // Force initialize db context while app is starting
        _ = self.persistentContainer
    }
    
    // Creates a context for background work
    func createBackgroundContext() -> NSManagedObjectContext {
        let context = persistentContainer!.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }
}
