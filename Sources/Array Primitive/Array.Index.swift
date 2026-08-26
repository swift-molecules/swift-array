public import Index
public import Store_Protocol

extension __Array where S: Store.`Protocol` & ~Copyable {

    public typealias Index = Index.Index<S.Element>
}
