//
//  CloudBackupSwitchViewPresenter.swift
//  Blockchain
//
//  Created by Paulo on 31/07/2020.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import DIKit
import PlatformKit
import PlatformUIKit
import RxCocoa
import RxRelay
import RxSwift
import ToolKit

final class CloudBackupSwitchViewPresenter: SwitchViewPresenting {

    // MARK: - Types

    private typealias AccessibilityID = Accessibility.Identifier.Settings.SwitchView
    private typealias AnalyticsEvent = AnalyticsEvents.Settings

    // MARK: - Public

    private(set) lazy var viewModel: SwitchViewModel = {
        let viewModel: SwitchViewModel = .primary(accessibilityId: AccessibilityID.cloudBackup)
        viewModel.isSwitchedOnRelay
            .bindAndCatch(to: interactor.switchTriggerRelay)
            .disposed(by: disposeBag)

        viewModel.isSwitchedOnRelay
            .bindAndCatch(weak: self) { (self, value) in
                self.analyticsRecording.record(event: AnalyticsEvent.settingsCloudBackupSwitch(value: value))
            }
            .disposed(by: disposeBag)

        interactor.state
            .compactMap { $0.value }
            .map { $0.isEnabled }
            .bindAndCatch(to: viewModel.isEnabledRelay)
            .disposed(by: disposeBag)

        interactor.state
            .compactMap { $0.value }
            .map { $0.isOn }
            .bindAndCatch(to: viewModel.isOnRelay)
            .disposed(by: disposeBag)
        return viewModel
    }()

    // MARK: - Private

    private let interactor: SwitchViewInteracting
    private let analyticsRecording: AnalyticsEventRecording
    private let disposeBag = DisposeBag()

    init(appSettings: BlockchainSettings.App,
         credentialsStore: CredentialsStoreAPI,
         analyticsRecording: AnalyticsEventRecording = resolve()) {
        self.analyticsRecording = analyticsRecording
        interactor = CloudBackupSwitchViewInteractor(
            appSettings: appSettings,
            credentialsStore: credentialsStore
        )
    }
}
