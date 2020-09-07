//
//  SimpleBuyPaymentAccountResponseMock.swift
//  PlatformKitTests
//
//  Created by Paulo on 05/02/2020.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

@testable import BuySellKit
@testable import PlatformKit

extension PaymentAccountResponse {
    static func mock(with currency: FiatCurrency, agent: PaymentAccountResponse.Agent) -> PaymentAccountResponse {
        PaymentAccountResponse(
            id: "response id",
            address: "response bank account",
            agent: agent,
            currency: currency,
            state: .active
        )
    }
}

extension CustodialBalanceResponse {
    static let fullMock = CustodialBalanceResponse(
        balances: [
            "BTC": Balance(available: "0", withdrawable: "0"),
            "BCH": Balance(available: "0", withdrawable: "0"),
            "ETH": Balance(available: "200000", withdrawable: "0"),
            "PAX": Balance(available: "0", withdrawable: "0"),
            "XLM": Balance(available: "0", withdrawable: "0"),
            "ALGO": Balance(available: "0", withdrawable: "0")
        ]
    )
}

extension PaymentAccountResponse.Agent {

    static let fullMock = PaymentAccountResponse.Agent(
        account: "agent account",
        address: "agent address",
        code: "agent code",
        country: "agent country",
        name: "agent name",
        recipient: "agent recipient",
        routingNumber: "agent routingNumber"
    )

    static let emptyMock = PaymentAccountResponse.Agent(
        account: nil,
        address: nil,
        code: nil,
        country: nil,
        name: nil,
        recipient: nil,
        routingNumber: nil
    )

    static let minimumGBPMock = PaymentAccountResponse.Agent(
        account: "agent account",
        address: nil,
        code: "agent code",
        country: nil,
        name: nil,
        recipient: "agent recipient",
        routingNumber: nil
    )

    static let minimumEURMock = PaymentAccountResponse.Agent(
        account: "agent account",
        address: nil,
        code: "agent code",
        country: nil,
        name: "agent name",
        recipient: nil,
        routingNumber: nil
    )

    static let idealEURMock = PaymentAccountResponse.Agent(
        account: "agent account",
        address: nil,
        code: "agent code",
        country: "agent country",
        name: "agent name",
        recipient: "agent recipient",
        routingNumber: nil
    )
}
