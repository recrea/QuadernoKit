//
// DeliverableResource.swift
//
// Copyright (c) 2017 Recrea (http://recreahq.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


/// A resource that can be delivered.
public protocol DeliverableResource: Resource {}


// MARK: - Creating Requests

/// A delivery operation that can be performed on a resource.
public struct Delivery: Operation {

    fileprivate let remoteIdentifier: Resource.Identifier

    // MARK: Initialization

    // Marked as private to force clients to use `delivery(_)` as constructor.
    private init(remoteIdentifier: Int) {
        self.remoteIdentifier = remoteIdentifier
    }

    // MARK: Operations

    /// Build a delivery operation on a resource with a given identifier.
    ///
    /// - Parameter remoteIdentifier: The identifier of a resource.
    /// - Returns: A delivery operation.
    static func deliver(_ remoteIdentifier: Resource.Identifier) -> Delivery {
        return Delivery(remoteIdentifier: remoteIdentifier)
    }

}

struct DeliverableRequest<R: DeliverableResource>: Request {

    /// The delivery operation to perform.
    let operation: Delivery

    // MARK: Request

    func uri(using baseURL: URL) -> URL {
        return baseURL.appendingPathComponent(R.name)
            .appendingPathComponent(String(operation.remoteIdentifier))
            .appendingPathComponent("deliver")
            .toJSON
    }

}

extension Resource where Self: DeliverableResource {

    /// Build a request to perform a delivery operation.
    ///
    /// - Parameter operation: The operation to perform.
    /// - Returns: A request configured to perform `operation`.
    public static func request(_ operation: Delivery) -> Request {
        return DeliverableRequest<Self>(operation: operation)
    }

}
