import QtQuick
import Quickshell
import "./flare" as FlareModule

// Omarchy entry point for the "service" kind. Flare owns its own per-screen
// PanelWindow (edge reveal, layer-shell surface, mask) so there is nothing
// for omarchy-shell to summon or position — FlareHost just needs to exist
// once, which is exactly what a headless service is for.
Scope {
    FlareModule.FlareHost {}
}
