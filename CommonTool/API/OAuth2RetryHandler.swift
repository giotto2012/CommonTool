
import Foundation
import Alamofire


class OAuth2RetryHandler: RequestInterceptor {
    
    let retryLimit = 3
    
    var retryCount = 0
        
    var delegate: APIMangerProtocol

    init(gate: APIMangerProtocol) {
        delegate = gate
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {

        
        if error._code == NSURLErrorTimedOut
        {
            if retryCount >= retryLimit
            {
                completion(.doNotRetry)
            }
            else
            {
                retryCount += 1
                
                completion(.retryWithDelay(0.5))
            }
        }
        else
        {
            if let response = request.task?.response as? HTTPURLResponse, 401 == response.statusCode
            {
                if let dataRequest = request as? DataRequest
                {
                    if let data = dataRequest.data
                    {
                        do {
                            
                            let dic =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                            
                            if let code = dic?["code"] as? Int
                            {
                                if code == 700
                                {
                                    RefreshTokenManger.sharedInstance().refreshToken(delegate: delegate) {
                                        
                                        completion(.retry)
                                    }
                                }
                                else
                                {
                                    completion(.doNotRetry)
                                }
                            }
                            
                            
                            
                        } catch {
                            
                            completion(.doNotRetry)
                            
                        }
                    }
                    else
                    {
                        completion(.doNotRetry)
                    }
                    
                    
                }
            }
            else
            {
                completion(.doNotRetry)
            }
        }
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        
        var urlRequest = urlRequest
                 
        var headers = [
            "HTTP_ACCEPT":delegate.apiVersion() ,
            "X-localization":LocalizeUtils.apiHaderKey()
        ]
        
        let token =  ""

        headers["Authorization"] = "Bearer \(token)"
        
        for (key, value) in headers {
            
            urlRequest.setValue(value, forHTTPHeaderField: key)

        }
        
        completion(.success(urlRequest))
    }

    
}
