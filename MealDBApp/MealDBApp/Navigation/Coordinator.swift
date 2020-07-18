//
//  Coordinator.swift
//  MealDBApp
//
//  Created by Aldrich Co on 7/18/20.
//  Copyright © 2020 Aldrich Co. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
	var parentCoordinator: CoordinatorProtocol? { get set }
    func start()
	func start(coordinator: CoordinatorProtocol)
	func didFinish(coordinator: CoordinatorProtocol)
	func removeChildCoordinators()
}

class CoordinatorBase: CoordinatorProtocol {

    var navigationController = UINavigationController()
    
	var childCoordinators = [CoordinatorProtocol]()
    
	var parentCoordinator: CoordinatorProtocol?

    func start() {
        fatalError("Start method should be implemented.")
    }

    func start(coordinator: CoordinatorProtocol) {
        self.childCoordinators += [coordinator]
        coordinator.parentCoordinator = self
        coordinator.start()
    }

    func removeChildCoordinators() {
        self.childCoordinators.forEach { $0.removeChildCoordinators() }
        self.childCoordinators.removeAll()
    }

    func didFinish(coordinator: CoordinatorProtocol) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
}
