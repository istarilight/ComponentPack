//
//  BannerView.swift
//  ComponentPack
//
//  Created by Hailong Li on 12/24/18.
//  Copyright © 2018 Hailong Li. All rights reserved.
//

import UIKit

protocol Banner: class {
    func display(onParentView parent: UIView)
    func dismiss()
}

public protocol BannerDelegate: class {
    func onBannerDisplayed()
    func onBannerPressed()
    func onBannerDismissed()
}

public class SimpleButtonBannerView: UIButton {
    
    //MARK: Public var
    public struct ViewModel {
        let title: String
        let height: CGFloat
        let duration: TimeInterval
        
        public init(title: String = "", height: CGFloat = Constants.defaultHeight, duration: TimeInterval = Constants.defaultDuration) {
            self.title = title
            self.height = height
            self.duration = duration
        }
    }
    
    public enum DisplayDuration: TimeInterval {
        case long = 3
        case short = 1.5
    }
    
    public enum Constants {
        public static let defaultHeight: CGFloat = 48
        public static let defaultDuration = DisplayDuration.long.rawValue
        static let defaultAnimationSpeed: TimeInterval = 1
        static let maxTransparency: CGFloat = 0.7
    }
    
    public weak var delegate: BannerDelegate?
    
    //MARK: Private var
    private weak var parent: UIView?
    private var viewModel: ViewModel = ViewModel()
    
    //MARK: Initializers
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //No-op
    }
}

//MARK: Public
public extension SimpleButtonBannerView {
    public func apply(viewModel: ViewModel) {
        self.viewModel = viewModel
        setTitle(viewModel.title, for: .normal)
    }
}

//MARK: Private view methods
private extension SimpleButtonBannerView {
    
    func animateBeingDisplayed(withCompletion completion: ((Bool) -> Void)?) {
        alpha = 0
        UIView.animate(withDuration: Constants.defaultAnimationSpeed, animations: {
            self.transform = self.transform.translatedBy(x: 0, y: self.viewModel.height)
            self.alpha = Constants.maxTransparency
        }, completion: completion)
    }
    
    func animateBeingDismissed(withCompletion completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: Constants.defaultAnimationSpeed, animations: {
            self.transform = self.transform.translatedBy(x: 0, y: -self.viewModel.height)
            self.alpha = 0
        }, completion: completion)
    }
    
    func configureView() {
        guard let parent = parent else { return }
        removeConstraints(constraints)
        setTitleColor(.black, for: .normal)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: viewModel.height),
            topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor, constant: -viewModel.height),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0),
            trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: 0)
            ])
    }
}

//MARK: Banner
extension SimpleButtonBannerView: Banner {
    
    public func display(onParentView parent: UIView) {
        self.parent = parent
        parent.addSubview(self)
        configureView()
        animateBeingDisplayed { _ in
            self.delegate?.onBannerDisplayed()
            DispatchQueue.main.asyncAfter(deadline: .now() + self.viewModel.duration, execute: {
                self.dismiss()
            })
        }
    }
    
    public func dismiss() {
        animateBeingDismissed { _ in
            self.delegate?.onBannerDismissed()
            self.removeFromSuperview()
        }
    }
}
