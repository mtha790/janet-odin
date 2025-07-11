# TODO: Janet-Odin Binding Implementation


## 🏗️ Phase 1: Foundations

### 1.1 Project Structure
- [ ] Create folder architecture
  - [ ] `src/` - Main source code
  - [ ] `examples/` - Usage examples
  - [ ] `tests/` - Unit tests
  - [ ] `docs/` - Documentation
- [ ] Setup build system
  - [ ] `build.bat` for Windows
  - [ ] `build.sh` for Unix
  - [ ] Odin packages configuration

### 1.2 Basic C Bindings (`src/bindings.odin`)
- [ ] FFI declarations for Janet C API
  - [ ] Basic C types (`Janet`, `JanetType`, etc.)
  - [ ] Creation functions (`janet_wrap_*`)
  - [ ] Extraction functions (`janet_unwrap_*`)
  - [ ] Memory management functions
  - [ ] Runtime functions (`janet_init`, `janet_deinit`)
- [ ] Janet constants
  - [ ] Janet types (`JANET_NIL`, `JANET_BOOLEAN`, etc.)
  - [ ] Signals (`JANET_SIGNAL_OK`, `JANET_SIGNAL_ERROR`, etc.)
  - [ ] System limits

## 🎯 Phase 2: Basic Types

### 2.1 Fundamental Janet Types (`src/types.odin`)
- [ ] Main `Janet` type
  ```odin
  Janet :: struct {
      raw: bindings.CJanet,
  }
  ```
- [ ] `Janet_Type` enum
- [ ] `Janet_Tagged` union for pattern matching
- [ ] Wrapper types for each Janet type:
  - [ ] `Janet_String`
  - [ ] `Janet_Symbol` 
  - [ ] `Janet_Keyword`
  - [ ] `Janet_Buffer`
  - [ ] `Janet_Array`
  - [ ] `Janet_Tuple` 
  - [ ] `Janet_Table`
  - [ ] `Janet_Struct`
  - [ ] `Janet_Function`
  - [ ] `Janet_CFunction`
  - [ ] `Janet_Fiber`
  - [ ] `Janet_Abstract`
  - [ ] `Janet_Pointer`

### 2.2 Constructors and Accessors
- [ ] Creation functions:
  - [ ] `janet_nil() -> Janet`
  - [ ] `janet_boolean(bool) -> Janet`
  - [ ] `janet_number(f64) -> Janet`
  - [ ] `janet_string(string) -> Janet`
  - [ ] `janet_symbol(string) -> Janet`
  - [ ] `janet_keyword(string) -> Janet`
  - [ ] `janet_array() -> Janet_Array`
  - [ ] `janet_table() -> Janet_Table`
  - [ ] etc.
- [ ] Inspection functions:
  - [ ] `janet_kind(Janet) -> Janet_Type`
  - [ ] `janet_is_nil(Janet) -> bool`
  - [ ] `janet_is_truthy(Janet) -> bool`
  - [ ] `janet_len(Janet) -> Maybe(int)`

## 🔄 Phase 3: Conversions

### 3.1 Conversion System (`src/conversions.odin`)
- [ ] Error types:
  ```odin
  Janet_Error :: enum {
      NONE,
      CONVERSION_ERROR,
      WRONG_TYPE,
      OUT_OF_BOUNDS,
      // etc.
  }
  
  Conversion_Error :: struct {
      expected: Janet_Type,
      got: Janet_Type,
      message: string,
  }
  ```

### 3.2 Odin → Janet Conversions
- [ ] Generic `janet_from` interface:
  - [ ] `janet_from(bool) -> Janet`
  - [ ] `janet_from(int) -> Janet`
  - [ ] `janet_from(f64) -> Janet`
  - [ ] `janet_from(string) -> Janet`
  - [ ] `janet_from([]T) -> Janet` (to Array)
  - [ ] `janet_from(map[K]V) -> Janet` (to Table)
- [ ] Odin struct conversion:
  ```odin
  janet_from_struct :: proc(value: $T) -> Janet where T: struct
  ```

### 3.3 Janet → Odin Conversions
- [ ] Safe extraction:
  - [ ] `janet_unwrap(Janet) -> Janet_Tagged`
  - [ ] `janet_try_unwrap(Janet, $T) -> (T, Janet_Error)`
  - [ ] `janet_unwrap_or(Janet, $T, T) -> T`
  - [ ] `janet_unwrap_or_default(Janet, $T) -> T`
- [ ] To native Odin types:
  - [ ] `janet_to_bool(Janet) -> (bool, Janet_Error)`
  - [ ] `janet_to_int(Janet) -> (int, Janet_Error)`
  - [ ] `janet_to_f64(Janet) -> (f64, Janet_Error)`
  - [ ] `janet_to_string(Janet) -> (string, Janet_Error)`

## 🎮 Phase 4: Janet Client

### 4.1 Basic Client (`src/client.odin`)
- [ ] `Janet_Client` structure:
  ```odin
  Janet_Client :: struct {
      env: Maybe(Janet_Environment),
      initialized: bool,
  }
  ```
- [ ] Lifecycle:
  - [ ] `janet_client_init() -> (Janet_Client, Janet_Error)`
  - [ ] `janet_client_init_with_env() -> (Janet_Client, Janet_Error)`
  - [ ] `janet_client_destroy(^Janet_Client)`
- [ ] Code execution:
  - [ ] `janet_client_run(^Janet_Client, string) -> (Janet, Janet_Error)`
  - [ ] `janet_client_run_bytes(^Janet_Client, []u8) -> (Janet, Janet_Error)`

### 4.2 Error Handling
- [ ] Specific error types:
  ```odin
  Runtime_Error :: enum {
      ALREADY_INIT,
      ENV_NOT_INIT,
      PARSE_ERROR,
      COMPILE_ERROR,
      EXECUTION_ERROR,
  }
  ```

## 🌍 Phase 5: Environment

### 5.1 Janet Environment (`src/env.odin`)
- [ ] `Janet_Environment` structure
- [ ] Symbol management:
  - [ ] `env_add_def(^Janet_Environment, string, Janet)` (immutable)
  - [ ] `env_add_var(^Janet_Environment, string, Janet)` (mutable)
  - [ ] `env_resolve(^Janet_Environment, string) -> Maybe(Janet)`
- [ ] Native functions:
  - [ ] `Janet_Native_Proc :: proc([]Janet) -> Janet` type
  - [ ] `env_add_cfun(^Janet_Environment, string, Janet_Native_Proc)`

### 5.2 Modules
- [ ] Module system:
  - [ ] `janet_load_module(^Janet_Client, string) -> Janet_Error`
  - [ ] Support for native Odin modules
  - [ ] Macro for module declaration

## 🗑️ Phase 6: Garbage Collection

### 6.1 GC Interface (`src/gc.odin`)
- [ ] Integration with Janet GC:
  - [ ] `janet_gc_collect()`
  - [ ] `janet_gc_setinterval(int)`
  - [ ] `janet_gc_pressure() -> f64`
- [ ] Value protection:
  - [ ] `janet_gc_root(Janet) -> GC_Root`
  - [ ] `janet_gc_unroot(GC_Root)`
  - [ ] RAII pattern with `defer`

## 🛠️ Phase 7: Utilities and Macros

### 7.1 Ergonomic Macros (`src/macros.odin`)
- [ ] Value construction:
  ```odin
  janet_tuple :: proc(values: ..Janet) -> Janet_Tuple
  janet_array :: proc(values: ..Janet) -> Janet_Array  
  janet_table :: proc(pairs: ..struct{key: Janet, value: Janet}) -> Janet_Table
  ```
- [ ] Pattern matching helpers:
  ```odin
  match_janet :: proc(janet: Janet, cases: ..proc(Janet_Tagged) -> bool) -> bool
  ```

### 7.2 Utilities (`src/utils.odin`)
- [ ] Debug and inspection:
  - [ ] `janet_print(Janet)`
  - [ ] `janet_debug_info(Janet) -> string`
  - [ ] `janet_type_name(Janet_Type) -> string`
- [ ] Comparisons:
  - [ ] `janet_equals(Janet, Janet) -> bool`
  - [ ] `janet_deep_equals(Janet, Janet) -> bool`
  - [ ] `janet_compare(Janet, Janet) -> int`

## 📚 Phase 8: Examples and Tests

### 8.1 Examples (`examples/`)
- [ ] `hello_world.odin` - First contact
- [ ] `data_types.odin` - Type manipulation
- [ ] `functions.odin` - Native functions
- [ ] `module_example.odin` - Module creation
- [ ] `interactive.odin` - Simple REPL
- [ ] `embedding.odin` - Embed Janet in an app

### 8.2 Tests (`tests/`)
- [ ] Unit tests for each module
- [ ] Integration tests
- [ ] Performance benchmarks
- [ ] Memory safety tests
