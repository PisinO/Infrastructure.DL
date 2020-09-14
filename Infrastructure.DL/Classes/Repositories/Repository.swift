//
//  Repository.swift
//  Infrastructure.DL
//
//  Created by Ondřej Pišín on 04/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation
import CoreData
import NSPredicateObjectMapper

public struct DatabaseError: Error {
    var localizedDescription: String {
        return message
    }
    
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
}

public class ReadRepository<TEntity: DBEntity>: ReadRepositoryBase<TEntity> {
    private let context: NSManagedObjectContext
    
    init(_ currentContext: NSManagedObjectContext) {
        self.context = currentContext
        super.init()
    }
    
    public override func fetch(id: CVarArg) -> EntityResult<TEntity> {
        let request = NSFetchRequest<TEntity>()
        request.predicate = TEntity.where(\TEntity.id).isEqualTo(id).predicate()
        
        var entity: TEntity?
        
        do {
            let result = try self.context.fetch(request)
            entity = result.first
        } catch {
            return EntityResult.failure(error)
        }
        
        return EntityResult.success(entity!)
    }

    public override func fetch(parameters: FetchParameters) -> EntityResult<[TEntity]> {
        let request = NSFetchRequest<TEntity>(entityName: "\(TEntity.self)")
        
        request.predicate = parameters.predicate
        request.sortDescriptors = parameters.sortDescriptors
        request.fetchLimit = parameters.limit ?? Int.max
        request.fetchOffset = parameters.offset ?? 0
        
        var entities = [TEntity]()
        
        do {
            entities = try self.context.fetch(request)
        } catch {
            return EntityResult.failure(error)
        }
        
        return EntityResult.success(entities)
    }
}

public class Repository<TEntity: DBEntity>: RepositoryBase<TEntity> {
    private let context: NSManagedObjectContext
    
    init(_ currentContext: NSManagedObjectContext) {
        self.context = currentContext
        super.init()
    }
    
    public override func create() -> EntityResult<TEntity> {
        guard let entity = NSEntityDescription.insertNewObject(forEntityName: "\(TEntity.self)", into: self.context) as? TEntity else {
            return EntityResult.failure(DatabaseError("New entity '\(TEntity.self)' couldn't be created"))
        }
        
        return EntityResult.success(entity)
    }
    
    public override func update(_ entity: TEntity, with changes: [String: Any]) -> ResultBase {
        for change in changes {
            entity.setValue(change.value, forKey: change.key)
        }
        
        return ResultBase.success()
    }

    public override func delete(id: CVarArg) -> ResultBase {
        guard let entity = self.fetch(id: id).result else { return ResultBase.failure(DatabaseError("Entity with id \(id) doesn't exist")) }
        
        self.context.delete(entity)
        
        return ResultBase.success()
    }
}
