//
//  ViewController.swift
//  ComponentDemo
//
//  Created by Hailong Li on 12/24/18.
//  Copyright © 2018 Hailong Li. All rights reserved.
//

import UIKit
import ComponentPack

class ViewController: UIViewController {
    
    //MARK: Views
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.anchor(toParent: view)
        scrollView.addSubview(stackView)
        stackView.anchor(toParent: scrollView)
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [view1, view2])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var banner: SimpleButtonBannerView = {
        let banner = SimpleButtonBannerView()
        let viewModel = SimpleButtonBannerView.ViewModel(title: "Hello world")
        banner.backgroundColor = .cyan
        banner.apply(viewModel: viewModel)
        banner.delegate = self
        return banner
    }()
    
    private lazy var view1: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    
    private lazy var view2: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .green
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()
    
    //MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.bounces = true
        //TODO add other views here to test
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        banner.display(onParentView: stackView)
    }
}

//MARK: BannerDelegate
extension ViewController: BannerDelegate {
    
    //TODO set content inset
    func onBannerDisplayed() {
        scrollView.setContentOffset(CGPoint(x: 0, y: -SimpleButtonBannerView.Constants.defaultHeight), animated: true)
    }
    
    func onBannerPressed() {
        
    }
    
    func onBannerDismissed() {
        scrollView.setContentOffset(CGPoint(x: 0, y: SimpleButtonBannerView.Constants.defaultHeight), animated: true)
    }
    
}

