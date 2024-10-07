# Project Guideline

## LINT

```yml
# .swiftlint.yml

# 指定要包含的路径
included:
  - .

# 指定要排除的路径
excluded:
  - Carthage
  - Pods

# 禁用某些规则
disabled_rules:
  - trailing_whitespace # 禁用行尾空格检查
  - force_cast           # 禁用强制类型转换检查
  # - force_try
# 自定义规则设置
opt_in_rules: # 启用额外的可选规则
  - empty_count # 检查空数组或字典的使用

# 指定警告阈值
warning_threshold: 40 # 在达到20个警告后，构建会失败

# 设置报告器类型
reporter: "xcode" # 使用Xcode格式输出报告
 
# 设置缓存路径
cache_path: .swiftlint_cache # 缓存文件存储路径
 
line_length:
  warning: 150 # 设置警告阈值为120字符
  error: 200 # 设置错误阈值为150字符
  ignores_comments: true # 忽略注释中的长度
  ignores_urls: true # 忽略URL中的长度
  ignores_function_declarations: true # 忽略函数声明中的长度
  ignores_interpolated_strings: true # 忽略插值字符串中的长度

type_name:
  min_length: 3 # 最小长度
  max_length: 50 # 增加最大长度
  excluded: # 可以排除特定的类型名
    # - TransparentDefaultCollectionViewController

identifier_name:
  min_length: 3 # 最小长度为3个字符
  max_length: 50 # 最大长度为40个字符
  excluded: # 排除特定的标识符
    - id
    - URL
    - db
    - vc
    - i
    - r
    - g 
    - b
    - a
    - x
    - y

```

## ARCHITECTURE

- UILayer & DataLayer

- VIPER parttern in UILayer

## UILayer

### How to update a UIView Object?

#### View and ViewState

Case

```swift
protocol ViewControllerProtocol {

}

struct ViewControllerState {
    let customviewState: CustomViewState = CustomViewState()
    ...
    ...
}

class ViewController: ViewControllerProtocol {
    
    var viewControllerState: ViewControllerState?

    lazy var view: CustomView = {}()

    func viewDidLoad() {
    
    }
    
    func setUpUI () {
    
    }
    
    
    
}

```

Define for `view` and `viewState`

```swift
struct CustomViewState {

    var title: String
    var isSelected: Bool

    init(title:isSelected) {

    }
    
}

protocol CustomViewProtocol {

    func config(state: CustomViewState)

    func updateTitle(title: String)
}

class CustomView: CustomViewProtocol {

    lazy var titleLabel: UILabel = {}()
    lazy var selectionButton: UIButton = {}()
    let viewState: CustomViewState 

    func config(state: CustomViewState) {
        
        self.viewState  =  state
        //update all ui elements
        ...
        ...
    }

    func updateTitle(title: String) {
        self.viewState  =  CustomViewState(title: title,
        isSelected: self.viewState.isSelected)

        // update label
    }
}

```

### 视图层级复杂的时候,  View的事件如何委托出去

`typealias` 的使用

`ControllerA`

- `viewB`
  - `viewC`
  - `viewD`

`ControllerA` 的子视图持有 `viewB`, 同时 `viewB` 持有 `viewC` 和 `viewD`, 三个视图的事件通过 各自的 `delegate` 委托出去

`ViewBDelegate`

`ViewCDelegate`

`ViewDDelegate`

使用 `typealias` 组合出一个新的类型

```swift

typealias ViewBHyperDelegate = ViewBDelegate & ViewCDelegate & ViewCDelegate

```

将`viewB` 的 `delegate` 设置为这个新的类型 `ViewBHyperDelegate`

### VIPER 使用规则

- 所有的部件的属性全部使用 `private` 修饰
- 关键依赖(或属性)必须从构造器传入
- `Presenter` 中只出现调用对应的部件的功能的代码
- `Interactor` 中依赖 `Repository`
- `Interactor` 不能持有 `Presenter`
- `Interactor` 内的数据属性不能直接访问，而是通过接口提供或者访问控制修饰

    ```swift
        private(set) var products:[Product]?
    ```
    
    ```swift
    protocol InteractorProtocol {
        
        func getProducts() -> [Product]?
    }
    
    ```


### Presenter

```swift
protocol SignInPresenterProtocol: AnyObject {
    func notifyDidButtonTapped(username: String, password: String)
    func notifyOauth2LoginUserButtonTapped()
}

class SignInPresenter: SignInPresenterProtocol {
    
    private weak var view: SignInViewControllerProtocol?
    private var router: SignInRouterProtocol
    private var interactor: SignInInteractorProtocol
    
    init(router: SignInRouterProtocol, interactor: SignInInteractorProtocol) {
        self.view = router.viewController as? any SignInViewControllerProtocol
        self.router = router
        self.interactor = interactor
    }
    
    func notifyOauth2LoginUserButtonTapped() {
        Task {
            do {
                _ = try await interactor.didLoginByOauth2()
                view?.updateWithSuccess()
                router.routeToMain()
                
            } catch {
                view?.updateWithNotSuccess()
            }
        }
    }
    
    func notifyDidButtonTapped(username: String, password: String) {
        Task {
            
            do {
                _  = try await interactor.didFetchUser(username: username, password: password)
                view?.updateWithSuccess()
                router.routeToMain()
                
            } catch {
                view?.updateWithNotSuccess()
            }
        }
    }
    
}

```

### Interactor

Interactor 需要 一个 或者 多个 依赖`Repository`

```swift
protocol SignInInteractorProtocol {
    
    func didFetchUser(username: String, password: String) async throws -> Result<Bool, Error>
    func didLoginByOauth2() async throws -> Result<Bool, Error>
    
}
```

```swift
final class SignInInteractor: SignInInteractorProtocol {
    func didLoginByOauth2() async throws -> Result<Bool, Error> {
        do {
            try await AuthRepository.onOAuth2Regist()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

    func didFetchUser(username: String, password: String) async throws -> Result<Bool, Error> {
        do {
              _ = try await AuthRepository.onLogin(username, password)
                return .success(true)
        } catch {
            debugPrint(error)
            return .failure(error)
        }
    }
}
```

### Router

- 模块内的页面路由
- 模块创建和配置

### 我需要为每个页面创建一个VIPER结构吗？

不需要

按`模块`创建 `VIPER`，`ViewController` 只是模块内的一个页面容器而已

假设你有一个产品列表和产品详情页面，这时候的 `VIPER` 模块只有一个，但是`Router` 会持有两个`ViewController`


### 模块代码过大如何处理?

部件`Extension`


## Data Layer

### Datasource

- RemoteDatasouce : 一般是我们的API服务器，多个 RemoteDatasouce 可以配置多个api服务器
- LocalDatasource : 提供本地数据访问的实现

- ExternalDatasouce: 外部 SDK 数据源


### Repository

数据仓库，所有数据的操作实现类，每个`Repo` 依赖一个或者多个 `Datasource`

比如`AuthRepository`:

- 可能依赖本地数据来判断是否可以直接自动登陆
- 可能需要调用三方 SDK 来获取session
- 可能需要请求api来登陆获取session

```swift
protocol AuthRepositoryProtocol: AnyObject {
    func getUserId() -> String?
    func userIsSignedIn() -> Bool
    
    func logOut() throws
    func logIn(data: AuthLogInData, completion: @escaping (Result<AppUser, AuthError>) -> Void)
    func signUp(data: AuthSignUpData, completion: @escaping (Result<AppUser, AuthError>) -> Void)
}
```

## DI

Without DI

```swift
        let view = CreationViewController()
        let interactor = CreationInteractor()
        let presenter = CreationPresenter()
        let router = CreationRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.entry = view
        router.presenter = presenter
```

With DI

```swift
        let view: CreationViewController = DIContainer.shared.resolve()
        
        let router: CreationRouter = DIContainer.shared.resolve(argument: view)
```

### DI Usage

DI Container

```swift
import Swinject

final class DIContainer {

    static let shared = DIContainer()

    let container: Container = Container()
    let assembler: Assembler

    init() {
        assembler = Assembler(
            [
                AccountAssembly(),
                CreationAssembly()
                
            ],
            container: container)
    }

    func resolve<T>() -> T {
        guard let resolvedType = container.resolve(T.self) else {
            fatalError()
        }
        return resolvedType
    }

    func resolve<T>(registrationName: String?) -> T {
        guard let resolvedType = container.resolve(T.self, name: registrationName) else {
            fatalError()
        }
        return resolvedType
    }

    func resolve<T, Arg>(argument: Arg) -> T {
        guard let resolvedType = container.resolve(T.self, argument: argument) else {
            fatalError()
        }
        return resolvedType
    }

    func resolve<T, Arg1, Arg2>(arguments arg1: Arg1, _ arg2: Arg2) -> T {
        guard let resolvedType = container.resolve(T.self, arguments: arg1, arg2) else {
            fatalError()
        }
        return resolvedType
    }

    func resolve<T, Arg>(name: String?, argument: Arg) -> T {
        guard let resolvedType = container.resolve(T.self, name: name, argument: argument) else {
            fatalError()
        }
        return resolvedType
    }

    func resolve<T, Arg1, Arg2>(name: String?, arguments arg1: Arg1, _ arg2: Arg2) -> T {
        guard let resolvedType = container.resolve(T.self, name: name, arguments: arg1, arg2) else {
            fatalError()
        }
        return resolvedType
    }
}

```

Assembly

```swift
final class CreationAssembly: Assembly {
    
    func assemble(container: Swinject.Container) {
        
        container.register(CreationInteractorProtocol.self) { _ in
            return CreationInteractor()
        }
        
        container.register(CreationRouter.self) { (_, view: CreationViewController) in
             return CreationRouter(viewController: view)
        }
        
        container.register(CreationPresenter.self) { (_, view: CreationViewController) in
            guard let router = container.resolve(CreationRouter.self, argument: view) else {
                fatalError("CreationRouter dependency could not be resolved")
            }
            guard let interactor = container.resolve(CreationInteractorProtocol.self) else {
                fatalError("CreationInteractor dependency could not be resolved")
            }
            return CreationPresenter(router: router, interactor: interactor)
        }
        
        container.register(CreationViewController.self) { (_) in
            let view = CreationViewController()
            guard let presenter = container.resolve(CreationPresenter.self, argument: view) else {
                fatalError("CreationPresenter dependency could not be resolved")
            }
            view.presenter = presenter
            return view
        }
    }
    
}


```

## API Request

```swift
import SwiftyJSON
import Alamofire

struct EndpointError {
    // swiftlint:disable line_length
    static let noResultError = LocalError(title: "No Result Error", description: "Request has not been fired.")
    static let noNetworkError = LocalError(title: "Network Not Available", description: "Please retry after making sure that your network is available.")
    static let unauthorizedError = LocalError(title: "Invalid Credential", description: "Please sign in again.")
    static let serviceUnavailable = LocalError(title: "Service Unavailable", description: "We have issue connecting to the server.")
    static let notFoundError = LocalError(title: "Not found Error", description: "A 404 error from the server.")
    static let serverUnexpectedError = LocalError(title: "Service Unavailable", description: "We have issue connecting to the server.")
    // swiftlint:enable line_length 
}

enum EndpointResult<Response> {
    case success(Response)
    case failed(LocalError?)
}

/// An endpoint protocal is responsible for generating the request, verifying the request parameter is valid and parse the result.
protocol Endpoint: AnyObject {
    
    associatedtype Response
    
    var result: EndpointResult<Self.Response> { get set }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var param: [String: Any] { get }
    
    var shouldAuthenticate: Bool { get }
    
    func parseResult(statusCode: Int, json: JSON)
}
```
Case SignIn

```swift
import Alamofire
import SwiftyJSON

class SignInEndpoint: Endpoint {
    
    struct Response {
        var refreshToken: String
        var sessionToken: String
        var userId: String
        var salt: String?
    }
    
    let identifier: String, identifierType: String, credential: String, credentialType: String
    
    init(identifier: String, identifierType: String, credential: String, credentialType: String) {
        self.identifier = identifier
        self.identifierType = identifierType
        self.credential = credential
        self.credentialType = credentialType
    }
    
    // MARK: - EndPoint
    
    var result: EndpointResult<Response> = .failed(EndpointError.noResultError)
    
    var path: String {
        return "sign_in"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var param: [String: Any] {
        return [
            "identifier": identifier,
            "identifier_type": identifierType,
            "credential": credential,
            "credential_type": credentialType
        ]
    }
    
    var shouldAuthenticate: Bool {
        return false
    }
    
    func parseResult(statusCode: Int, json: JSON) {
        if json["success"].boolValue,
            let sessionToken = json["session_token"].string, 
            let userId = json["user_id"].string,
            (json["key"].string != nil),
            let refreshToken = json["refresh_token"].string {
            result = .success(Response(refreshToken: refreshToken, 
                                       sessionToken: sessionToken,
                                       userId: userId,
                                       salt: json["key"].string))
        } else {
            result = .failed(LocalError(title: "Login Failed", description: json["message"].string))
        }
    }
    
}

```