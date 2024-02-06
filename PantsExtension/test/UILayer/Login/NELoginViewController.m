//
//  NELoginViewController.m
//  NetworkExtension
//
//  Created by daxiong on 2019/11/7.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import "NELoginViewController.h"

@interface NELoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *eyeBtn;
@property (weak, nonatomic) IBOutlet UIView *shadowView;

@end

@implementation NELoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    
    self.shadowView.layer.cornerRadius = 22.f;
    self.shadowView.layer.masksToBounds = YES;
    self.shadowView.layer.shadowRadius = 10.;
    self.shadowView.layer.shadowOpacity = 0.8;
    self.shadowView.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0,0);
    self.shadowView.layer.masksToBounds = NO;
    
    self.loginBtn.layer.cornerRadius = 25.f;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.shadowRadius = 10.;
    self.loginBtn.layer.shadowOpacity = 0.8;
    self.loginBtn.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.loginBtn.layer.shadowOffset = CGSizeMake(0,0);
    self.loginBtn.layer.masksToBounds = NO;
    
}



- (void)loginTask
{
    WYTask *task = [[WYTask alloc] initWithURL:URL_Login];
    [task startWithParams:@{@"username":self.mailTextField.text,@"password":self.passwordTextField.text} requestType:WDRequestTypePost success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        WYBaseModel *model = [WYBaseModel modelObjectWithDict:responseObject];
        if ([model.code intValue] == 200) {
            if (![WDAppUtils isBlankString:model.result[kAccessToken]]) {
                saveObjectToUserDefaults([NSString stringWithFormat:@"%@ %@",model.result[@"token_type"],model.result[kAccessToken]], kAccessToken);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccessNotification" object:nil];
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (IBAction)loginBtnAction:(id)sender {
    if (!self.mailTextField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱"];
        return;
    }
//    if (![WDAppUtils isValidateEmail:self.mailTextField.text]) {
//        [ZSProgressHUD showErrorAnimatedText:@"请正确输入邮箱"];
//        return;
//    }
    
    if (!self.passwordTextField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    [self loginTask];
    
}

- (IBAction)actioneyeBtn:(UIButton*)btn{
    btn.selected = !btn.selected;
    self.passwordTextField.secureTextEntry = !btn.selected;

}


- (IBAction)registerBtnAction:(id)sender {
    [[WDPageManager sharedInstance] pushViewController:@"NERegisterViewController"];
}


@end
