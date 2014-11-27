// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(document).ready(function(){
	// for states and countries
	if ($('#user_country').val() == "US") {
		$('#states').removeClass('hidden')
	}
	if ($('#user_country').val() != "US") {
		$('#states').addClass('hidden')
	}
	$('#user_country').on('change', function(){
		if ($(this).val()=="US"){
			$('#states').removeClass('hidden')
		}
		else {
			$('#states').addClass('hidden')
		}
	});

	//adding link to end of alert when a deleted user tries to sign in again
	if ($('.alert').html() == "Sorry, your account has previously been deleted."){
		$('.alert').html("Sorry, your account has previously been deleted...<a href='recover'>Recover Account</a>")
	}

	//to show the post comment form
	$('#comment_on_post').on('click', function(){
		$('#post_comment_form').removeClass('hidden');
	});

});
