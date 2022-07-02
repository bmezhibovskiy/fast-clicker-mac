//
//  ViewController.swift
//  FastClicker
//
//  Created by Boris Mezhibovskiy on 7/1/22.
//

import Cocoa
import ApplicationServices
import AppKit
import Quartz


class ViewController: NSViewController {
    var running = false
    var dEvent: CGEvent?
    var uEvent: CGEvent?

    var clickDelay: TimeInterval {
        let cps = cpsTextField.doubleValue
        return 1.0/cps

    }
    let downUpDelay = 0.005
    var numClicks = 0

    @IBOutlet weak var outputLabel: NSTextFieldCell!
    @IBOutlet weak var cpsTextField: NSTextField!

    var mouseLoc: CGPoint {
        let loc = NSEvent.mouseLocation
        let screenHeight = NSScreen.main!.frame.height
        return CGPoint(x: loc.x, y: screenHeight - loc.y)
    }

    var outputText: String {
        """
        clicks: \(numClicks)
        Press ` to toggle clicking.
        The number below is clicks per second, and can be changed.
        """
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
            if event.keyCode == 50 { //` to start/stop running
                self.running = !self.running
                self.start()
            }
        }
        start()
    }
    func start() {
        if self.running {
            self.doClick()
            numClicks += 1
            outputLabel.title = outputText
        }
    }

    func doClick() {
        self.dEvent = CGEvent(mouseEventSource: nil, mouseType: .leftMouseDown, mouseCursorPosition: mouseLoc, mouseButton: .left)
        self.uEvent = CGEvent(mouseEventSource: nil, mouseType: .leftMouseUp, mouseCursorPosition: mouseLoc, mouseButton: .left)

        self.dEvent!.post(tap: .cghidEventTap)
        DispatchQueue.main.asyncAfter(deadline: .now()+self.downUpDelay) {
            self.uEvent!.post(tap: .cghidEventTap)
            DispatchQueue.main.asyncAfter(deadline: .now()+self.clickDelay) {
                self.start()
            }
        }
    }
}

