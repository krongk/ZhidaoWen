
// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
 $(document).ready(function(){
    //添加表单用户登录验证
    $("#loginform").validate();
	//添加表单用户注册验证
    $("#yform").validate();
  });

function login (n) {
	if(n==1) //signup
	{
    document.getElementById('cover').style.display='block';
	document.getElementById('login').style.display='block';
	document.getElementById('login_form').style.display='block';
	document.getElementById('signup_form').style.display='none';
	return false;
	}else{ //login
	document.getElementById('cover').style.display='block';
	document.getElementById('login').style.display='block';
	document.getElementById('login_form').style.display='none';
	document.getElementById('signup_form').style.display='block';
	return false;
	}
}
function hide () {   
    document.getElementById('login').style.display='none'
	document.getElementById('cover').style.display='none'
}
function show_ico(){
	document.getElementById('goHome').style.display='block'
}