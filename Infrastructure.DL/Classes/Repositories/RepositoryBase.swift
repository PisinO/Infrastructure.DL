//
//  Repository.swift
//  Infrastructure.Core
//
//  Created by Ondřej Pišín on 06/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation

public protocol CrudRepository {
    associatedtype TEntity
    
    func create() -> EntityResult<TEntity>
    func update(_ entity: TEntity, with changes: [String: Any]) -> ResultBase
    func delete(id: CVarArg) -> ResultBase
}

public protocol FetchRepository {
    associatedtype TEntity
    
    func fetch(id: CVarArg) -> EntityResult<TEntity>
    func fetch(parameters: FetchParameters) -> EntityResult<[TEntity]>
}

open class ReadRepositoryBase<TEntity: DBEntity>: FetchRepository {
    public init() {}
    
    open func fetch(id: CVarArg) -> EntityResult<TEntity> {
        fatalError("Function called in abstract class, not implemented")
    }
    
    open func fetch(parameters: FetchParameters) -> EntityResult<[TEntity]> {
        fatalError("Function called in abstract class, not implemented")
    }
}

open class RepositoryBase<TEntity: DBEntity>: CrudRepository, FetchRepository {
    public init() {}
    
    open func create() -> EntityResult<TEntity> {
        fatalError("Function called in abstract class, not implemented")
    }
    
    open func update(_ entity: TEntity, with changes: [String : Any]) -> ResultBase {
        fatalError("Function called in abstract class, not implemented")
    }
    
    open func delete(id: CVarArg) -> ResultBase {
        fatalError("Function called in abstract class, not implemented")
    }
    
    open func fetch(id: CVarArg) -> EntityResult<TEntity> {
        fatalError("Function called in abstract class, not implemented")
    }
    
    open func fetch(parameters: FetchParameters) -> EntityResult<[TEntity]> {
        fatalError("Function called in abstract class, not implemented")
    }
}
