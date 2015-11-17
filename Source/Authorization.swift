//
// Authorization.swift
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

import Alamofire


/**
 A resource for fetching the details of a user account.

 - seealso: [Authorization](https://github.com/quaderno/quaderno-api/blob/master/sections/authentication.md).
 */
public struct Authorization: Resource {

  // MARK: Resource

  public static let name = "authorization"

}

extension Authorization: SingleRequest {

  public var method: Alamofire.Method {
    return .GET
  }

  public var parameters: RequestParameters? {
    return nil
  }

  public func uri(baseURL baseURL: String) -> String {
    // Custom base URL is ignored for this request as per API requirements.
    return ("https://quadernoapp.com/api/v1/" + Authorization.name).appendJSONSuffix()
  }

  public static func request() -> Request {
    return Authorization()
  }

}
