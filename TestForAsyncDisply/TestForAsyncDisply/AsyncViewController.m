//
//  AsyncViewController.m
//  TestForAsyncDisply
//
//  Created by 李应鹏 on 2018/7/18.
//  Copyright © 2018年 李应鹏. All rights reserved.
//

#import "AsyncViewController.h"
#import "HTSLiveAsyncLabel.h"
#import <objc/runtime.h>

@interface NSTimer (HTS_Block)

+ (NSTimer *)hts_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        repeats:(BOOL)repeats
                                          block:(void (^)(NSTimer *timer))block;

+ (NSTimer *)hts_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        repeats:(BOOL)repeats
                                       userInfo:(NSDictionary *)userInfo
                                          block:(void (^)(NSTimer *timer))block;

+ (NSTimer *)hts_timerWithTimeInterval:(NSTimeInterval)interval
                               repeats:(BOOL)repeats
                              userInfo:(NSDictionary *)userInfo
                                 block:(void (^)(NSTimer *timer))block;

@end


static void *HTSTimerActionBlock = &HTSTimerActionBlock;

@implementation NSTimer (HTS_Block)

+ (NSTimer *)hts_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        repeats:(BOOL)repeats
                                          block:(void (^)(NSTimer *timer))block
{
    return [self hts_scheduledTimerWithTimeInterval:interval repeats:repeats userInfo:nil block:block];
}

+ (NSTimer *)hts_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        repeats:(BOOL)repeats
                                       userInfo:(NSDictionary *)userInfo
                                          block:(void (^)(NSTimer *timer))block
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(handleTimerAction:) userInfo:userInfo repeats:repeats];
    objc_setAssociatedObject(timer, HTSTimerActionBlock, block, OBJC_ASSOCIATION_COPY);
    return timer;
}

+ (NSTimer *)hts_timerWithTimeInterval:(NSTimeInterval)interval
                               repeats:(BOOL)repeats
                              userInfo:(NSDictionary *)userInfo
                                 block:(void (^)(NSTimer *timer))block
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(handleTimerAction:) userInfo:userInfo repeats:repeats];
    objc_setAssociatedObject(timer, HTSTimerActionBlock, block, OBJC_ASSOCIATION_COPY);
    return timer;
}


#pragma mark - Private Methods

+ (void)handleTimerAction:(NSTimer *)timer
{
    void (^block)(NSTimer *timer) = objc_getAssociatedObject(timer, HTSTimerActionBlock);
    !block ?: block(timer);
}

@end

@interface AsyncCell : UITableViewCell
@property (nonatomic, strong) HTSLiveAsyncLabel *label;
@end

@implementation AsyncCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[HTSLiveAsyncLabel alloc] init];
        self.label.layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
        self.label.textContainerInset = UIEdgeInsetsMake(2, 10, 2, 10);
        self.label.layer.cornerRadius = 12;
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.contentView.bounds;
}

- (void)update:(NSMutableAttributedString *)str {
    self.label.attributedText = str;
}

@end

@interface AsyncViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation AsyncViewController

- (void)dealloc {
    [self.timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    __weak typeof(self) weakSelf = self;
//    self.timer = [NSTimer hts_scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer *timer) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//    }];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

    [self add];
    // Do any additional setup after loading the view.
}

- (void)add {
    for (int i = 0; i < 100000 ; i++) {
        [self.list addObject:[self buildWithIndex:i]];
    }
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.list count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSMutableArray *)list {
    if (!_list) {
        _list = @[].mutableCopy;
    }
    return _list;
}

- (NSMutableAttributedString *)buildWithIndex:(NSInteger)i {
    NSString *str = [NSString stringWithFormat:@"%d Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫",i];

    //创建NSMutableAttributedString
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    //设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30.0f] range:NSMakeRange(0, 3)];
    //添加文字颜色
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(17, 7)];
    //添加文字背景颜色
    [attrStr addAttribute:NSBackgroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(17, 7)];
    //添加下划线
    [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(8, 7)];
    return attrStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView registerClass:[AsyncCell class] forCellReuseIdentifier:@"cell"];
    AsyncCell *cell = [AsyncCell new];
    
    [cell update:self.list[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
