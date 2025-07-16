package test_structure

import "core:os"
import "core:fmt"
import "core:testing"

@(test)
test_project_structure :: proc(t: ^testing.T) {
    fmt.println("Testing project structure...")
    
    // Test that required directories exist
    directories := [?]string{"src", "examples", "tests"}
    
    for dir in directories {
        if !os.exists(dir) {
            testing.fail(t)
            fmt.printf("✗ Directory '%s' does not exist\n", dir)
        } else {
            fmt.printf("✓ Directory '%s' exists\n", dir)
        }
    }
    
    // Test that we can create files in each directory
    TestFile :: struct {
        dir: string,
        path: string,
    }
    
    test_files := [?]TestFile{
        {"src", "src/test_write.tmp"},
        {"examples", "examples/test_write.tmp"},
        {"tests", "tests/test_write.tmp"},
    }
    
    for test_file in test_files {
        // Try to create a test file
        handle, err := os.open(test_file.path, os.O_CREATE | os.O_WRONLY)
        if err != 0 {
            testing.fail(t)
            fmt.printf("✗ Cannot create file in '%s': %v\n", test_file.dir, err)
            continue
        }
        os.close(handle)
        
        // Clean up
        os.remove(test_file.path)
        fmt.printf("✓ Can write to directory '%s'\n", test_file.dir)
    }
}