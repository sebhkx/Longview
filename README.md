Phase 1 — Core Window & Image Management

1. Window basics (done in your current code)
	•	Right-aligned windows
	•	1:1 pixel scaling for images
	•	Scrollable for tall images
	•	Multiple windows supported

2. Window behavior enhancements
	•	Title bar: set window title to file name
	•	Window buttons: make sure close, minimize, zoom buttons are enabled (.titled, .closable, .miniaturizable, .resizable)
	•	Window activation: ensure new windows come to front (makeKeyAndOrderFront)

⸻

Phase 2 — Menu Bar & App Menu (here)
	•	File menu
	•	Open… (⌘O) → opens new image window
	•	Close (⌘W) → closes current window
	•	Quit (⌘Q) → closes all windows
	•	Edit menu (optional for now)
	•	Copy, paste, rotate (later)
	•	Window menu
	•	List of all open windows for easy switching
	•	Minimize/zoom management

⸻

Phase 3 — Window & Image Interactions
	•	Zooming / scaling
	•	1:1 pixel by default
	•	Fit-to-window option
	•	Optional pinch-to-zoom gestures
	•	Scrolling
	•	Already done with NSScrollView
	•	Keyboard navigation
	•	Arrow keys for multi-page images/screenshots (if you implement multi-image)

⸻

Phase 4 — File Metadata & Display
	•	Display file name in window title (already suggested)
	•	Optional: file path in status bar or window subtitle
	•	Optional: image dimensions in window (width × height pixels)

⸻

Phase 5 — Advanced Functionality
	•	Thumbnail / sidebar preview for multiple images
	•	Drag & drop: open images by dropping them onto app or window
	•	Multiple formats support: HEIC, GIF, TIFF, PSD, RAW…
	•	Editing features (optional later): rotate, crop, annotate

⸻

Phase 6 — Polishing UX
	•	Remember window positions between launches
	•	Snap to screen edges
	•	Full screen support
	•	Retina scaling awareness: ensure pixel-perfect display on all displays
	•	Smooth scrolling for very large images

⸻

Suggested architecture
	1.	AppDelegate.swift
	•	File picker, menu bar, global state
	2.	ImageWindowController.swift
	•	NSWindow management
	•	Window size/placement, right-aligned, top-edge alignment
	3.	ImageViewController.swift
	•	Scrollable NSImageView
	•	Scaling options
	4.	Optional helper classes
	•	WindowManager → track open windows, manage Window menu
	•	ImageModel → store file info, metadata, paths

Features to have:
  Reverse crop (horizontal & vertical stitch)

