import Foundation
import TitanCore

public extension RequestType {
    public var formURLEncodedBody: [(name: String, value: String)] {
        return parse(body: self.body)
    }
    public var postParams: [String : String] {
        var ret = [String: String]()
        let keys = parse(body: self.body)
        for (k, v) in keys {
            ret[k] = v
        }
        return ret
    }
}

/*
 Parse application/x-www-form-urlencoded bodies
 Returns as many name-value pairs as possible
 Liberal in what it accepts, any failures to delimit pairs or decode percent
 encoding will result in empty strings
 */
func parse(body: String) -> [(name: String, value: String)] {
    var retValue = [(name: String, value: String)]()

    let pairs = body.components(separatedBy: "&") // Separate the tuples

    for element in pairs {
        guard let range = element.range(of: "=") else {
            return retValue
        }

        let rawKey = element.substring(to: range.lowerBound)
        let rawValue = element.substring(from: range.upperBound)

        // Remove + character
        let sanitizedKey = rawKey.replacingOccurrences(of: "+", with: " ")
        let sanitizedPlus = rawValue.replacingOccurrences(of: "+", with: " ")

        // Remove percent encoding characters
        if let sanitizedValue = sanitizedPlus.removingPercentEncoding {
            retValue.append((sanitizedKey, sanitizedValue))
        } else {
            retValue.append((sanitizedKey, sanitizedPlus))
        }
    }
    return retValue
}
