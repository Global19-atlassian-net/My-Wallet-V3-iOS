//
//  MoneyOperatingTests.swift
//  PlatformKitTests
//
//  Created by Paulo on 17/09/2020.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import BigInt
@testable import PlatformKit
import XCTest

// Tests default implementations of MoneyOperating
final class MoneyOperatingTests: XCTestCase {

    func moneyValueUSD(_ uInt: UInt) -> MoneyValue {
        MoneyValue(amount: BigInt(uInt), currency: .fiat(.USD))
    }

    func moneyValueIQD(_ uInt: UInt) -> MoneyValue {
        MoneyValue(amount: BigInt(uInt), currency: .fiat(.IQD))
    }

    func moneyValue(_ uInt: UInt, _ currency: CurrencyType) -> MoneyValue {
        MoneyValue(amount: BigInt(uInt), currency: currency)
    }

    func testMoneyValueMultiplication() throws {
        let r = try moneyValueUSD(15_01) * moneyValueUSD(100_02)
        XCTAssertEqual(r.amount, BigInt(1_501_30))
    }

    private func divide(x: MoneyValue,
                        y: MoneyValue,
                        shouldBe result: BigInt) {
        XCTAssertEqual((try x / y).amount, BigInt(result))
    }

    // USD 2 decimal places division
    func testMoneyValueDivisionUSD() throws {
        divide(x: moneyValueUSD(0_00),
               y: moneyValueUSD(1_000_000_000_00),
               shouldBe: BigInt(0_00))
        divide(x: moneyValueUSD(0_01),
               y: moneyValueUSD(1_000_000_00),
               shouldBe: BigInt(0_00))
        divide(x: moneyValueUSD(0_01),
               y: moneyValueUSD(1_000_000_000_00),
               shouldBe: BigInt(0_00))
        divide(x: moneyValueUSD(1_00),
               y: moneyValueUSD(100_00),
               shouldBe: BigInt(0_01))
        divide(x: moneyValueUSD(1_00),
               y: moneyValueUSD(1_00),
               shouldBe: BigInt(1_00))
        divide(x: moneyValueUSD(1_00),
               y: moneyValueUSD(1_000_00),
               shouldBe: BigInt(0_00))
        divide(x: moneyValueUSD(15_01),
               y: moneyValueUSD(100_02),
               shouldBe: BigInt(0_15))
        divide(x: moneyValueUSD(38_50),
               y: moneyValueUSD(684_00),
               shouldBe: BigInt(0_05))
        divide(x: moneyValueUSD(150_01),
               y: moneyValueUSD(100_02),
               shouldBe: BigInt(1_49))
        divide(x: moneyValueUSD(385_00),
               y: moneyValueUSD(10_000_00),
               shouldBe: BigInt(0_03))
        divide(x: moneyValueUSD(385_00),
               y: moneyValueUSD(3_850_00),
               shouldBe: BigInt(0_10))
        divide(x: moneyValueUSD(1_000_000_00),
               y: moneyValueUSD(1_000_00),
               shouldBe: BigInt(1_000_00))
        divide(x: moneyValueUSD(1_000_000_000_00),
               y: moneyValueUSD(0_01),
               shouldBe: BigInt(100_000_000_000_00))
        divide(x: moneyValueUSD(1_000_000_000_00),
               y: moneyValueUSD(0_02),
               shouldBe: BigInt(50_000_000_000_00))
        divide(x: moneyValueUSD(1_000_000_000_00),
               y: moneyValueUSD(1_00),
               shouldBe: BigInt(1_000_000_000_00))
    }

    // IQD 3 decimal places division
    func testMoneyValueDivisionIQD() throws {
        divide(x: moneyValueIQD(0_000),
               y: moneyValueIQD(1_000_000_000_000),
               shouldBe: BigInt(0_000))
        divide(x: moneyValueIQD(0_010),
               y: moneyValueIQD(1_000_000_000),
               shouldBe: BigInt(0_000))
        divide(x: moneyValueIQD(0_010),
               y: moneyValueIQD(1_000_000_000_000),
               shouldBe: BigInt(0_000))
        divide(x: moneyValueIQD(1_000),
               y: moneyValueIQD(100_000),
               shouldBe: BigInt(0_010))
        divide(x: moneyValueIQD(1_000),
               y: moneyValueIQD(1_000),
               shouldBe: BigInt(1_000))
        divide(x: moneyValueIQD(1_000),
               y: moneyValueIQD(1_000_000),
               shouldBe: BigInt(0_001))
        divide(x: moneyValueIQD(15_010),
               y: moneyValueIQD(100_002),
               shouldBe: BigInt(0_150))
        divide(x: moneyValueIQD(38_500),
               y: moneyValueIQD(684_000),
               shouldBe: BigInt(0_056))
        divide(x: moneyValueIQD(150_010),
               y: moneyValueIQD(100_020),
               shouldBe: BigInt(1_499))
        divide(x: moneyValueIQD(385_000),
               y: moneyValueIQD(10_000_000),
               shouldBe: BigInt(0_038))
        divide(x: moneyValueIQD(385_000),
               y: moneyValueIQD(3_850_000),
               shouldBe: BigInt(0_100))
        divide(x: moneyValueIQD(1_000_000_000),
               y: moneyValueIQD(1_000_000),
               shouldBe: BigInt(1_000_000))
        divide(x: moneyValueIQD(1_000_000_000_000),
               y: moneyValueIQD(0_010),
               shouldBe: BigInt(100_000_000_000_000))
        divide(x: moneyValueIQD(1_000_000_000_000),
               y: moneyValueIQD(0_020),
               shouldBe: BigInt(50_000_000_000_000))
        divide(x: moneyValueIQD(1_000_000_000_000),
               y: moneyValueIQD(1_000),
               shouldBe: BigInt(1_000_000_000_000))
    }
}
