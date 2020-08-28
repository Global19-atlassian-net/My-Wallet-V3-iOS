//
//  WalletBalanceCellInteractor.swift
//  Blockchain
//
//  Created by Alex McGregor on 5/5/20.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import PlatformKit

final class AccountGroupBalanceCellInteractor {
    
    let balanceViewInteractor: WalletBalanceViewInteractor
    
    init(balanceViewInteractor: WalletBalanceViewInteractor) {
        self.balanceViewInteractor = balanceViewInteractor
    }
}
