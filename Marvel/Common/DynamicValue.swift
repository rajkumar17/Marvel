//
//  DynamicValue.swift
//  Marvel
//
//  Created by Rajkumar on 09/02/22.
//

import UIKit

// The completionHandler for the observer of the model
typealias CompletionHandler = (() -> Void)

// Generic class to handle all model observer
class DynamicValue<T> {
    
    //MARK: - Variable and Constant
    var value: T {
        didSet {
            self.notify()
        }
    }
    // A reference for all observers for the value
    private var observers = [String: CompletionHandler]()
    
    //MARK: - Init
    init(_ value: T) {
        self.value = value
    }
    
    // Notify all observers
    private func notify() {
        observers.forEach({$0.value()})
    }
    
    //MARK: - Public Methods
    
    // A method to add a new observer
    // Parameters:
        //observer: the object to be observed
    // completionHandler: a reference for the observer
    func addObserver(_ observer: AnyObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    // A method to add a new observer
    // Parameters:
        //observer: the object to be observed
    // completionHandler: a reference for the observer
    public func addAndNotify(observer: AnyObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }

    // Remover all observers
    deinit {
        observers.removeAll()
    }
}
