//
//  VisionObjectRecognitionView.swift
//  BreakfastFinder
//
//  Created by Serhii Liamtsev on 8/4/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit

final class VisionObjectRecognitionView: UIView {
    
    private(set) var previewView: UIView = UIView()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    // MARK: - Private
    private func setupLayout() {
        addSubview(previewView)
        
        previewView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            previewView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            previewView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
