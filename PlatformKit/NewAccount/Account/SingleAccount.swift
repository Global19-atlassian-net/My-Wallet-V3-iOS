//
//  SingleAccount.swift
//  PlatformKit
//
//  Created by Paulo on 03/08/2020.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import RxSwift
import ToolKit

public enum SingleAccountType: Hashable {
    case custodial(CustodialAccountType)
    case nonCustodial
    
    public enum CustodialAccountType: String, Hashable {
        case trading
        case savings
        
        var isTrading: Bool {
            self == .trading
        }
        
        var isSavings: Bool {
            self == .savings
        }
    }
    
    public var isTrading: Bool {
        switch self {
        case .nonCustodial:
            return false
        case .custodial(let type):
            return type.isTrading
        }
    }
    
    public var isSavings: Bool {
        switch self {
        case .nonCustodial:
            return false
        case .custodial(let type):
            return type.isSavings
        }
    }
    
    public var description: String {
        switch self {
        case .custodial(let type):
            return "custodial.\(type.rawValue)"
        case .nonCustodial:
            return "noncustodial"
        }
    }
}

/// A BlockchainAccount that represents a single account, opposed to a collection of accounts.
public protocol SingleAccount: BlockchainAccount {

    var currencyType: CurrencyType { get }
    var accountType: SingleAccountType { get }
    var isDefault: Bool { get }
    var receiveAddress: Single<ReceiveAddress> { get }
    var sendState: Single<SendState> { get }

    func createSendProcessor(address: ReceiveAddress) -> Single<SendProcessor>
}

public extension SingleAccount {
    var receiveAddress: Single<ReceiveAddress> {
        .error(ReceiveAddressError.notSupported)
    }

    var sendState: Single<SendState> {
        .just(.notSupported)
    }

    func createSendProcessor(address: ReceiveAddress) -> Single<SendProcessor> {
        unimplemented()
    }
}
