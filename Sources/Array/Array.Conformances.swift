public import Array_Primitive
public import Array_Protocol
public import Buffer_Linear
public import Buffer
public import Iterator
public import Span
public import Store

extension __Array: Collection.Access.Random
where S: Span.`Protocol` & Store.`Protocol` & Buffer.`Protocol` & ~Copyable {}

extension __Array where S: ~Copyable {

    public typealias Dynamic = Self
}

extension __Array: Span.`Protocol` where S: Span.`Protocol` & ~Copyable {

    @inlinable
    public var span: Swift.Span<S.Element> {
        @_lifetime(borrow self)
        borrowing get {
            store.span
        }
    }
}

extension __Array: Iterable where S: Span.`Protocol` & ~Copyable {

    @_implements(Iterable,Iterator)
    public typealias IterableIterator = Iterator::Iterator.Chunk<S.Element>
}

extension __Array: Sequenceable where S: Sequenceable & ~Copyable, S.Iterator: Escapable {

    @_implements(Sequenceable,Iterator)
    public typealias SequenceableIterator = S.Iterator

    @inlinable
    public consuming func makeIterator() -> S.Iterator {
        take().makeIterator()
    }
}
