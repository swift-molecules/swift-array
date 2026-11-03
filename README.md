# swift-array

Use this package when you need a growable, contiguous, index-addressed sequence whose elements may be move-only. Start from `Array<E>`, a uniquely owned heap column that holds `~Copyable` elements and copies only when you call `clone()`. Reach for `Array<E>.Shared` when copies of the array must be cheap and independent (copy-on-write), and for `Array<E>.Small<n>` when storage for up to `n` elements should start inline (`Memory.Small<n>`) instead of on the heap. Every variant is `__Array` over a different store; generic algorithms constrain on `Indexable`.

## Laws

- Copies of an `Array<E>.Shared` share storage until one of them mutates. Every mutation (subscript write, `remove(at:)`, `pop()`, `swap(at:with:)`, `drain(_:)`, `reserveCapacity(_:)`, `withMutableSpan(_:)`) first gives the mutated copy its own storage; its siblings never observe the change. `removeAll(keepingCapacity:)` installs fresh storage rather than clearing shared storage.
- `clone()` always returns an array with its own storage, including on `Array<E>.Shared`.
- `remove(at:)` preserves the relative order of the remaining elements, shifting every later element down by one.
- `drain(_:)` hands every element to the closure exactly once, first to last, and leaves the array empty.
- Each element is destroyed exactly once: when it is moved out by `pop()`, `remove(at:)` or `drain(_:)`, or when the array is destroyed.
- The subscript, `withElement(at:_:)`, `remove(at:)` and `swap(at:with:)` trap when an index is not below `count`. `element(at:)` and `element(at:offsetBy:)` return `nil` instead. `index(before:)` traps on `startIndex`. `swap(at:with:)` with equal indices does nothing and leaves shared storage shared.
- Two arrays are equal when their elements are equal in order. Capacity does not take part in equality or hashing.
- `reallocate(capacity:)` sets capacity exactly and may shrink it; `reserveCapacity(_:)` guarantees at least the requested capacity.
