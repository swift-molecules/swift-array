public import Buffer
public import Ownership_Shared_Primitive
public import Store

extension __Array
where
    S: ~Copyable,
    S: Store.`Protocol` & Buffer.`Protocol`
{

    public typealias Shared = __Array<Ownership.Shared<S.Element, S>>
}
