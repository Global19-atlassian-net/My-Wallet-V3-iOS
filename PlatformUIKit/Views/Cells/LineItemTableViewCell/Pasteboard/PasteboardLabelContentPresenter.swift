//
//  PasteboardLabelContentPresenter.swift
//  PlatformUIKit
//
//  Created by AlexM on 1/28/20.
//  Copyright © 2020 Blockchain Luxembourg S.A. All rights reserved.
//

import PlatformKit
import RxRelay
import RxSwift

public final class PasteboardLabelContentPresenter: LabelContentPresenting {
    
    public typealias PresentationState = LabelContent.State.Presentation
    typealias PresentationDescriptors = LabelContent.Value.Presentation.Content.Descriptors
    
    public let stateRelay = BehaviorRelay<PresentationState>(value: .loading)
    public var state: Observable<PresentationState> {
        stateRelay.asObservable()
    }
    
    // MARK: - Private Accessors
    
    public let interactor: LabelContentInteracting
    private let disposeBag = DisposeBag()
    
    init(interactor: PasteboardLabelContentInteracting,
         descriptors: PresentationDescriptors) {
        self.interactor = interactor
        let successDescriptors: PresentationDescriptors = .success(
            fontSize: descriptors.fontSize,
            accessibilityId: descriptors.accessibilityId
        )
        let descriptorObservable: Observable<PresentationDescriptors> = interactor.isPasteboarding
            .map { $0 ? successDescriptors : descriptors }
            .flatMap { Observable.just($0) }
        
        Observable
            .combineLatest(interactor.state, descriptorObservable)
            .map { .init(with: $0.0, descriptors: $0.1) }
            .bindAndCatch(to: stateRelay)
            .disposed(by: disposeBag)
    }
}
