public import Buffer_Linear_Primitive
public import Buffer
public import Memory_Allocator
public import Memory
public import Storage

public typealias Array<E: ~Copyable> =
    __Array<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<E>>.Linear>
