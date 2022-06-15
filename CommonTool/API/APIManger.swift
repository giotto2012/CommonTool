//
//  APIManger.swift
//  LiveBid
//
//  Created by Taco on 2018/11/7.
//  Copyright © 2018年 Taco. All rights reserved.
//

import Foundation
import Alamofire

public protocol APIMangerProtocol
{
    func apiVersion() -> String
    func generalError(code:Int)
    func requestRefreshToken(success: @escaping ()->(),failure: @escaping (CustomError)->())
}


public class AlamofireRequestModal {
    public var method: Alamofire.HTTPMethod
    public var path: String
    public var parameters: Any?
    var encoding: ParameterEncoding
    public var headers: [String: String]?
    public var isLocalTest = false
    
    public init() {
        method = .get
        path = ""
        parameters = nil
        encoding = JSONEncoding() as ParameterEncoding
        headers = ["Content-Type": "application/json",
                   "Cache-Control": "no-cache"]
    }
}



public class FileRequestModal {
    public var fileName: String = ""
    public var mimeType: String = ""
    public var fileData: Data?
    public var fileDataKey: String = ""
    
    public init(name:String,type:String,data:Data,key:String)
    {
        fileName = name
        mimeType = type
        fileData = data
        fileDataKey = key
    }
}


open class APIManger  {
    
    var manager: Alamofire.Session = {

        let configuration = URLSessionConfiguration.ephemeral

        let sessionManager = Alamofire.Session(configuration: configuration)


        return sessionManager

    }()
    
    
    var delegate:APIMangerProtocol?
    
    private static var mInstance:APIManger?
        
    
    static func sharedInstance() -> APIManger {
        
        if mInstance == nil {
            
            
            mInstance = APIManger()
            
        }
        
        return mInstance!
    }
    
    public static func setDelegate(gate:APIMangerProtocol)
    {
        APIManger.sharedInstance().delegate = gate
    }
    
    
    func _callWebServiceAlamofire(_ alamoReq: AlamofireRequestModal,success: @escaping (Data?) -> (), failure: @escaping (CustomError)->())
    {
        
        if alamoReq.isLocalTest
        {
            
            let u = alamoReq.path.split(separator: "/")

            let path = Bundle.main.path(forResource: String(u.last!), ofType: "txt")
            
            if let path = path
            {
                let data = try! Data(contentsOf: URL(fileURLWithPath: path))
                
                
                success(data)
            }
            else
            {
                failure(CustomError(code: 500))
            }
                        
            
            return
        }
        
        
                
        print("post:\(String(describing: alamoReq.parameters))")
        
        var encoding:ParameterEncoding = JSONEncoding.default
        
        var parameters:[String:Any]?

        
        if let obj = alamoReq.parameters
        {
            if obj is [String:Any]
            {
                parameters = obj as? [String:Any]
            }
            else
            {
                let array = obj as? [Any]
                
                parameters = array?.asParameters()
                
                encoding = ArrayEncoding()
            }
        }
        
    
        let handler = OAuth2RetryHandler(gate: delegate!)

        manager.request(alamoReq.path, method:alamoReq.method, parameters:parameters,encoding:encoding,interceptor:handler)
            .validate(statusCode: 200...201)
            .responseData(emptyResponseCodes: [200, 204, 205],completionHandler: { [self] (response) in
                                
                responseData(alamoReq: alamoReq, response: response, success: success, failure: failure)
                
            })
    }
    
    func _uploadFileAlamofire(_ alamoReq: FileParametersModel,success: @escaping (Data?) -> (), failure: @escaping (CustomError)->())
    {
        let handler = OAuth2RetryHandler(gate: delegate!)

        print("post:\(String(describing: alamoReq.parameters))")
                        
        let parameters:[String:Any]? = alamoReq.parameters as? [String:Any]
                    
        manager.upload(multipartFormData: { multipartFormData in
            
            for obj in alamoReq.fileModels
            {
                multipartFormData.append(obj.fileData!, withName: obj.fileDataKey, fileName: obj.fileName, mimeType: obj.mimeType)

            }
            
            
            if let p = parameters
            {
                for (key, value) in p {
                    
                    let v = (value as! String).data(using: .utf8)
                    
                    multipartFormData.append(v!, withName: key)
                }
            }
            
            
        }, to: alamoReq.path,method: alamoReq.method,interceptor:handler)
            .validate(statusCode: 200...201)
            .responseData(completionHandler: { [self] (response) in
                
                responseData(alamoReq: alamoReq, response: response,success: success,failure: failure)
                
                
                
            })

           
    }
    
    func responseData(alamoReq: AlamofireRequestModal,response:AFDataResponse<Data>,success: @escaping (Data?) -> (), failure: @escaping (CustomError)->())
    {
        switch response.result{
            
        case .success:
            
            let utf8Text = String(data: response.value!, encoding: .utf8)
            
            print("Success Response:\(utf8Text ?? ""))")
            
            success(response.value)
                        
        case .failure(let error):
                                
                               
            let statusCode = response.response?.statusCode
            let locolerrorCode = error._code
            
            var postErrorDic:[String:Any] = [:]
            
            postErrorDic["locol_code"] = "\(locolerrorCode)"
            postErrorDic["status_code"] = "\(statusCode ?? 0)"
            postErrorDic["url"] = response.request?.url?.absoluteString

            print("statusCode:\(statusCode ?? 404)")
            
            if let data = response.data
            {
                let utf8Text = String(data: data, encoding: .utf8)
                
                print("Fail Response:\(utf8Text ?? ""))")

                let backToString = String(data: data, encoding: .utf8)

                print(backToString ?? "ERROR")
                
                let errorDic = APIManger.self.dataToDic(data: data)
                
                let message = errorDic?["message"] as? String
                
                let result = errorDic?["result"]

                let code = errorDic?["code"] as? Int
                
                
                postErrorDic["code"] = "\(code ?? 0)"
                postErrorDic["message"] = message ?? ""
                
//                GoogleAnalyticsManager.sendEvent(name: "API_Error", parameters: postErrorDic)

                
                if statusCode == 403
                {
                    APIManger.logout()
                }
                else
                {
                    self.delegate?.generalError(code: code ?? 0)
                    
                    let err = CustomError(errorCode: code, message: message ?? "", error: error as NSError, statusCode: statusCode ?? 0,result: result)
                                        
                    failure(err)

                }
                
            }
            else
            {
                
//                GoogleAnalyticsManager.sendEvent(name: "API_Error", parameters: postErrorDic)
                
                if statusCode == 403
                {
                    APIManger.logout()
                }
                else
                {
                    failure(CustomError(code: statusCode ?? 0))
                }
                
            }
            
            
            break
            
        }
    }
    
    public class func callWebServiceAlamofire(_ alamoReq: AlamofireRequestModal,success: @escaping (Data?) -> (), failure: @escaping (CustomError)->())
    {
        
        APIManger.sharedInstance()._callWebServiceAlamofire(alamoReq, success: success, failure: failure)

    }
    
    public class func uploadFileAlamofire(_ alamoReq: FileParametersModel,success: @escaping (Data?) -> (), failure: @escaping (CustomError)->())
    {
        APIManger.sharedInstance()._uploadFileAlamofire(alamoReq,success: success, failure: failure)
    }
    
    
    
    class func callRefishToken(_ alamoReq: AlamofireRequestModal,success: @escaping (Data?) -> (), failure: @escaping (CustomError)->())
    {
    
        let delegate = APIManger.sharedInstance().delegate
        
        RefreshTokenManger.sharedInstance().refreshToken(delegate: delegate!, finsh: {
            
            if let request = alamoReq as? FileParametersModel
            {
                uploadFileAlamofire(request, success: success, failure: failure)
            }
            else
            {
                callWebServiceAlamofire(alamoReq,success: success, failure: failure)
            }
            
        })
        
    }
        
    
    public class func logout()
    {
        LogoutManger.logout()
    }
    
    
    
    class func dataToDic(data:Data) -> [String:Any]?
    {
        var d:[String:Any]?
        
        do {
            let dic =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            
            
            d = dic
            
            
            
        } catch {
            
        }
        
        
        return d
        
    }
    
    
    func getHeader() -> HTTPHeaders
    {
        var headers: HTTPHeaders = [
            "HTTP_ACCEPT":delegate?.apiVersion() ?? "",
            "Content-Type":"application/json",
            "X-localization":LocalizeUtils.apiHaderKey()
        ]
              
        print(delegate?.apiVersion() ?? "No!")
        
        let token = ""

        headers["Authorization"] = "Bearer \(token)"
        
        return headers
    }

}

extension String: ParameterEncoding {
  
  public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
    var request = try urlRequest.asURLRequest()
    request.httpBody = data(using: .utf8, allowLossyConversion: false)
    return request
  }
  
}
