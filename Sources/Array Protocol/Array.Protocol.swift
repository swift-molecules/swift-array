import Array_Primitive
public import Collection

@_documentation(visibility: public)
public protocol Indexable: Collection.Bidirectional & ~Copyable {

    var count: Index.Index<Element>.Count { get }

    subscript(_ position: Index) -> Element { get set }
}

public typealias __ArrayProtocol = Indexable
