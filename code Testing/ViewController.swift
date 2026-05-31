//
//  ViewController.swift
//  code Testing
//
//  Created by Manoj Singh Kushwaha on 5/30/26.
//

import UIKit
// Delegate pattern
protocol BirdsFlying: AnyObject {
    func birdsDidStartFlying(name: String)
}

class ViewController: UIViewController, BirdsFlying {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let crow = Crow()
        let controller = Bird(bird: crow)
        controller.delegate = self
        controller.makeFly()
        
        BirdSanctuary.shared.birds.append(crow)
        print("Birds are: \(BirdSanctuary.shared.birds.count)")
    }

    func birdsDidStartFlying(name: String) {
        print("bird started flying is: \(name)")
    }
}

// Dependency Inversion pattern
protocol Flyable {
    var name:String{get}
    func fly()
}

class Crow: Flyable {
    let name = "Crow"

    func fly() {
        print("Crow is flying")
    }
}

class Eagle: Flyable {
    let name = "Eagle"
    func fly() {
        print("Eagle is flying higher..")
    }
}

class Bird {
    let bird: Flyable
    weak var delegate:BirdsFlying?
    // Dependency Injection(constructor)
    init(bird: Flyable) {
        self.bird = bird
    }
    
    func makeFly() {
        bird.fly()
        delegate?.birdsDidStartFlying(name: bird.name)
    }
}

// Singleton pattern
class BirdSanctuary {
    static let shared = BirdSanctuary()
    var birds: [Flyable] = []
    private init() {}
}
