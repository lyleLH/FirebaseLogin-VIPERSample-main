//
//  CanvasInteractor.swift
//  
//
//  Created by Tom.Liu on .
//
//

import Foundation

protocol CanvasInteractorProtocol {
}

class CanvasInteractor: CanvasInteractorProtocol {
    weak var presenter: CanvasPresenterProtocol?
}
