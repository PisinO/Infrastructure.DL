//
//  UnitOfWorkProvider.swift
//  Infrastructure.DL
//
//  Created by Ondřej Pišín on 04/09/2020.
//  Copyright © 2020 Ondřej Pišín. All rights reserved.
//

import Foundation

enum ContextType: String {
    case main
    case background
}

open class UnitOfWorkProviderBase: UnitOfWorkProvider {
    
    private var register: UnitOfWorkRegister {
        return UnitOfWorkRegister.shared
    }
    
    private let contextProvider: ContextProvider
    
    public init(_ initializer: ContextInitializer) {
        self.contextProvider = ContextProvider(initializer)
    }
    
    public var main: UnitOfWork {
        let uow = UnitOfWorkBase(self.contextProvider.context, model: contextProvider.datamodelName, queue: ContextType.main.rawValue)
        self.register.register(uow)
        return uow
    }
    
    public var background: UnitOfWork {
        let uow = UnitOfWorkBase(self.contextProvider.createBackgroundContext(), model: contextProvider.datamodelName, queue: ContextType.background.rawValue)
        self.register.register(uow)
        return uow
    }
}
