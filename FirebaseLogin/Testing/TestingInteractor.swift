//
//  TestingInteractor.swift
//  
//
//  Created by Tom.Liu on .
//
//

import Foundation

protocol TestingInteractorProtocol {
}

class TestingInteractor: TestingInteractorProtocol {
    weak var presenter: TestingPresenterProtocol?
}
