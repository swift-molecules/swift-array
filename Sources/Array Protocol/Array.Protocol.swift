import Array_Primitive
public import Collection
public import Cardinal
public import Tagged

@_documentation(visibility: public)
public protocol Indexable: Collection.Bidirectional & ~Copyable {

    var count: Tagged<Element, Cardinal> { get }

    subscript(_ position: Index) -> Element { get set }
}

public typealias __ArrayProtocol = Indexable
