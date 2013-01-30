package {
	import flash.net.FileReference;
        import flash.utils.ByteArray;
        import FileItem;
        import flash.events.*;
        import flash.external.ExternalInterface;
        import flash.net.URLRequest;
        import flash.net.URLRequestHeader;
        import flash.net.URLRequestMethod;
        import flash.net.URLVariables;
        import flash.net.URLLoader;
        
	internal class PostFile { 
		
                private var url:String;
                private var file:FileItem;
                private var file_post_name:String;
                private var swfupload:*;
		public function PostFile(url:String,file:FileItem,file_post_name:String,swfupload:*):void {
                    this.url = url;
                    this.file = file;
                    this.file_post_name = file_post_name;
                    this.swfupload = swfupload;
		}

                public function upload(data:ByteArray):void {
                    var boundary:String = "---------------------------7d4a6d158c9";                     
                    var req:URLRequest = new URLRequest(this.url);
                    var dataToPost:ByteArray = new ByteArray();
                    dataToPost.writeUTFBytes('--');
                    dataToPost.writeUTFBytes(boundary);
                    dataToPost.writeUTFBytes("\r\n");
                    dataToPost.writeUTFBytes("Content-Disposition: form-data; name=\""+this.file_post_name+"\"; filename=\""+this.file.file_reference.name+"\"\r\n");
                    dataToPost.writeUTFBytes("Content-Type: application/octet-stream\r\n\r\n");
                    dataToPost.writeBytes(data);//文件
                    dataToPost.writeUTFBytes("\r\n--" + boundary + "--\r\n");//结束
                    
                    //设置头信息
                    //req.contentType = 'multipart/form-data; boundary='+boundary;
                    req.requestHeaders.push(new URLRequestHeader('Content-Type', 'multipart/form-data; boundary=' + boundary));

                    req.method = URLRequestMethod.POST
                    req.data = dataToPost;
                    var loader:URLLoader = new URLLoader();
                    loader.addEventListener(Event.COMPLETE, uploadComplete);
                    loader.addEventListener(IOErrorEvent.IO_ERROR, BigUploadFailed);
                    loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,secFailed);
                    loader.addEventListener(ProgressEvent.PROGRESS ,progress)
                    loader.load(req);
                }
                

                public function uploadComplete(e:Event):void {
                    this.swfupload.newCallBack(this.file,e.target.data);
                }

                public function BigUploadFailed(e:IOErrorEvent):void {
                    this.swfupload.Common_Error_Handler(this.file,e);
                }
                public function secFailed(e:SecurityErrorEvent):void {
                    this.swfupload.CommonSecurityError_Handler(this.file,e);
                }


                public function progress(e:ProgressEvent):void {
                                
                    this.swfupload.CommonFileProgress_Handler(this.file,e);
                }
	}
}
