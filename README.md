AppBaseCategoryDemo

1、AppBaseCategory简介:

    UIViewController:集成了导航条返回按钮的封装使用异常简单
    UIView、xib初始化、重一个view中获取导航条等
    UITextField、文本限制
    UITableViewCell、快速初始化
    UICollectionViewCell、快速初始化
    NSMutableDictionary、NSMutableArray 安全容错等
    ATMacro、常见宏的定义屏幕宽高，iPad、iPhoneX、iPhoneXR、iPhoneXMax、等比缩放屏幕宽高等
    
2、AppBaseCategory集成方式:

    pod 'AppBaseCategory'
    
3、AppBaseCategory使用方式:
    
    UICollectionViewCell使用方式:完全兼容xib和纯代码方便快速开发
    UICollectionViewCell *cell = [UICollectionViewCell cellForCollectionView:collectionView indexPath:indexPath];
    
    UICollectionViewCell使用方式:完全兼容xib和纯代码方便快速开发
    UITableViewCell *cell = [UITableViewCell cellForTableView:tableView indexPath:indexPath];

    UIViewController使用方式
    /**
    *  设置导航栏标题
    */
    - (void)showNavTitle:(NSString *)title;//default YES
    - (void)showNavTitle:(NSString *)title backItem:(BOOL)show;
    /**
    *  设置返回按钮
    */
    - (void)setBackItem:(UIImage *)image;//default backItem
    - (void)setBackItem:(UIImage *)image closeItem:(UIImage *)closeImage;
    /**
    @brief 回收键盘
    */
    - (void)setKeyBoardDismiss;
    /**
    @brief  设置小导航栏
    */
    - (void)setLargeTitleDisplayModeNever;
    /**
    *  返回上一个界面
    */
    - (void)goBack;
    - (void)goBack:(BOOL)animated;
    - (void)dismissOrPopToRootControlelr;
    - (void)dismissOrPopToRootController:(BOOL)animated;
    /**
    *  获取根目录
    */
    - (UIViewController *)topPresentedController;
    - (UIViewController *)topPresentedControllerWihtKeys:(NSArray<NSString *> *)keys;
    + (UIViewController *)rootTopPresentedController;
    + (UIViewController *)rootTopPresentedControllerWihtKeys:(NSArray<NSString *> *)keys;
    /**
    *  StoryBoard 创建
    */
    + (instancetype)vcFromStoryBoard:(NSString *)sbName theId:(NSString *)theId;
    
    UIView使用方式
    
    + (NSString *)nibName;
    + (instancetype)instanceView;

    /**
    Returns the topMost UIViewController object in hierarchy.
    */
    @property (nonatomic, readonly, strong) UIViewController *topMostController;
    /**
    Returns the superView of provided class type.
    */
    - (__kindof UIView *)superviewOfClass:(Class)classType;
    /**
    Returns the navigationController, if exsit.
    */
    @property (nonatomic, readonly, strong) UINavigationController *getNavigationController;
    /**
    Returns the findFirstResponder, self or subview, if exsit.
    */
    - (UIView *)findFirstResponder;
    
