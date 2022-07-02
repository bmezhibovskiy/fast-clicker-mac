//
//  MainWindowController.swift
//  FastClicker
//
//  Created by Boris Mezhibovskiy on 7/1/22.
//

import Cocoa

class MainWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.level = .init(rawValue: Int(CGShieldingWindowLevel()) + 1)
    }
}
extension MainWindowController: NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
}
