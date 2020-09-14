//
//  UnitOfWork.swift
//  Infrastructure.DL
//
//  Created by Ondřej Pišín on 04/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation
import CoreData

protocol UnitOfWorkIdentifiable {
    var id: String { get }
}

class UnitOfWorkBase: UnitOfWork, UnitOfWorkIdentifiable, UnitOfWorkSavable {
    private var register: UnitOfWorkRegister {
        return UnitOfWorkRegister.shared
    }
    
    let id: String
    let context: NSManagedObjectContext
    let queue: DispatchQueue
    
    init(_ context: NSManagedObjectContext, model: String, queue: String) {
        self.context = context
        self.id = "\(model))-\(queue)"
        self.queue = DispatchQueue(label: self.id)
    }

    @discardableResult func save() -> ResultBase {
        if !context.hasChanges {
            return ResultBase.success()
        }

        do {
            try context.save()
            return ResultBase.success()
        } catch {
            context.rollback()
            return ResultBase.failure(error)
        }
    }

    func readable() -> UnitOfWorkStorageReadable {
        return self
    }
    
    func writable() -> UnitOfWorkSavable & UnitOfWorkStorageWritable {
        return self
    }
    
    func write(_ block:(UnitOfWorkStorageWritable) -> ()) -> ResultBase {
        block(self)
        if self.register.unregister(self) {
            return self.save()
        }
        
        return ResultBase.success()
    }
    
    func read(_ block:(UnitOfWorkStorageReadable) -> ()) {
        block(self)
    }
}

extension UnitOfWorkBase: UnitOfWorkStorageReadable {
    func repository<TEntity: Entity, TRepository: ReadRepositoryBase<TEntity>>() -> TRepository {
        return ReadRepository<TEntity>(self.context) as! TRepository
    }
    
    func repository<TEntity: Entity, TRepository: ReadRepositoryBase<TEntity>>(for entity: TEntity.Type) -> TRepository {
        return ReadRepository<TEntity>(self.context) as! TRepository
    }
}

extension UnitOfWorkBase: UnitOfWorkStorageWritable {
    func repository<TEntity: Entity, TRepository: RepositoryBase<TEntity>>() -> TRepository {
        return Repository<TEntity>(self.context) as! TRepository
    }
    
    func repository<TEntity: Entity, TRepository: RepositoryBase<TEntity>>(for entity: TEntity.Type) -> TRepository {
        return Repository<TEntity>(self.context) as! TRepository
    }
}
