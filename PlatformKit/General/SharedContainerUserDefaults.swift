//
//  SharedContainerUserDefaults.swift
//  PlatformKit
//
//  Created by Alex McGregor on 6/18/20.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import RxCocoa
import RxSwift
import ToolKit

public final class SharedContainerUserDefaults: UserDefaults {
    
    // MARK: - Public Static
    
    public static let `default` = SharedContainerUserDefaults()
    
    // MARK: - Static
    
    static let name: String = String(describing: "group.rainydayapps.blockchain")
    
    // MARK: - Public Properties
    
    public let portfolioRelay = PublishSubject<Portfolio?>()
    
    // MARK: - Rx
    
    private var portfolioObservable: Observable<Portfolio?> {
        _ = setup
        return portfolioRelay
            .asObservable()
    }
    
    // MARK: - Setup
    
    private lazy var setup: Void = {
        portfolioObservable
            .bind(to: rx.rx_portfolio)
            .disposed(by: disposeBag)
    }()
    
    // MARK: - Types
    
    enum Keys: String {
        case portfolio
        case shouldSyncPortfolio
    }
    
    // MARK: - Private Properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    public convenience init() {
        self.init(suiteName: SharedContainerUserDefaults.name)!
    }
    
    public var portfolioSyncEnabled: Observable<Bool> {
        rx.observe(Bool.self, Keys.shouldSyncPortfolio.rawValue)
            .map { value in
                return value ?? false
            }
    }
    
    public var portfolio: Portfolio? {
        get {
            codable(Portfolio.self, forKey: Keys.portfolio.rawValue)
        }
        set {
            set(codable: newValue, forKey: Keys.portfolio.rawValue)
        }
    }
    
    public var shouldSyncPortfolio: Bool {
        get {
            return bool(forKey: Keys.shouldSyncPortfolio.rawValue)
        }
        set {
            set(newValue, forKey: Keys.shouldSyncPortfolio.rawValue)
        }
    }
    
    public func reset() {
        shouldSyncPortfolio = false
    }
}

extension Reactive where Base: SharedContainerUserDefaults {
    public var portfolioSyncEnabled: Binder<Bool> {
        return Binder(base) { container, payload in
            container.shouldSyncPortfolio = payload
        }
    }
    
    public var rx_portfolio: Binder<Portfolio?> {
        return Binder(base) { container, payload in
            container.portfolio = payload
        }
    }
}