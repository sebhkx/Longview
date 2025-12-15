//
//  ImageViewController.swift.swift
//  Thumbs
//
//  Created by Sebastian Hong on 15/12/25.
//
import Cocoa

class ImageViewController: NSViewController {

    let image: NSImage
    let imageView = NSImageView()
    let scrollView = NSScrollView()

    init(image: NSImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.autohidesScrollers = true
        scrollView.borderType = .noBorder
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        imageView.image = image
        imageView.imageScaling = .scaleNone
        imageView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.documentView = imageView
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func configureWindow(_ window: NSWindow) {
        guard
            let rep = image.representations.first,
            let screen = window.screen ?? NSScreen.main
        else { return }

        let scale = screen.backingScaleFactor
        let screenFrame = screen.frame  // full screen frame including menu bar

        // Image size in points
        let imageWidthPoints = CGFloat(rep.pixelsWide)
        let imageHeightPoints = CGFloat(rep.pixelsHigh)
        imageView.frame = NSRect(x: 0, y: 0, width: imageWidthPoints, height: imageHeightPoints)

        // Window content size
        let contentWidth = imageWidthPoints
        let contentHeight = min(imageHeightPoints, screenFrame.height)

        let contentRect = NSRect(origin: .zero, size: NSSize(width: contentWidth, height: contentHeight))
        let windowFrame = window.frameRect(forContentRect: contentRect)
        window.setFrame(windowFrame, display: true)

        // --- Top-right placement ---
        // Right edge: screenFrame.maxX - windowFrame.width
        // Top edge: screenFrame.maxY - windowFrame.height
        // This makes the window flush against the top-right
        let x = screenFrame.maxX - windowFrame.width
        let y = screenFrame.maxY - windowFrame.height
        window.setFrameOrigin(NSPoint(x: x, y: y))

        // Scroll to top if image is taller than window
        DispatchQueue.main.async {
            let clipView = self.scrollView.contentView
            let maxY = self.imageView.frame.height - clipView.bounds.height
            if maxY > 0 {
                clipView.scroll(to: NSPoint(x: 0, y: maxY))
                self.scrollView.reflectScrolledClipView(clipView)
            }
        }
    }
}
