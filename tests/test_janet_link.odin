package test_janet_link

import "core:fmt"
import "core:c"

// Simple test to verify we can link with Janet
foreign import janet "system:janet"

@(default_calling_convention="c")
foreign janet {
    janet_init :: proc() -> c.int ---
    janet_deinit :: proc() ---
}

main :: proc() {
    fmt.println("Testing Janet library linking...")
    
    // Initialize Janet
    result := janet_init()
    if result != 0 {
        fmt.println("✗ Failed to initialize Janet")
        return
    }
    
    fmt.println("✓ Janet initialized successfully")
    
    // Clean up
    janet_deinit()
    fmt.println("✓ Janet deinitialized successfully")
    
    fmt.println("\nJanet library linking test passed!")
}