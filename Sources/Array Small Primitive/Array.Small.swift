public import Array_Primitive
public import Buffer_Linear_Primitive
public import Buffer_Primitive
public import Memory_Allocator
public import Memory_Small
public import Storage_Contiguous
public import Store_Protocol

extension __Array where S: ~Copyable, S: Store.Direct {

    public typealias Small<let n: Int> =
        __Array<Buffer<Storage<Memory.Allocator<Memory.Small<n>>>.Contiguous<S.Element>>.Linear>
}
