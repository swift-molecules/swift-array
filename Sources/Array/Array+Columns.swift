public import Array_Primitive
public import Buffer_Linear_Primitive
public import Buffer_Linear
public import Buffer
public import Index
public import Memory_Allocator
public import Memory_Allocator_Protocol
public import Memory
public import Ownership_Shared_Primitive
public import Storage
public import Cardinal
public import Tagged

extension __Array where S: ~Copyable {

    @inlinable
    public mutating func append<E: ~Copyable, Resource: Memory.Growable & ~Copyable>(
        _ element: consuming E
    )
    where S == Buffer<Storage<Memory.Allocator<Resource>>.Contiguous<E>>.Linear {
        store.append(element)
    }

    @inlinable
    public mutating func append<E>(_ element: consuming E)
    where
        S == Ownership.Shared<
            E, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear
        >
    {
        store.append(element)
    }

    @inlinable
    public mutating func append<E: ~Copyable>(_ element: consuming E)
    where
        S == Ownership.Shared<
            E, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear
        >
    {
        store.appendAssumingUnique(element)
    }
}

extension __Array where S: ~Copyable {

    @inlinable

    public mutating func removeAll<E: ~Copyable, Resource: Memory.Growable & ~Copyable>(
        keepingCapacity: Bool = false
    )
    where S == Buffer<Storage<Memory.Allocator<Resource>>.Contiguous<E>>.Linear {
        store.removeAll(keepingCapacity: keepingCapacity)
    }

    @inlinable

    public mutating func removeAll<E>(keepingCapacity: Bool = false)
    where
        S == Ownership.Shared<
            E, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear
        >
    {
        let capacity: Tagged<E, Cardinal> = keepingCapacity ? store.capacity : .zero
        self.store = Ownership.Shared(
            Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear(
                minimumCapacity: capacity
            )
        )
    }
}

extension __Array where S: ~Copyable {

    @inlinable

    public mutating func reserveCapacity<E: ~Copyable, Resource: Memory.Growable & ~Copyable>(
        _ minimumCapacity: Tagged<E, Cardinal>
    )
    where S == Buffer<Storage<Memory.Allocator<Resource>>.Contiguous<E>>.Linear {
        store.reserveCapacity(minimumCapacity)
    }

    @inlinable
    public mutating func reserveCapacity<E>(_ minimumCapacity: Tagged<E, Cardinal>)
    where
        S == Ownership.Shared<
            E, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear
        >
    {
        store.reserveCapacity(minimumCapacity)
    }

    @inlinable

    public mutating func reallocate<E: ~Copyable>(
        capacity newCapacity: Tagged<E, Cardinal>
    )
    where S == Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear {
        store.reallocate(capacity: newCapacity)
    }

    @inlinable
    public mutating func reallocate<E>(capacity newCapacity: Tagged<E, Cardinal>)
    where
        S == Ownership.Shared<
            E, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear
        >
    {
        store.reallocate(capacity: newCapacity)
    }
}

extension __Array where S: ~Copyable {

    @inlinable
    public func clone<E>() -> Self
    where S == Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear {
        Self(store: store.clone())
    }

    @inlinable
    public func clone<E>(capacity: Tagged<E, Cardinal>) -> Self
    where S == Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear {
        Self(store: store.clone(capacity: capacity))
    }
}

extension __Array where S: ~Copyable {

    @inlinable
    @_lifetime(&self)
    public mutating func mutableSpan<E: ~Copyable, Resource: Memory.Region & ~Copyable>() -> Swift.MutableSpan<E>
    where S == Buffer<Storage<Memory.Allocator<Resource>>.Contiguous<E>>.Linear {
        store.mutableSpan()
    }

    @inlinable
    public func withSpan<E, Resource: Memory.Region & ~Copyable, R, Failure: Swift.Error>(
        _ body: (Swift.Span<E>) throws(Failure) -> R
    ) throws(Failure) -> R
    where
        S == Ownership.Shared<
            E, Buffer<Storage<Memory.Allocator<Resource>>.Contiguous<E>>.Linear
        >
    {
        try store.withSpan(body)
    }

    @inlinable
    public mutating func withMutableSpan<E, Resource: Memory.Region & ~Copyable, R, Failure: Swift.Error>(
        _ body: (inout Swift.MutableSpan<E>) throws(Failure) -> R
    ) throws(Failure) -> R
    where
        S == Ownership.Shared<
            E, Buffer<Storage<Memory.Allocator<Resource>>.Contiguous<E>>.Linear
        >
    {
        try store.withMutableSpan(body)
    }
}

@_spi(Unsafe)
extension __Array where S: ~Copyable {

    @unsafe
    @inlinable
    public func withUnsafeBufferPointer<E, R, Failure: Swift.Error>(
        _ body: (UnsafeBufferPointer<E>) throws(Failure) -> R
    ) throws(Failure) -> R
    where S == Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear {
        try unsafe store.withUnsafeBufferPointer(body)
    }
}
