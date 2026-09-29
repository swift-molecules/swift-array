public import Array_Primitive
public import Buffer_Linear_Primitive
public import Buffer
public import Index
public import Memory_Allocator
public import Memory
public import Storage
public import Cardinal
public import Tagged

extension __Array where S: ~Copyable {

    @inlinable

    public init<E: ~Copyable, Failure: Swift.Error>(
        capacity: Tagged<E, Cardinal>,
        initializingWith initializer: (inout Swift.OutputSpan<E>) throws(Failure) -> Void
    ) throws(Failure)
    where S == Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear {
        self.init(
            store: try Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear(
                capacity: capacity,
                initializingWith: initializer
            )
        )
    }

    @inlinable

    public mutating func append<E: ~Copyable, Failure: Swift.Error>(
        addingCapacity: Tagged<E, Cardinal>,
        initializingWith initializer: (inout Swift.OutputSpan<E>) throws(Failure) -> Void
    ) throws(Failure)
    where S == Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear {
        try store.append(
            addingCapacity: addingCapacity,
            initializingWith: initializer
        )
    }

    @inlinable
    public mutating func edit<E: ~Copyable, Failure: Swift.Error, R: ~Copyable>(
        _ body: (inout Swift.OutputSpan<E>) throws(Failure) -> R
    ) throws(Failure) -> R
    where S == Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear {
        try store.edit(body)
    }
}
