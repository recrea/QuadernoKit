//
// ConnectionEntitlements.swift
//
// Copyright (c) 2015 Recrea (http://recreahq.com/)
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


/**
  The entitlements granted to a given user for connecting to the service.
 */
public struct ConnectionEntitlements {

  /// The time interval in seconds until the counter of remaining requests is reset to the maximum allowed value.
  public let resetInterval: Int

  /// The number of remaining requests until the next counter reset.
  public let remainingRequests: Int

}


// MARK: - Initializing From HTTP Headers

/// Alias for an array of HTTP headers, as defined in `NSHTTPURLResponse`.
typealias HTTPHeaders = [NSObject: AnyObject]


extension ConnectionEntitlements {

  /**
    Initializes connection entitlements with an array of HTTP headers.

    - precondition: All expected headers must be present. Otherwise initialization fails.

    - parameter httpHeaders: An array of HTTP headers, typically coming from a `NSHTTPURLResponse` object.

    - returns: A newly initialized connection entitlements.
   */
  init?(httpHeaders: HTTPHeaders?) {
    guard let resetIntervalValue = httpHeaders?["X-RateLimit-Reset"] as? String else {
      return nil
    }

    guard let resetInterval = Int(resetIntervalValue) else {
      return nil
    }

    guard let remainingRequestsValue = httpHeaders?["X-RateLimit-Remaining"] as? String else {
      return nil
    }

    guard let remainingRequests = Int(remainingRequestsValue) else {
      return nil
    }

    self.resetInterval = resetInterval
    self.remainingRequests = remainingRequests
  }

}