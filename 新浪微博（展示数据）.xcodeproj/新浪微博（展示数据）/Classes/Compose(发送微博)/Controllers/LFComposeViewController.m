//
//  LFComposeViewController.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/16.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFComposeViewController.h"
#import "LFComposeTextView.h"
#import "LFComposeToolBar.h"
#import "LFComposePhotoView.h"
#import "LFComposeTool.h"


#import "MBProgressHUD+MJ.h"

@interface LFComposeViewController ()<UITextViewDelegate,LFComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,weak)LFComposeTextView *textView;
@property (nonatomic,weak)LFComposeToolBar *toolBar;
@property (nonatomic,weak)LFComposePhotoView *photoView;
@property (nonatomic,strong)NSMutableArray *images;
@end

@implementation LFComposeViewController
-(NSMutableArray *)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setNavigationBar];
   
    //添加子控件
    [self setAllChildView];
    //添加图片View
    [self setPhotoView];
}

-(void)setPhotoView{
    LFComposePhotoView *photoView = [[LFComposePhotoView alloc]initWithFrame:CGRectMake(0, 100, self.view.width, self.view.height-100)];
    _photoView = photoView;
    [_textView addSubview:photoView];
}
/**
 *  添加所有子控件
 */
-(void)setAllChildView{
    //因为需求要求要有placeholder 和 文本域，以及能拖拽，系统的控件不能满足上述要求，所以自定义控件继承自textView
    LFComposeTextView *textView = [[LFComposeTextView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [textView becomeFirstResponder];
    textView.delegate = self;
    _textView = textView;
    
    [self.view addSubview:textView];
    
    //添加工具条
     CGFloat toolBarH = 35;
    LFComposeToolBar *toolBar = [[LFComposeToolBar alloc]initWithFrame:CGRectMake(0, self.view.height-toolBarH, self.view.width, toolBarH)];
    toolBar.delegate = self;
    _toolBar = toolBar;
    [self.view addSubview:toolBar];
    
    
    //添加键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
   
    
    

}
-(void)keyBoardChange:(NSNotification*)noti{
    CGRect  keyboardFrame =  [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (keyboardFrame.origin.y < self.view.height) {
       
        [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height);
        }];
    }else{
        [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            self.toolBar.transform = CGAffineTransformIdentity;
        }];
    }
    
}
/**
 *  设置导航条
 */
-(void)setNavigationBar{
    //设置titile
    self.title = @"发微博";
    //设置右边item
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [rightBtn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //设置左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
}
-(void)compose{
    if (!self.images.count) {
        [self composeText];
    }else{
        [self composeImage];
    }
}
-(void)composeText{
    [LFComposeTool composeTextUrl:nil parameters:self.textView.text success:^{
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送成功"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送失败"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
-(void)composeImage{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    NSString *weibo = self.textView.text.length?self.textView.text:@"分享图片";
    [LFComposeTool composeImageWithImage:self.images[0] weibo:weibo success:^{
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送成功"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } failure:^(NSError *error) {
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送失败"];
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
/**
 *  取消按钮点击
 */
-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --<LFComposeToolBarDelegate>--点击工具条按钮时触发
-(void)composeToolBar:(LFComposeToolBar*)composeToolBar didClickBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 0:
        {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
             break;
        }
           
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;

        default:
            break;
    }
    
}
#pragma mark ---<UITextViewDelegate>--文字发生改变时触发
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length) {
        _textView.ishidden = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else{
        _textView.ishidden = NO;
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}
#pragma mark -- <UIScrollViewDelegate>--滚动时触发
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textView resignFirstResponder];

}
#pragma mark -- <UIImagePickerDelegate>--点击照片时触发
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.images addObject:image];
     self.photoView.image= image;
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
