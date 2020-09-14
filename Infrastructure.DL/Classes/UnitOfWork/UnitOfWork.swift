//
//  UnitOfWork.swift
//  Infrastructure.Core
//
//  Created by Ondřej Pišín on 06/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation

public protocol UnitOfWorkStorageReadable {
    func repository<TEntity: Entity, TRepository: ReadRepositoryBase<TEntity>>() -> TRepository
    func repository<TEntity: Entity, TRepository: ReadRepositoryBase<TEntity>>(for entity: TEntity.Type) -> TRepository
}

public protocol UnitOfWorkStorageWritable {
    func repository<TEntity: Entity, TRepository: RepositoryBase<TEntity>>() -> TRepository
    func repository<TEntity: Entity, TRepository: RepositoryBase<TEntity>>(for entity: TEntity.Type) -> TRepository
}

public protocol UnitOfWorkSavable {
    func save() -> ResultBase
//    func saveAsync(completion: @escaping (Result<Bool, Error>) -> ())
}

public protocol UnitOfWork {
    func write(_ block:(UnitOfWorkStorageWritable) -> ()) -> ResultBase
    func read(_ block:(UnitOfWorkStorageReadable) -> ())
    
//    func writeAsync(_ block:(UnitOfWorkStorage) -> (), completion: @escaping (Result<Bool, Error>) -> ())
    
    func readable() -> UnitOfWorkStorageReadable
    func writable() -> UnitOfWorkSavable & UnitOfWorkStorageWritable
}
