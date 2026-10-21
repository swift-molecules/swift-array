public import Buffer
public import Buffer_Linear_Primitive
public import Memory
public import Memory_Allocator
public import Storage

public typealias Array<E: ~Copyable> =
    __Array<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>
