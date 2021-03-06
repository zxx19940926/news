<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<%@ include file="/bizBase.jsp"%>
<head>
<meta charset="utf-8">
<title>首页</title>
<!-- ICO -->
<link rel="icon" href="favicon.ico" type="image/x-icon"/>
<link rel="Shortcut Icon"  href="favicon.ico" type="image/x-icon">

<!--skin-->
<link rel="stylesheet" type="text/css" href="css/admin-all.css" />
<link rel="stylesheet" type="text/css" href="css/base.css" />
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/ui-lightness/jquery-ui-1.8.22.custom.css" />
<script type="text/javascript" src="js/index.js"></script>
<script type="text/javascript">
var year = 0;
var urlAction = "";
var dUrl = "";
var classifyType = "all";
$(document).ready(function(){
	var hi = $(document).height()*0.75;
	$("#showBody").css({
		"max-height":hi+"px",
		"overflow":"auto"
	});
	$("#modalBody").css({
		"max-height":hi+50+"px"
	});
	$("#yearUl").find("li").click(function(){
		var y = $(this).attr("id");
		if(y == "dro"){
			if(year == 0 || year=="dro"){
				year = $("#yearUl").find("li").eq(2).attr("id");
			}
			window.location = dUrl+"?yearesQuery="+year;
		}else{
			year = y;
			var u = urlAction+"?yearsQuery="+year+"&classifyType="+classifyType;
			console.log("xx:"+u);
			u = encodeURI(u);
			$("#countFrame").attr("src",u);
		}
	});
});
//模态
function showModal(){
	var wWidth = $(window).width();
	var wHeight = $(window).height()-10;
	$("body").append("<div id=smartWighthiddenShowModalDisplayDiv style='position:absolute;left:0px;top:0px;width:"+wWidth+"px;height:"+wHeight+"px;background:rgba(0,0,0,.9);z-index:3000;'></div>");
}
//取消模态
function cancelModal(){
	$('body').find("#smartWighthiddenShowModalDisplayDiv").remove();
}
function showT(url){
	showModal();
	$.post(url,function(data){
		$("#showBody").html(data);
		$(".breadcrumbs").hide();
		$("#detail").addClass("detailNone");
		//$("#print").remove();
	});
	$("#showTemplate").slideDown(800);
}
function hideT(){
	cancelModal();
	$("#showTemplate").hide();
	$("#showBody").empty();
}
function showCount(url,downloadUrl,jsonArray){
	urlAction = url;
	dUrl = downloadUrl;
	$("#yearUl").find("li").each(function(i){
		if($("#yearUl").find("li").length!=(i+1)){
			year = $(this).attr("id");
			$(this).removeClass("active");
		}
	});
	$("#yearUl").find("li").eq(2).addClass("active");
	$("#classifyList").html('<a href="#" class="list-group-item active" id="all">全部</a>');
	//
	if(jsonArray!=null && jsonArray.length>0){
		for(var i=0;i<jsonArray.length;i++){
			$("#classifyList").append('<a href="#" class="list-group-item" id="'+jsonArray[i].val+'">'+jsonArray[i].name+'</a>');
		}
	}
	if($("#classifyList").find("a").length > 1){
		$("#classifyList").find("a").click(function(){
			$("#classifyList").find("a").removeClass("active");
			$(this).addClass("active");
			classifyType = $(this).attr("id");
			var cUrl = url + "?yearsQuery="+year + "&classifyType="+classifyType;
			cUrl = encodeURI(cUrl);
			$("#countFrame").attr("src",cUrl);
		});
	}
	
	$("#countFrame").attr("src",url);
	showModal();
	$("#showCount").slideDown(800);
}
function hideCount(){
	cancelModal();
	$("#showCount").hide();
}
function showAdmin(){
	showModal();
	$("#showAdmin").slideDown(800);
}
function hideA(){
	$("#showAdmin").hide();
	cancelModal();
}
</script>
</head>

<body>
<div class="warp"> 
  <!--头部开始-->
  <div class="top_c">
    <div class="navbar navbar-inverse" style="background: none;border: none;">
      <div class="navbar-inner">
        <div class="container-fluid"><span class="brand"><img src="images/logo.png"></span>
          <div class="top-menu">
            <ul class="top-menu-nav">
              <li><a href="#">当前登录人： <s:property value="%{#session.loginUser.trueName}"/><i class="tip-up"></i></a>
                <ul class="kidc">
                  <li><a href="#" onclick="showAdmin();">技术人员</a></li>
              	  <li><a href="download_download">下载使用手册</a></li>
                </ul>
              </li>
              <li><a href="user_logout">[注销]</a></li>
            </ul>
          </div>
        </div>
        <!--/.container-fluid--> 
      </div>
      <!--/.navbar-inner--> 
    </div>
  </div>
  <!--头部结束--> 
  <!--左边菜单开始-->
  <div class="left_c left">
    <h1>系统操作菜单</h1>
    <div class="acc">
      <div> <a class="one current" href="info_queryAllInfo" target="main-iframe">首页</a> </div>
      <div> <a class="one">新闻信息发布<img src="images/toggle-subnav-down.png" alt=""></a>
        <ul class="kid">
          <li><b class="tip"></b><a href="news_queryAllNews" target="main-iframe">新闻信息发布</a></li>
          <c:if test="${loginUser.userCode eq '00000'}">
          	<li><b class="tip"></b><a href="anews_approvedNews" target="main-iframe">新闻信息审核</a></li>
          </c:if>
        </ul>
      </div>
      <div> <a class="one">工作上报<img src="images/toggle-subnav-down.png" alt=""></a>
        <ul class="kid">
       
           <li style="padding:0px;border-bottom:1px;">
          	<b ></b><a class="one" style="padding:4px 4px 4px 10px;">法制信息<img src="images/toggle-subnav-down.png" alt=""></a>
          	<ul class="kid">
          		 <li><b class="tip"></b><a href="laws_queryAllLaws" target="main-iframe">地方性法规</a></li>
		         <li><b class="tip"></b><a href="regular_queryAllRegular" target="main-iframe">地方政府规章</a></li>
		         <li><b class="tip"></b><a href="document_queryAllDocument" target="main-iframe">规范性文件</a></li>
		         <li><b class="tip"></b><a href="lstandards_queryAllLstandards" target="main-iframe">地方标准</a></li>
          	</ul>
          </li>
         
           <li style="padding:0px;border-bottom:1px;">
          	<b ></b><a class="one" style="padding:4px 4px 4px 10px;">工作机构和人员<img src="images/toggle-subnav-down.png" alt=""></a>
	        <ul class="kid">
	          <li><b class="tip"></b><a href="lawagency_queryAllLawagency" target="main-iframe">工作机构</a></li>
	          <li><b class="tip"></b><a href="enforcement_queryAllEnforcement" target="main-iframe">行政队伍</a></li>
	        </ul>
          </li>
          
          <li style="padding:0px;border-bottom:1px;">
          	<b ></b><a class="one"  style="padding:4px 4px 4px 10px;">法制宣传<img src="images/toggle-subnav-down.png" alt=""></a>
	        <ul class="kid">
	          <li><b class="tip"></b><a href="propaganda_queryAllPropaganda" target="main-iframe">法制宣传</a></li>
	          <li><b class="tip"></b><a href="train_queryAllTrain" target="main-iframe">法制培训</a></li>
	        </ul>
          </li>
        </ul>
      </div>
      <div> <a class="one">系统管理<img src="images/toggle-subnav-down.png" alt=""></a>
        <ul class="kid">
          <c:if test="${loginUser.privilege ne 3}">
          	<li><b class="tip"></b><a href="user_queryAllUser" target="main-iframe">管理员信息</a></li>
          	<li><b class="tip"></b><a href="province_queryAllProvince" target="main-iframe">机构管理</a></li>
          </c:if>
          <li><b class="tip"></b><a href="user_toUpdate" target="main-iframe">修改密码</a></li>
        </ul>
      </div>
      
    </div>
  </div>
  <!--左边菜单结束--> 
  <!--右边框架开始-->
  
  <div class="right_c">
    <div class="nav-tip" onclick="javascript:void(0)">&nbsp;</div>
  </div>
  <script type="text/javascript">
function adjustIFramesHeightOnLoad(iframe) {
	
	/* var iframeHeight= (iframe.contentWindow.window.document.documentElement.scrollHeight, iframe.contentWindow.window.document.body.scrollHeight);

	$(iframe).height(iframeHeight); */
	
	//alert(iframeHeight);
}
</script>
  <div class="Conframe">
    <div class="iframe-box">
      <iframe name="main-iframe" id="frame_content" class="main-iframe" src="info_queryAllInfo" frameborder="0" scrolling="no" allowtransparency="true" style="background-color:transparency;min-width: 1000px;overflow: auto;" onLoad="adjustIFramesHeightOnLoad(this)"></iframe>
      <script type="text/javascript">
           //注意：下面的代码是放在和iframe同一个页面调用,放在iframe下面
           $("#frame_content").load(function () {
               var mainheight = $(this).contents().find("body").height() + 30;
               $(this).height(mainheight);
           });
       </script>
    </div>
  </div>
  
  <!--右边框架结束--> 
  
  <!--底部开始--> 
  <!--<div class="bottom_c"></div>--> 
  <!--底部结束--> 
</div>
<div id="showTemplate" class="modal fade in" style="z-index: 3050;">
  <div class="modal-dialog" style="width: 1050px;"> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" onclick="hideT();">&times;</button>
        <h4 class="modal-title">预览</h4>
      </div>
      <div class="modal-body" id="modalBody">
      	<div style="width: 100%;" id="showBody"></div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>
<div id="showCount" class="modal fade in" style="z-index: 3050;">
  <div class="modal-dialog" > 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" onclick="hideCount();">&times;</button>
        <h4 class="modal-title">统计</h4>
      </div>
      <div class="modal-body" style="height: 600px;">
      	<ul class="nav nav-tabs" id="yearUl">
		  <li id="${yearsQuery-2}"><a href="#home" data-toggle="tab">${yearsQuery-2}</a></li>
		  <li id="${yearsQuery-1}"><a href="#home" data-toggle="tab">${yearsQuery-1}</a></li>
		  <li id="${yearsQuery}"class="active"><a href="#home" data-toggle="tab">${yearsQuery}</a></li>
		  <li class="dropdown pull-right" id="dro"><a href="#">下载Excel</a></li>
		</ul>
		<div id="myTabContent" class="tab-content">
        	<div class="tab-pane fade active in form-inline" id="home">
	        	<div class="form-group" style="vertical-align: top;margin-top: 10px;">
	        		<div class="list-group" style="width: 153px;" id="classifyList">
					</div>
	        	</div>
        		<div class="form-group">
        			<iframe frameborder="0" id="countFrame" style="height:500px;width:400px; overflow: auto;"></iframe>
        		</div>
        	</div>
      	</div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>
<div id="showAdmin" class="modal fade in" style="z-index: 3050;">
  <div class="modal-dialog" > 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" onclick="hideA();">&times;</button>
        <h4 class="modal-title">帮助</h4>
      </div>
      <div class="modal-body">
      	<h4>技术人员姓名：<small>xxx</small></h4><br/>
      	<h4>技术人员电话：<small>110</small></h4>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>
<!--[if lt IE 9]>
<script src="js/ie/html5.js"></script>
<script src="js/ie/excanvas.min.js"></script>
<script src="js/ie/css3-mediaqueries.js"></script>
<![endif]-->
</body>
</html>