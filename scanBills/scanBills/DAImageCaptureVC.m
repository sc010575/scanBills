//
//  DAImageCaptureVC.m
//  scanBills
//
//  Created by Suman Chatterjee on 03/05/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DAImageCaptureVC.h"
#import <UIKit/UIView.h>
#import <ImageIO/CGImageProperties.h>
#import <AVFoundation/AVFoundation.h>
#import "DASaveMyBillsVC.h"

@interface DAImageCaptureVC ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) AVCaptureMetadataOutput *output;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (weak, nonatomic)   IBOutlet UIButton *scanBtn;
@property (strong, nonatomic) UIImage * scannedImage;
@property (strong, nonatomic) UIView  *highlightView;
@property (strong, nonatomic) NSString *barCodeValue;

- (IBAction)captureImage:(id) sender;

@end

@implementation DAImageCaptureVC
{
    
}

#pragma mark AVCaptureSession and camera

- (void)startCamera
{
	// Create the AVCapture Session
    
    if(self.session)
        [self stopCamera];
    
	self.session = [[AVCaptureSession alloc] init];
	
	// create a preview layer to show the output from the camera
	self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
	self.previewLayer.frame = self.view.frame;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	[self.view.layer addSublayer:self.previewLayer];
    [self.view bringSubviewToFront:self.scanBtn];
	
	// Get the default camera device
	AVCaptureDevice* camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	
	// Create a AVCaptureInput with the camera device
	NSError *error=nil;
	AVCaptureInput* cameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:camera error:&error];
	if (cameraInput == nil) {
		NSLog(@"Error to create camera capture:%@",error);
	} else {
        [self.session addInput:cameraInput];
        [self.session setSessionPreset:AVCaptureSessionPresetPhoto];
        
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [_session addOutput:_output];
        _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
        
        self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
        [self.stillImageOutput setOutputSettings:outputSettings];
        
        [self.session addOutput:self.stillImageOutput];

        [self.session startRunning];
    }
    [self.view bringSubviewToFront:_highlightView];
}


- (void)stopCamera
{
    [self.session stopRunning];
    self.session = nil;
    
    [self.previewLayer removeFromSuperlayer];
    self.previewLayer = nil;
}


#pragma mark - view preparation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopCamera];
    self.scannedImage = nil;
    [super viewWillDisappear:YES];
    self.scanBtn.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.scannedImage = nil;
    self.scanBtn.hidden = YES;
    [self createHighlightView];
    [self startCamera];
    
}

- (void) createHighlightView
{
    _highlightView = [[UIView alloc] init];
    _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _highlightView.layer.borderColor = [UIColor greenColor].CGColor;
    _highlightView.layer.borderWidth = 3;
    [self.view addSubview:_highlightView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - button action events


- (IBAction)captureImage:(id) sender{
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
    
    //NSLog(@"about to request a capture from: %@", stillImageOutput);
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
//         CFDictionaryRef exifAttachments = CMGetAttachment( imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
         if(imageSampleBuffer != nil){
             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
             self.scannedImage = [[UIImage alloc] initWithData:imageData];
             [self performSegueWithIdentifier:@"saveMyBill" sender:sender];
         }
         
     }];
}

#pragma mark - AVCaptureConnection delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[self.previewLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        
        if (detectionString != nil)
        {
            _barCodeValue = detectionString;
            self.scanBtn.hidden = NO;
            [self.view bringSubviewToFront:self.scanBtn];
            break;
        }
        else
            _barCodeValue = @"Not found";
    }
    
    _highlightView.frame = highlightViewRect;
}



#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"saveMyBill"])
    {
        return (self.scannedImage != nil)?YES:NO;
    }
    return YES;
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueIdentifier = [segue identifier];
    
    if ([segueIdentifier isEqualToString:@"saveMyBill"])
    {
        if (self.scannedImage != nil)
        {
            DASaveMyBillsVC *saveMyBillVC = segue.destinationViewController;
            saveMyBillVC.imageToDisplay = self.scannedImage;
            saveMyBillVC.barCodeValue = self.barCodeValue;
        }
        
    }
}


@end
