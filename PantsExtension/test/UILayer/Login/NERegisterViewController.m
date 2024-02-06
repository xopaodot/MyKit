//
//  NERegisterViewController.m
//  NetworkExtension
//
//  Created by daxiong on 2019/11/7.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import "NERegisterViewController.h"

@interface NERegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField2;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView1;
@property (weak, nonatomic) IBOutlet UIView *bgView2;

@property (nonatomic, assign) NSInteger countDownSeconds;
@property (nonatomic, strong) NSTimer *countDownTimer;

@end

@implementation NERegisterViewController

- (void)dealloc{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
    self.getCodeBtn.layer.cornerRadius = 5.;
    self.getCodeBtn.layer.masksToBounds = YES;
    
    self.countDownLabel.layer.cornerRadius = 5.;
    self.countDownLabel.layer.masksToBounds = YES;
    
    self.countDownSeconds = 60.;
    
    self.bgView1.layer.cornerRadius = 22.f;
    self.bgView1.layer.masksToBounds = YES;
    self.bgView1.layer.shadowRadius = 10.;
    self.bgView1.layer.shadowOpacity = 0.8;
    self.bgView1.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.bgView1.layer.shadowOffset = CGSizeMake(0,0);
    self.bgView1.layer.masksToBounds = NO;
    
    self.bgView2.layer.cornerRadius = 22.f;
    self.bgView2.layer.masksToBounds = YES;
    self.bgView2.layer.shadowRadius = 10.;
    self.bgView2.layer.shadowOpacity = 0.8;
    self.bgView2.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.bgView2.layer.shadowOffset = CGSizeMake(0,0);
    self.bgView2.layer.masksToBounds = NO;
    
    self.registerBtn.layer.cornerRadius = 25.f;
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.shadowRadius = 10.;
    self.registerBtn.layer.shadowOpacity = 0.8;
    self.registerBtn.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.registerBtn.layer.shadowOffset = CGSizeMake(0,0);
    self.registerBtn.layer.masksToBounds = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dismiss"]
     style:UIBarButtonItemStylePlain
    target:self
    action:@selector(leftBtnClick:)];
}

- (void)leftBtnClick:(UIButton *)btn
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)toLoginBtnAction:(id)sender {
    [[WDPageManager sharedInstance] pushViewController:@"NELoginViewController"];
}



- (void)getCodeTask
{
    WYTask *task = [[WYTask alloc] initWithURL:[NSString stringWithFormat:@"%@%@",URL_AUTH_Code,self.mailTextField.text]];
    [task startWithParams:@{} success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        WYBaseModel *model = [WYBaseModel modelObjectWithDict:responseObject];
        if ([model.code intValue] == 200) {
            self.getCodeBtn.hidden = YES;
            self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.1
                                                                   target:self
                                                                 selector:@selector(countdownUpdateMethod:)
                                                                 userInfo:nil
                                                                  repeats:YES];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)registerTask
{
    WYTask *task = [[WYTask alloc] initWithURL:URL_register];
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:self.mailTextField.text forKey:@"username"];
    [params setValue:self.pwdTextField.text forKey:@"password"];
    [params setValue:self.pwdTextField2.text forKey:@"repassword"];
    [params setValue:self.codeTextField.text forKey:@"verify_code"];
    [task startWithParams:params requestType:WDRequestTypePost success:^(id responseObject) {
        WYBaseModel *model = [WYBaseModel modelObjectWithDict:responseObject];
        if ([model.code intValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (![WDAppUtils isBlankString:model.result[kAccessToken]]) {
                    saveObjectToUserDefaults([NSString stringWithFormat:@"%@ %@",model.result[@"token_type"],model.result[kAccessToken]], kAccessToken);
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccessNotification" object:nil];
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                }
//            });
        }else{
            [SVProgressHUD showErrorWithStatus:model.message];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)countdownUpdateMethod:(NSTimer*)theTimer {
    self.countDownSeconds --;
    if (self.countDownSeconds == 0) {
        if (self.countDownTimer != nil) {
            [self.countDownTimer invalidate];
            self.countDownTimer = nil;
        }
        self.getCodeBtn.hidden = NO;
        self.countDownSeconds = 60;
        self.getCodeBtn.enabled = YES;
        self.countDownLabel.text = @"";
        [self.getCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    }else {
        self.countDownLabel.text = [[NSString alloc] initWithFormat:@"%ldS",(long)self.countDownSeconds];
    }
    
}


- (IBAction)getCodeBtnAction:(id)sender {
    if (!self.mailTextField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱"];
        return;
    }
    if (![WDAppUtils isValidateEmail:self.mailTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"邮箱格式有误，请重新输入"];
        return;
    }
    [self getCodeTask];
}

- (IBAction)eyeBtn:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.pwdTextField.secureTextEntry = !btn.selected;
}
- (IBAction)eyeBtnAction2:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.pwdTextField2.secureTextEntry = !btn.selected;
}

- (IBAction)userProtocolBtnAction:(id)sender {
    [[WDPageManager sharedInstance] pushViewController:@"WDWKWebViewController" withParam:@{@"requestURL":@"https://pants.run/service"}];
}

- (IBAction)privacyPolicyBtnAction:(id)sender {
    [[WDPageManager sharedInstance] pushViewController:@"WDWKWebViewController" withParam:@{@"requestURL":@"https://pants.run/policy"}];
}

- (IBAction)registerBtnAction:(id)sender {
    if (!self.mailTextField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱"];
        return;
    }
    if (![WDAppUtils isValidateEmail:self.mailTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"邮箱格式有误，请重新输入"];
        return;
    }
    if (!self.codeTextField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (!self.pwdTextField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    if (!self.pwdTextField2.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请重复您刚输入的密码"];
        return;
    }
    [self registerTask];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 3) {
        [textField resignFirstResponder];
    }else{
        UITextField *customTextField = (UITextField *)[self.view viewWithTag:textField.tag+1 ];
        [customTextField becomeFirstResponder];
        
    }
    return YES;
}

@end
