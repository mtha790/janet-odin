# TODO: Janet-Odin Binding Implementation

## Phase 1: Structure and Basic C Bindings

### 1.1 Project Structure
- [ ] Create folder structure
  - [ ] `src/` - Main source code
  - [ ] `examples/` - Usage examples
  - [ ] `tests/` - Unit tests

### 1.2 C Bindings (`src/bindings.odin`)
- [ ] FFI declarations for Janet C API
  - [ ] Basic C types (`Janet`, `JanetType`, etc.)
  - [ ] Creation functions (`janet_wrap_*`)
  - [ ] Extraction functions (`janet_unwrap_*`)
  - [ ] Memory management functions
  - [ ] Runtime functions (`janet_init`, `janet_deinit`)
- [ ] Janet constants
  - [ ] Janet types (`JANET_NIL`, `JANET_BOOLEAN`, etc.)
  - [ ] Signals (`JANET_SIGNAL_OK`, `JANET_SIGNAL_ERROR`, etc.)

## Phase 2: Janet Types in Odin

### 2.1 Fundamental Types (`src/types.odin`)
- [ ] Main `Janet` type
- [ ] `Janet_Type` enum
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

### 2.2 Constructors
- [ ] Creation functions:
  - [ ] `janet_nil() -> Janet`
  - [ ] `janet_boolean(bool) -> Janet`
  - [ ] `janet_number(f64) -> Janet`
  - [ ] `janet_string(string) -> Janet`
  - [ ] `janet_symbol(string) -> Janet`
  - [ ] `janet_keyword(string) -> Janet`
  - [ ] `janet_array() -> Janet_Array`
  - [ ] `janet_table() -> Janet_Table`

## Phase 3: Conversions

### 3.1 Odin → Janet Conversions (`src/conversions.odin`)
- [ ] `janet_from_bool(bool) -> Janet`
- [ ] `janet_from_int(int) -> Janet`
- [ ] `janet_from_f64(f64) -> Janet`
- [ ] `janet_from_string(string) -> Janet`
- [ ] `janet_from_slice([]T) -> Janet`
- [ ] `janet_from_map(map[K]V) -> Janet`

### 3.2 Janet → Odin Conversions
- [ ] `janet_to_bool(Janet) -> (bool, bool)`
- [ ] `janet_to_int(Janet) -> (int, bool)`
- [ ] `janet_to_f64(Janet) -> (f64, bool)`
- [ ] `janet_to_string(Janet) -> (string, bool)`

## Phase 4: Janet Client

### 4.1 Basic Client (`src/client.odin`)
- [ ] `Janet_Client` structure
- [ ] `janet_client_init() -> (^Janet_Client, bool)`
- [ ] `janet_client_destroy(^Janet_Client)`
- [ ] `janet_client_run(^Janet_Client, string) -> (Janet, bool)`

### 4.2 Environment (`src/env.odin`)
- [ ] `Janet_Environment` structure
- [ ] `env_set(^Janet_Environment, string, Janet)`
- [ ] `env_get(^Janet_Environment, string) -> (Janet, bool)`
- [ ] `env_add_cfun(^Janet_Environment, string, proc([]Janet) -> Janet)`

## Phase 5: GC Integration

### 5.1 GC Interface (`src/gc.odin`)
- [ ] `janet_gc_collect()`
- [ ] `janet_gc_root(Janet) -> Handle`
- [ ] `janet_gc_unroot(Handle)`

## Phase 6: Examples

### 6.1 Basic Examples (`examples/`)
- [ ] `hello_world.odin` - First program
- [ ] `data_types.odin` - Type manipulation
- [ ] `functions.odin` - Native functions
- [ ] `embedding.odin` - Embedding in Odin app