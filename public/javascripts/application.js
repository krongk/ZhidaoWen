
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