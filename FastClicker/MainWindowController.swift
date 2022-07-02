//
//  MainWindowController.swift
//  FastClicker
//
//  Created by Boris Mezhibovskiy on 7/1/22.
//

import Cocoa

class MainWindowController: NSWindowController {

}
extension MainWindowController: NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
}
