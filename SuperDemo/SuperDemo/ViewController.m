//
//  ViewController.m
//  SuperDemo
//
//  Created by yanghe on 2020/6/21.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import <objc/runtime.h>
#import "ViewController.h"
#import "Inherit/Person.h"
#import "Memory/MemoryDemoViewController.h"
#import "TaggedPointer/TaggedPointerViewController.h"
#import "AutoKVO/AutoKVO.h"
#import "Inherit/Person+man.h"
#import "MJTimer.h"
#import "BlockViewController.h"
#import "BlockSubClassViewController.h"
#import "LoadAndInitialize/LoadTest.h"
#import "SubLoadTest.h"
#import "MessagesForwarding.h"
#import "Inherit/Son.h"
#import "TRURLSchemeManager.h"
#import "CustomButton.h"
#import <malloc/malloc.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "TBCToolsBarView.h"


//#import "ExposureViewController.h"
@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) Person *person;
//@property(nonatomic, copy) int (^testBlcok)(int n);
@property(nonatomic, strong) Person *personNSTimer;
@property(copy, nonatomic) dispatch_block_t block;
//@property(nonatomic, strong) AutoKVO *manualKVO1;
//@property(nonatomic, strong) AutoKVO *manualKVO2;
@property(nonatomic, strong) NSString *timerName;
@property(nonatomic, strong) NSArray *testMutableArray;
@property(nonatomic, strong) UIButton *testGesCoverButtonTap;
@property(nonatomic, strong) TBCToolsBarView *toolsBarView;

@property(nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@">>>>>>%@", scrollView);
}

- (void)testGes {
    NSLog(@"testGes");
}

- (void)testGes1 {
    NSLog(@"testGes1");
}


- (void)test:(UIView *)view {
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (!obj) {
            return;
        }
        NSLog(@"%@", obj);
        [self test:obj];
    }];


}

- (void)testDengIsEqual {
    int i = 65;
    float f = 65.0f;
    char ch = 'A';
    NSString *s1 = @"我是007"; // 常量区 只保存一份
    NSString *s2 = @"我是007"; // 常量区 只保存一份
    NSString *str1 = [NSString stringWithFormat:@"我是007"];
    NSString *str2 = [NSString stringWithFormat:@"我是007"];
    NSString *stra1 =[[NSString alloc] initWithFormat:@"我是007"];
    NSString *strb2 =[[NSString alloc] initWithFormat:@"我是007"];
    NSLog(@"str1 = %@ %@", str1,str2);
    NSLog(@"str1 = %@ %@", stra1,strb2);
    NSLog(@"(stra1==strb2) = %d", (stra1==strb2));
    NSLog(@"[stra1 isEqual:strb2] = %d", [stra1 isEqual:strb2]);
    NSLog(@"65和'A'是否相等?:%d", (i == ch));
    NSLog(@"65和65.0f是否相等?:%d", (i == f));//1
    NSLog(@"\nstr1==str2结果:%d", (str1 == str2));//0
    NSLog(@"\nstr1 isEqual str2结果:%d", [str1 isEqual:str2]);//1   已经被重写
    NSLog(@"\nstr1 isEqualToString str2结果:%d", [str1 isEqualToString:str2]);//1
    NSLog(@"\ns1与s2是否相等%d", (s1 == s2));//1
    NSLog(@"\ns1与str1是否相等%d", (s1 == str1));//0

}

- (NSArray *)regularPlusString:(NSString *)content {
    
    NSString *pattern = @"<(tpcl|tpcc)>([^<]*?)\\^![^!]*?\\^!</(tpcl|tpcc)>";

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:content options:0 range:NSMakeRange(0, [content length])];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *match in matches) {
        NSString *result = [content substringWithRange:[match rangeAtIndex:2]];
        NSLog(@"匹配结果：%@", result);
        [results addObject:result];
    }
    return [results copy];
}


- (void)test {
//    NSString *text = @"这是一个示例文本，其中包含#adfadsfds##需要匹配的内容111###。";
//    NSString *pattern = @"#([^#]*?)#";
//
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
//    NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, [text length])];
//
//    for (NSTextCheckingResult *match in matches) {
//        NSString *result = [text substringWithRange:[match rangeAtIndex:1]];
//        NSLog(@"匹配结果：%@", result);
//    }
//
    NSString *text = @"这是一个示例文本，其中包含###需要匹配的内容###和##另一个匹配内容##。";
    NSString *pattern = @"#([^#]*?)#";

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, [text length])];

    for (NSTextCheckingResult *match in matches) {
        NSString *result = [text substringWithRange:[match range]];
        NSLog(@"匹配结果：%@", result);
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.toolsBarView = [[TBCToolsBarView alloc] init];
    [self.view addSubview:self.toolsBarView];
//    [self.view addSubview:self.tableView];
//    NSString *text = @"<tpcl>这是一个示例文本^!2456^!</tpcl><tpcc>这是另一个示例文本^!1234^!</tpcc><tpcl>这是一个示例文本^!2456^!</tpcl><tpcl>这是一个示例文本^!2456^!</tpcl>";

//    NSLog(@"%@",  [self regularPlusString:text]);
    
    
//    [self test];
//    [self.navigationController pushViewController:[[BlockViewController alloc] init] animated:YES];
//    [self.view setBackgroundColor:[UIColor whiteColor]];
//    [self testDengIsEqual];

//-----------------------测试手势覆盖-------------------------------
//    self.testGesCoverButtonTap = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.testGesCoverButtonTap setBackgroundColor:[UIColor redColor]];
//
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testGes1)]; //GestureRecognizer 会覆盖 uibutton的手势
//    [self.testGesCoverButtonTap addGestureRecognizer:tapGestureRecognizer];
//
//    [self.view addSubview:self.testGesCoverButtonTap];
//    [self.testGesCoverButtonTap addTarget:self action:@selector(testGes) forControlEvents:UIControlEventTouchUpInside];
//------------------------------------------------------------------
//    CustomButton *button = [[CustomButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    button.userInteractionEnabled = YES;
//    [button setBackgroundColor:[UIColor redColor] ];
//    [self.view addSubview:button];
//-----------------------测试copy  storng array-------------------------------


//self.testMutableArray addObject[]

//-----------------------测试copy  storng array-------------------------------

//  id result =   [self performSelector:@selector(testreturnint)];
//    NSLog(@"result = %@", result);
//-----------------------method_exchangeImplementations-------------------------------
//    Son *son = [[Son alloc] init];
//    [son performSelector:@selector(testExchangeA)];
//    Person *person = [[Person alloc] init];
//    [Person performSelector:@selector(testExchangeA)];
// ------------------------------------------------------

//    [self testLoad];
//    NSLog(@"%d", [Person isKindOfClass:[NSObject class]]);
//    NSLog(@"%d", [NSObject isMemberOfClass:[NSObject class]]);
// ------------------------------------------------------
//    NSLog(@"%d", [NSObject isKindOfClass:[NSObject class]]); // 1  // 这句代码的方法调用者不管是哪个类（只要是NSObject体系下的），都返回YES
//    NSLog(@"%d", [NSObject isMemberOfClass:[NSObject class]]); // 0   ？？？？
//    NSLog(@"%d", [Person isKindOfClass:[Person class]]); // 0
//    NSLog(@"%d", [Person isMemberOfClass:[Person class]]); // 0
// ------------------------------------------------------




// ------------------------------------------------------
    // 接口设计   // 这个位置传入 self 不会产生强引用，因为只是blcok强持有self，self没有强持有block
//    self.timerName = [MJTimer execTask:self
//                         selector:@selector(doTask)
//                            start:2.0
//                         interval:1.0
//                          repeats:YES
//                            async:NO];

//    self.task = [MJTimer execTask:^{
//        NSLog(@"111111 - %@", [NSThread currentThread]);
//    } start:2.0 interval:-10 repeats:NO async:NO];
// ------------------------------------------------------


// ------------------------------------------------------
//   //指针读取类地址，强转为对象，调用sayHello。
//    Class cls = [HTPerson class];
//    void * ht = &cls;
//    [(__bridge id)ht sayHello];    // 添加属性name后，通过内存平移去查找
//    // 实例化对象，调用sayHello
//    HTPerson * person = [HTPerson new];
//    [person sayHello]; // 添加属性name后，
// ------------------------------------------------------


//    self.str = @"yy";
//    NSString *temp = self.str;
//    NSLog(@"temp = %p", temp);
//    NSLog(@"self.str = %p", self.str);
//    self.block = ^{
//        NSLog(@"temp = %p", temp);
//    };
//    self.block();
//    NSLog(@"测试函数地址1");
//    NSLog(@"测试函数地址2");
//    int double_num_times_asm(int num, int times);
    // 1. 0x00000001002d0000
    // 2. 0x00000001028bc000        0x1028c4200      00008020
    //0x00000001005e0000+0x8020
//    [self.view setBackgroundColor:UIColor.redColor];
//    [self taggedpointerDemo];
//    [self exeBlock];

//    [self testKVO];

//    [self testCopyAndMutableCopy];

//    self.personNSTimer = [[Person alloc] initWithName:@"测试timer 循环引用问题"];
//    self.block = ^{
//        NSLog(@"%@", self);
//    };


//    [self getMemory];


}

- (void)dealloc {
    NSLog(@"NSStringFromClass([self class]) dealloc = %@", NSStringFromClass([self class]));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

//    AutoKVO *manualKvo = [[AutoKVO alloc] init];
//    [self.navigationController pushViewController:manualKvo animated:YES];
//
//    self.manualKVO1.name = @"11";
//    self.manualKVO2.name = @"22";
//    [self printMethodListForIns:object_getClass(self.manualKVO1)];
//    [self printMethodListForIns:object_getClass(self.manualKVO2)];

    BlockViewController *blockViewController = [[BlockViewController alloc] init];
    blockViewController.view.backgroundColor = [UIColor redColor];
    blockViewController.view.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    [self.navigationController pushViewController:blockViewController animated:YES];
}

- (void)testreturnint {

}

- (void)testLoad {
//    [LoadTest load];//会走消息查找流程，就会调用分类LoadTest+LoadTestCategory的load的方法，因为同名分类中的方法“覆盖”类中的方法
//    LoadTestCategory initialize    这行是因为分类接收到了load消息
//    LoadTestCategory load

//    [LoadTest initialize]; // 第一次接收消息，调用一次initialize ，主动调用initialize，一共调用两次initialize
//    LoadTestCategory initialize
//    LoadTestCategory initialize

//    [SubLoadTest initialize]; //第一次接收消息，调用一次initialize ，主动调用initialize，由于是子类会自动调用一次父类的initialize
//    LoadTestCategory initialize
//    SubLoadTestCategory initialize
//    SubLoadTestCategory initialize

//    [SubLoadTest alloc]; //如果子类没有实现initialize ，但是父类实现了initialize，由于内部会自动调用父类的initialize加上消息查找机制会找到父类的initialize方法，所以当子类没有实现initialize方法的时候会调用两次父类的initialize
}

// 指针 64位系统占用8字节  32位系统占用4字节
// iOS内存对齐是16的倍数
- (void)getMemory {
    NSObject *objc = [[NSObject alloc] init];
    NSLog(@"%zd", class_getInstanceSize([NSObject class]));//获取NSObject类的实例对象的成员变量所占用的大小
    NSLog(@"%zd", malloc_size((__bridge const void *) objc));//获取objc指针指向的内存的大小，即实际分配的内存
}


- (void)testCopyAndMutableCopy {

    // 1. 可变数组 mutableCopy
//    可变数组的mutableCopy是深拷贝，创建新的数组指针，但是内部的内容不会被重新创建,数组内部的对象引用计数器+1，地址不变
    Person *person = [[Person alloc] init];
    person.age = 1;
    Person *person1 = [[Person alloc] init];
    person1.age = 2;
    Person *person2 = [[Person alloc] init];
    person2.age = 3;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:person];
    [array addObject:person1];
    [array addObject:person2];
    id mutableObject = [array mutableCopy]; // 可变数组的指针会被复制，但是内部的对象类型的值不会
    Person *temp = array[0];
    temp.age = 4;
    NSLog(@"%@,%@", array, mutableObject);

}


- (void)printMethodListForIns:(Class)class {
    NSMutableArray *names = [[NSMutableArray alloc] init];
    unsigned int outCount;
    Method *methodList = class_copyMethodList(class, &outCount);
    for (int i = 0; i < outCount; ++i) {
        Method method = methodList[i];
        NSString *methodName = NSStringFromSelector(method_getName(method));
        [names addObject:methodName];
    }
    free(methodList);
    NSLog(@"names = %@", names);
}


- (void)exeBlock {
    void (^block)(void) =^{
        NSLog(@"------%p", self, _cmd);// 方法默认会传递self _cmd参数，参数属于局部变量，所以会捕获
        NSLog(@"------%p", _str);   // 也会捕获，_str 相当于self->_str  ,self是局部两变量，所以也会捕获_str
        NSLog(@"------%p", [self str]);//转成 objc_msgSend(self,@selector(str))   ,同理还是会捕获self
    };
}

//测试tagged pointer
- (void)taggedpointerDemo {
    UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [test addTarget:self action:@selector(testEvent) forControlEvents:UIControlEventTouchUpInside];
    [test setTitle:@"testbutton" forState:UIControlStateNormal];
    [self.view addSubview:test];
}

- (void)testEvent {
    TaggedPointerViewController *tg = [[TaggedPointerViewController alloc] init];

    [tg.view setBackgroundColor:UIColor.yellowColor];
    [self.navigationController pushViewController:tg animated:YES];
}

//测试timer
- (void)memoryDemo {
    UIButton *memoryDemo = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [memoryDemo addTarget:self action:@selector(showMemoryDemo) forControlEvents:UIControlEventTouchUpInside];
    [memoryDemo setTitle:@"memory" forState:UIControlStateNormal];
    [self.view addSubview:memoryDemo];
}

- (void)showMemoryDemo {
    MemoryDemoViewController *memoryDemo = [[MemoryDemoViewController alloc] init];
    [memoryDemo.view setBackgroundColor:UIColor.yellowColor];
    [self.navigationController pushViewController:memoryDemo animated:YES];
}
@end
