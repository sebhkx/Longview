//
//  ImageWindowController.swift
//  Thumbs
//
//  Created by Sebastian Hong on 15/12/25.
//
import Cocoa

class ImageWindowController: NSWindowController {

    init(image: NSImage) {
        let contentVC = ImageViewController(image: image)

        // Create window
        let window = NSWindow(
            contentRect: NSRect(origin: .zero, size: image.size),
            styleMask: [.titled, .closable, .resizable, .miniaturizable],
            backing: .buffered,
            defer: false
        )


        window.contentViewController = contentVC
        window.isReleasedWhenClosed = false
        super.init(window: window)

        // Configure window size after creation
        configureWindowForImage(image: image)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureWindowForImage(image: NSImage) {
        guard let screen = NSScreen.main else { return }

        var windowSize = image.size
        let maxHeight = screen.visibleFrame.height

        // If image taller than screen, allow scrolling by setting window height = screen height
        if windowSize.height > maxHeight {
            windowSize.height = maxHeight
        }

        // Set window frame top-left aligned
        let topLeftPoint = NSPoint(
            x: screen.visibleFrame.origin.x,
            y: screen.visibleFrame.origin.y + screen.visibleFrame.height - windowSize.height
        )
        window?.setFrame(NSRect(origin: topLeftPoint, size: windowSize), display: true)
    }
}
