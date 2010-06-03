
// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
 $(document).ready(function(){
    //login form validate
    $("form#loginform").validate();
	//signup form validate
    $("form#yform").validate();
    //add follow form check if login
    $("form.add_follow_form").submit(function(){
       // alert("gdlfd");
       if($("#question_user_id").attr("value") =="0"){login(1);return false;}
       else{}
    });
  });


//below functions is to show ajax login dlg
function show_dlg(){
   var str ="<div id='cover' style='display: none' ><!--遮罩层--></div>  <div id='login' style='display: none'>  	<div style='background-color:#FFCC99; padding:6px;'>用户登录/注册对话框<span style='float:right'>              <a class=closeme href='javascript:hide();' id='dlg_close'>+关闭当前窗体</a></span></div>  	<div id='login_form' style='display: none'><h2>知道问用户登录</h2><hr/>  <form action='/session' class='cmxform' id='loginform' method='post'><div style='margin:0;padding:0;display:inline'><input name='authenticity_token' type='hidden' value='ljjdg7eKyTLsxZue6oxzm4Pijgp2K5haoaBP24SytS4=' /></div><p><label for='login'>请输入登录名：</label><br/>  <input class='required' id='login' name='login' type='text' /></p>  <p><label for='password'>输入你的密码：</label><br/>  <input class='required' id='password' name='password' type='password' /></p>  <p><label for='remember_me'>两周内自动登录:</label>  <input checked='checked' id='remember_me' name='remember_me' type='checkbox' /></p>  <p><input class='button' name='commit' type='submit' value='登录' /><br/>&nbsp;&nbsp;新用户<a href='/signup' onclick='javascript:login(0);return false;'>请在这里注册</a></p>  </form></div>          <div id='signup_form' style='display: none'><h2>快速注册为知道问帐号</h2><hr/>  <div id='reg_form'>       <form action='/users' class='cmxform' id='yform' method='post'><div style='margin:0;padding:0;display:inline'><input name='authenticity_token' type='hidden' value='ljjdg7eKyTLsxZue6oxzm4Pijgp2K5haoaBP24SytS4=' /></div>    <p><label for='email'>电子邮箱：</label>        <input class='required email' id='user_email' name='user[email]' size='30' type='text' /></p>        <p><label for='login'>登录名：</label>        <input class='{required:true,minlength:3}' id='user_login' name='user[login]' size='30' type='text' /></p>        <p><label for='login'>性别：</label>        <select id='user_sex' name='user[sex]'><option value='0'>女</option>  <option value='1'>男</option></select></p>        <p><label for='password'>密码：</label>        <input class='{required:true,minlength:5}' id='user_password' name='user[password]' size='30' type='password' /></p>        <p><label for='password_confirmation'>密码确认：</label>        <input class='{required:true,minlength:5,equalTo:'#user_password'}' id='user_password_confirmation' name='user[password_confirmation]' size='30' type='password' /></p>        <p><input class='button' name='commit' type='submit' value='注 册' />      <br/>&nbsp;&nbsp;老用户<a href='/login' onclick='javascript:login(1);return false;'>请直接点击这里登录</a>      </p>    </form></div></div>  </div>";
  $("div#login_dlg").append(str);
}
function login (n) {
	if(n==1) //login
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