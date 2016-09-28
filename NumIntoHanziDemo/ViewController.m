//
//  ViewController.m
//  NumIntoHanziDemo
//
//  Created by sunhong on 16/9/21.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "ViewController.h"

#import "NSString+translation.h"

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel * showLabel;

@property (nonatomic, strong) UIView * errorView;
@property (nonatomic, strong) UILabel * errorLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGRect textFrame = CGRectMake(0, 0, viewWidth, 50);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFrame];
    textField.center = CGPointMake(self.view.center.x, self.view.center.y - 150);
//    textField.backgroundColor = [UIColor cyanColor];
    textField.textAlignment = NSTextAlignmentRight;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    textField.borderStyle = UITextBorderStyleLine;
    textField.delegate = self;
    [textField addTarget:self action:@selector(textEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:textField];
    
    CGRect labelFrame = CGRectMake(0, 0, viewWidth, 50);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.center = CGPointMake(self.view.center.x, self.view.center.y - 90);
    label.backgroundColor = [UIColor colorWithRed:0.839 green:1.000 blue:0.968 alpha:1.000];
    label.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:label];
    
    self.showLabel = label;
}

#pragma mark - delegate
/**
 *  需要避免
 *
 *  1.首个字符不能是“.”
 *  2.不能输入两个小数点
 *  3.保留到小数点后两位
 *  4.前几位不能出现连续的0，例：0000087
 *
 */
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    NSLog(@"string------%@",string);
//    NSLog(@"textField******%@",textField.text);
//
//    NSUInteger nDotLoc = [textField.text rangeOfString:@"."].location;
    
//    if ([string isEqualToString:@"."]) {
//        //1.首个字符不能是“.”
//        if (textField.text.length == 0) {
//            [self showError:@"亲，第一个数字不能为小数点"];
//            return NO;
//        }
        //2.限制只能输入一个小数点
//        if (NSNotFound != nDotLoc) {
//            [self showError:@"亲，您已经输入过小数点了"];
//            return NO;
//        }
//    }
    
    
    //3.有小数点时，不能超过小数点后两位
//    if (NSNotFound != nDotLoc && range.location > nDotLoc + 2) {
//        [self showError:@"亲，您最多输入两位小数"];
//        return NO;
//    }
//    
//    return YES;
//}

- (void)textEditingChanged:(UITextField *)sender {
//    NSLog(@"%@",sender.text);
    
    NSString *labelStr = [NSString translation:sender.text];
    self.showLabel.text = labelStr;
}

- (void)showError:(NSString *)errorString
{
    
    if (!_errorView) {
        CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
        _errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 50)];
        _errorView.center = self.view.center;
        _errorView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:_errorView];
        
        _errorLabel = [[UILabel alloc] initWithFrame:self.errorView.bounds];
        _errorLabel.backgroundColor = [UIColor clearColor];
        _errorLabel.textColor = [UIColor whiteColor];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        [_errorView addSubview:_errorLabel];
    }
    _errorLabel.text = errorString;
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(removeErrorView) userInfo:nil repeats:NO];
    //隐藏键盘
//    [self.view endEditing:YES];
}

- (void)removeErrorView {
    [self.errorView removeFromSuperview];
    self.errorView = nil;
}

@end
