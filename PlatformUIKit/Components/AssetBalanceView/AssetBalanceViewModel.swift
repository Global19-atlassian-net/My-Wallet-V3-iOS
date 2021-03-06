//
//  AssetBalanceViewModel.swift
//  PlatformUIKit
//
//  Created by Alex McGregor on 9/29/20.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import Localization
import PlatformKit

public struct AssetBalanceViewModel {
    
    // MARK: - State Aliases
    
    public struct State {
        /// The state of the `AssetBalance` interactor and presenter
        public typealias Interaction = LoadingState<Value.Interaction>
        public typealias Presentation = LoadingState<Value.Presentation>
    }
    
    // MARK: - Value Namespace
    
    public struct Value {
        
        // MARK: - Interaction
        
        /// The interaction value of asset
        public struct Interaction {
            /// The wallet's balance in fiat
            let fiatValue: MoneyValue
            /// The wallet's balance in crypto
            let cryptoValue: MoneyValue
            /// The wallet's pending balance in crypto
            let pendingValue: MoneyValue
            
            init(fiatValue: MoneyValue,
                 cryptoValue: MoneyValue,
                 pendingValue: MoneyValue) {
                self.fiatValue = fiatValue
                self.cryptoValue = cryptoValue
                self.pendingValue = pendingValue
            }
        }
        
        // MARK: - Presentation
        
        public struct Presentation {
            
            private typealias AccessibilityId = Accessibility.Identifier.Dashboard.AssetCell
            
            // MARK: - Properties
            
            /// The balance in fiat
            let fiatBalance: LabelContent
            
            /// The balance in crypto
            let cryptoBalance: LabelContent
            
            /// The visibility state of the `Pending` balance
            let pendingBalanceVisibility: Visibility
            
            /// The pending balance in crypto. This value is `.none`
            /// should the user's pending balance be `.zero`
            let pendingBalance: LabelContent
            
            /// Descriptors that allows customized content and style
            public struct Descriptors {
                let fiatFont: UIFont
                let fiatTextColor: UIColor
                let fiatAccessibility: Accessibility
                let cryptoFont: UIFont
                let cryptoTextColor: UIColor
                let pendingTextColor: UIColor
                let cryptoAccessibility: Accessibility
                
                public init(fiatFont: UIFont,
                            fiatTextColor: UIColor,
                            fiatAccessibility: Accessibility,
                            cryptoFont: UIFont,
                            cryptoTextColor: UIColor,
                            pendingTextColor: UIColor = .mutedText,
                            cryptoAccessibility: Accessibility) {
                    self.fiatFont = fiatFont
                    self.fiatTextColor = fiatTextColor
                    self.fiatAccessibility = fiatAccessibility
                    self.cryptoFont = cryptoFont
                    self.cryptoTextColor = cryptoTextColor
                    self.cryptoAccessibility = cryptoAccessibility
                    self.pendingTextColor = pendingTextColor
                }
            }
            
            // MARK: - Setup
            
            public init(with value: Interaction, descriptors: Descriptors) {
                fiatBalance = LabelContent(
                    text: value.fiatValue.toDisplayString(includeSymbol: true, locale: .current),
                    font: descriptors.fiatFont,
                    color: descriptors.fiatTextColor,
                    accessibility: descriptors.fiatAccessibility.with(idSuffix: value.cryptoValue.currencyType.code)
                )
                
                if value.cryptoValue == value.fiatValue {
                    cryptoBalance = .empty
                } else {
                    cryptoBalance = LabelContent(
                        text: value.cryptoValue.toDisplayString(includeSymbol: true, locale: .current),
                        font: descriptors.cryptoFont,
                        color: descriptors.cryptoTextColor,
                        accessibility: descriptors.cryptoAccessibility.with(idSuffix: value.cryptoValue.currencyType.code)
                    )
                }
                pendingBalanceVisibility = value.pendingValue.isZero ? .hidden : .visible
                pendingBalance = LabelContent(
                    text: value.pendingValue.toDisplayString(includeSymbol: true, locale: .current),
                    font: descriptors.cryptoFont,
                    color: descriptors.pendingTextColor,
                    accessibility: descriptors.cryptoAccessibility.with(idSuffix: value.cryptoValue.currencyType.code)
                )
                
            }
        }
    }
}

public extension AssetBalanceViewModel.Value.Presentation.Descriptors {
    typealias Descriptors = AssetBalanceViewModel.Value.Presentation.Descriptors
    
    static func `default`(
        cryptoAccessiblitySuffix: String,
        fiatAccessiblitySuffix: String
    ) -> Descriptors {
        Descriptors(
            fiatFont: .main(.semibold, 16.0),
            fiatTextColor: .dashboardFiatPriceTitle,
            fiatAccessibility: .init(
                id: .value(fiatAccessiblitySuffix)
            ),
            cryptoFont: .main(.medium, 14.0),
            cryptoTextColor: .descriptionText,
            cryptoAccessibility: .init(
                id: .value(cryptoAccessiblitySuffix)
            )
        )
    }
    
    static func muted(
        cryptoAccessiblitySuffix: String,
        fiatAccessiblitySuffix: String
    ) -> Descriptors {
        Descriptors(
            fiatFont: .main(.medium, 16.0),
            fiatTextColor: .mutedText,
            fiatAccessibility: .init(
                id: .value(fiatAccessiblitySuffix)
            ),
            cryptoFont: .main(.medium, 14.0),
            cryptoTextColor: .mutedText,
            cryptoAccessibility: .init(
                id: .value(cryptoAccessiblitySuffix)
            )
        )
    }
    
    static func activity(
        cryptoAccessiblitySuffix: String,
        fiatAccessiblitySuffix: String
    ) -> Descriptors {
        Descriptors(
            fiatFont: .main(.semibold, 16.0),
            fiatTextColor: .textFieldText,
            fiatAccessibility: .init(
                id: .value(fiatAccessiblitySuffix)
            ),
            cryptoFont: .main(.medium, 14.0),
            cryptoTextColor: .descriptionText,
            cryptoAccessibility: .init(
                id: .value(cryptoAccessiblitySuffix)
            )
        )
    }
}
