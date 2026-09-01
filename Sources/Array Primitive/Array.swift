public import Buffer_Linear_Primitive
public import Buffer
public import Index
public import Memory_Allocator
public import Memory_Allocator_Protocol
public import Memory
public import Ownership_Shared_Primitive
public import Storage

@_documentation(visibility: public)
@frozen
public struct __Array<S: ~Copyable>: ~Copyable {

    @usableFromInline
    package var store: S

    @inlinable
    public init(store: consuming S) {
        self.store = store
    }

}

extension __Array where S: ~Copyable {

    @inlinable
    public consuming func take() -> S {
        store
    }
}

extension __Array: Copyable where S: Copyable {}

extension __Array: Sendable where S: Sendable & ~Copyable {}

extension __Array where S: ~Copyable {

    @inlinable

    public init<E: ~Copyable, Resource: Memory.Growable & ~Copyable>(
        initialCapacity: Index.Index<E>.Count = .zero
    )
    where S == Buffer<Storage<Memory.Allocator<Resource>>.Contiguous<E>>.Linear {
        self.init(store: S(minimumCapacity: initialCapacity))
    }

    @inlinable
    public init<E>(initialCapacity: Index.Index<E>.Count = .zero)
    where
        S == Ownership.Shared<
            E, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear
        >
    {
        self.init(
            store: Ownership.Shared(
                Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear(
                    minimumCapacity: initialCapacity
                )
            )
        )
    }

    @inlinable

    public init<E: ~Copyable>(initialCapacity: Index.Index<E>.Count = .zero)
    where
        S == Ownership.Shared<
            E, Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear
        >
    {
        self.init(
            store: Ownership.Shared(
                Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear(
                    minimumCapacity: initialCapacity
                )
            )
        )
    }
}
