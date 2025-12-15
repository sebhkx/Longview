//
//  AppDelegate.swift
//  Thumbs
//
//  Created by Sebastian Hong on 15/12/25.
//
import Cocoa
import UniformTypeIdentifiers

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    let userDefaultsKey = "LastOpenedDirectory"

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Show file picker on launch
        openImageWithFilePicker()
        // Setup proper menu bar
        setupMenu()
    }

    // MARK: - File Picker
    func openImageWithFilePicker() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.png, .jpeg, .tiff, .gif, .heic]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false

        // Restore last opened directory
        if let lastDir = UserDefaults.standard.string(forKey: userDefaultsKey) {
            panel.directoryURL = URL(fileURLWithPath: lastDir)
        }

        // Make the panel appear in front of all windows
        panel.level = .modalPanel
        panel.makeKeyAndOrderFront(nil)

        panel.begin { [weak self] response in
            guard let self = self else { return }
            if response == .OK, let url = panel.url {
                // Save directory for next time
                UserDefaults.standard.set(url.deletingLastPathComponent().path, forKey: self.userDefaultsKey)
                self.openImage(url: url)
            }
        }
    }

    func openImage(url: URL) {
        guard let image = NSImage(contentsOf: url) else { return }
        let windowController = ImageWindowController(image: image)
        windowController.showWindow(nil)
    }

    // MARK: - Menu Bar
    func setupMenu() {
        let mainMenu = NSMenu(title: "MainMenu")
        NSApp.mainMenu = mainMenu

        // 1️⃣ App menu (top-left, standard macOS behavior)
        let appMenuItem = NSMenuItem()
        mainMenu.addItem(appMenuItem)
        let appMenu = NSMenu()
        appMenuItem.submenu = appMenu

        // Quit item in App menu
        let quitItem = NSMenuItem(
            title: "Quit \(Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "")",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        )
        appMenu.addItem(quitItem)

        // 2️⃣ File menu
        let fileMenuItem = NSMenuItem(title: "File", action: nil, keyEquivalent: "")
        mainMenu.addItem(fileMenuItem)
        let fileMenu = NSMenu(title: "File")
        fileMenuItem.submenu = fileMenu

        // Open… menu item
        let openItem = NSMenuItem(title: "Open…", action: #selector(openMenuAction), keyEquivalent: "o")
        openItem.target = self
        fileMenu.addItem(openItem)
    }

    @objc func openMenuAction() {
        openImageWithFilePicker()
    }

    // Terminate after last window closed
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
