//
//  ViewController.m
//  ZPRestrainPriorityAnimation
//
//  Created by 赵鹏 on 2018/9/6.
//  Copyright © 2018年 赵鹏. All rights reserved.
//

#import "ViewController.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *orangeView;
@property (nonatomic, strong) UIView *yellowView;
@property (nonatomic, strong) UIView *greenView;
@property (weak, nonatomic) IBOutlet UIButton *delYellowViewBtn;
@property (weak, nonatomic) IBOutlet UIButton *delOrangeViewBtn;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //添加橙色视图
    self.orangeView = [[UIView alloc] init];
    self.orangeView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.orangeView];
    
    //添加黄色视图
    self.yellowView = [[UIView alloc] init];
    self.yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.yellowView];
    
    //添加绿色视图
    self.greenView = [[UIView alloc] init];
    self.greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.greenView];
    
    /**
     允许按钮的内容文字多行显示；
     当按钮的内容文字过多的时候，Autolayout可以根据内容文字的多少自动调节按钮控件的高度。
     */
    self.delYellowViewBtn.titleLabel.numberOfLines = 0;
    self.delOrangeViewBtn.titleLabel.numberOfLines = 0;
    
    //设置约束
    [self setUpRestrain];
}

#pragma mark ————— 设置约束 —————
- (void)setUpRestrain
{
    //对于橙色View只需正常设置约束就好
    [self.orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.left.offset(10);
        make.top.offset(50);
    }];
    
    /**
     当左边的橙色View消失的时候，要想让黄色View向左移动并占据原来橙色View的位置的话应该给该黄色View添加一个低优先级的约束（优先级为300），用来约束当橙色View消失以后黄色View和父视图左边的距离。当橙色View消失的以后原来黄色View和橙色View中间的那个约束（优先级为1000）就会消失，这个时候下面代码中的低优先级（300）的约束就会起作用。
     */
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.left.equalTo(self.orangeView.mas_right).offset(20);
        make.top.offset(50);
        make.left.equalTo(self.view.mas_left).offset(20).priority(300);
    }];
    
    /**
     当中间的黄色View消失的时候，要想让原来在最右边的绿色View向左移动并且占据原来黄色View的位置的话就应该给该绿色View添加一个低优先级的约束（优先级为300），用来约束黄色View消失以后绿色View和橙色View之间的距离。当橙色View和黄色View都消失以后，要想让绿色View移动到最左边的话就应该再给该绿色View添加一个更低优先级的约束（优先级为250），用来约束橙色View和黄色View都消失以后绿色View和父视图左边的距离。
     */
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.left.equalTo(self.yellowView.mas_right).offset(20);
        make.top.offset(50);
        make.left.equalTo(self.orangeView.mas_right).offset(20).priority(300);
        make.left.equalTo(self.view.mas_left).offset(20).priority(250);
    }];
}

#pragma mark ————— 删除黄色视图 —————
- (IBAction)delYellowView:(id)sender
{
    [self.yellowView removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark ————— 删除橙色视图 —————
- (IBAction)delOrangeView:(id)sender
{
    [self.orangeView removeFromSuperview];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
