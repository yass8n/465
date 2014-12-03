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
//= require turbolinks
//= require foundation
//= require_tree .
$(function() {
  initPage();
  $(document).foundation();
});
$(window).bind('page:load', function() {
  initPage();
});
function initPage() {
  set_filter_image();
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
	if ($('.alert div').html() == "Sorry, your account has previously been deleted."){
		$('.alert div').html("Sorry, your account has previously been deleted...<a href='recover'>Recover Account</a>")
	}

	//to show the post comment form and the answer comment form
	$('.comment_on_answer').on('click', function(){
		$('.answer_comment_form').removeClass('hidden');
		$(this).addClass('hidden');
	});

	$('#comment_on_post').on('click', function(){
		$('#post_comment_form').removeClass('hidden');
		$(this).addClass('hidden');
	});


	$('#filter-image').on('click', function(){
		$('#filters-on').toggleClass('hidden');
	});
	$('#answered_true, #answered_false, #filter_rating, #filter_views, #filter_recent').on('click', function(){ 
		set_filter_image();
    });
    $('#up-arrow, #down-arrow').on('mouseout', function(){
    	$(this).attr("src", "/images/arrow_hollow.png");
    });
    $('#up-arrow, #down-arrow').on('mouseover', function(){
    	$(this).attr("src", "/images/arrow.png");
    });
    function set_filter_image(){
	    var checked = false;
		var src = "https://cdn2.iconfinder.com/data/icons/windows-8-metro-style/128/empty_filter.png"
		$('#answered_true, #answered_false, #filter_rating, #filter_views, #filter_recent').each(function(){
			//empty filter
	        if((this).checked) {
	            checked = true;
				src = "https://cdn2.iconfinder.com/data/icons/windows-8-metro-style/128/filled_filter.png"
				//full filter
	        }
	        $('#filter-image').attr("src", src);
	    });
    }
}