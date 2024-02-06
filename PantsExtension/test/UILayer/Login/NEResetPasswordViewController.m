//
//  NEResetPasswordViewController.m
//  NetworkExtension
//
//  Created by daxiong on 2019/12/9.
//  Copyright © 2019 moonmd.xie. All rights reserved.
//

#import "NEResetPasswordViewController.h"

@interface NEResetPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIView *resetPasswordView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *xinPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPasswordTextField;

@end

@implementation NEResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    
    self.navigationController.navigationBar.translucent = YES;
    UIView *barBack = self.navigationController.navigationBar.subviews[0];
    barBack.backgroundColor = [UIColor clearColor];
    [barBack setAlpha:0];
    
    self.passwordView.layer.cornerRadius = 22.f;
    self.passwordView.layer.masksToBounds = YES;
    self.passwordView.layer.shadowRadius = 10.;
    self.passwordView.layer.shadowOpacity = 0.8;
    self.passwordView.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.passwordView.layer.shadowOffset = CGSizeMake(0,0);
    self.passwordView.layer.masksToBounds = NO;
    
    self.resetPasswordView.layer.cornerRadius = 22.f;
    self.resetPasswordView.layer.masksToBounds = YES;
    self.resetPasswordView.layer.shadowRadius = 10.;
    self.resetPasswordView.layer.shadowOpacity = 0.8;
    self.resetPasswordView.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.resetPasswordView.layer.shadowOffset = CGSizeMake(0,0);
    self.resetPasswordView.layer.masksToBounds = NO;
    
    self.doneBtn.layer.cornerRadius = 25.f;
    self.doneBtn.layer.masksToBounds = YES;
    self.doneBtn.layer.shadowRadius = 10.;
    self.doneBtn.layer.shadowOpacity = 0.8;
    self.doneBtn.layer.shadowColor = WD_a0a0a0_Color.CGColor;
    self.doneBtn.layer.shadowOffset = CGSizeMake(0,0);
    self.doneBtn.layer.masksToBounds = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)eyeBtn1:(UIButton*)btn{
    btn.selected = !btn.selected;
    self.passwordTextField.secureTextEntry = !btn.selected;

}

- (IBAction)eyeBtn2:(UIButton*)btn{
    btn.selected = !btn.selected;
    self.xinPasswordTextField.secureTextEntry = !btn.selected;

}


- (IBAction)eyeBtn3:(UIButton*)btn{
    btn.selected = !btn.selected;
    self.againPasswordTextField.secureTextEntry = !btn.selected;

}

- (IBAction)resetBtnAction:(id)sender {
    if (!self.passwordTextField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入原邮箱"];
        return;
    }
    if (!self.xinPasswordTextField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return;
    }
    if (!self.againPasswordTextField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请重复您刚输入的新密码"];
        return;
    }
    [self resetPasswordTask];
}

- (void)resetPasswordTask
{
    WYTask *task = [[WYTask alloc] initWithURL:[NSString stringWithFormat:@"%@%@/password",URL_RESET_PASSWORD,getObjectFromUserDefaults(kUserId)]];
    NSDictionary *params = @{@"password":self.passwordTextField.text,@"new_password":self.xinPasswordTextField.text,@"repassword":self.againPasswordTextField.text};
    [task startWithParams:params requestType:WDRequestTypePut success:^(id responseObject) {
        WYBaseModel *baseModel = [WYBaseModel modelObjectWithDict:responseObject];
        if ([baseModel.code intValue] != 200) {
            [self toast:baseModel.message];
            return;
        }
        saveObjectToUserDefaults([NSString stringWithFormat:@"%@ %@",baseModel.result[@"token_type"],baseModel.result[kAccessToken]], kAccessToken);
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 2) {
        [textField resignFirstResponder];
    }else{
        UITextField *customTextField = (UITextField *)[self.view viewWithTag:textField.tag+1 ];
        [customTextField becomeFirstResponder];
        
    }
    return YES;
}



@end
