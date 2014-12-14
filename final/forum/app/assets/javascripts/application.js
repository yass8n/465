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
//= require jquery-ui/effect.all
//= require turbolinks
//= require foundation
//= require jquery-ui/autocomplete
//= require foundation-wysihtml5
//= require foundation-wysihtml5/locales
//= require_tree .
$(function() {
  initPage();
  $(document).foundation();
});
$(window).bind('page:load', function() {
  initPage();
});
function initPage() { 
	 // window['rangy'].initialized = false
    $('#answer_answer').wysihtml5();
    $('#post_content').wysihtml5({
    // toolbar: { code: '<a class="button secondary" data-wysihtml5-command="code" title="Add Code" tabindex="-1" href="javascript:;" unselectable="on">Code</a>' }
	});
    setTimeout(function(){ 
	    $('.wysihtml5-sandbox').css({ 'height' : '150px' , 'resize' : 'both', 'min-height' : '150px'});
	    $('.fa-list').attr('class', 'fi-list');
	    $('.fa-th-list').attr('class', 'fi-list-thumbnails');
	    $('.fa-dedent').attr('class', 'fi-indent-less');
	    $('.fa-indent').attr('class', 'fi-indent-more');
	    $('.fa-picture-o').attr('class', 'fi-photo');
	    $('.fa-link').attr('class', 'fi-link');


	    	//setting the height of the user-information div to be 100% of the parent div
		$('.content-border').each(function(){
			var height = $(this).height();
			height = parseInt(height).toString() + "px";
			var div = $(this).children()[0];
			$(div).css('height', height);
		});
    }, 1);
    // $('.wysihtml5-toolbar').find('[data-wysihtml5-command="code"]').click(function(){
    	// var currentVal = $('.wysihtml5-editor');
     //    currentVal.prepend("<div>asdasddddddd</div>");   
     //    currentVal.hide();
    	// currentVal.html("Aaaaaaaaaaaaaaaaaaaaaaaaa");
    	// console.log(currentVal);
    	// $('#_wysihtml5-undo').prepend("aaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    	// $('.wysihtml5-editor').appendTo( "<code></code>" );
    // });
    $('input[name=resource]').change(function() {
    	if($(this).val() == 'Users'){
			var usernames = $('#search-form').data('usernames');
		    $("#title").autocomplete({
		      source: usernames
		    });
    		$("#title").autocomplete( "enable" ); 
    	} else{
    		$("#title").autocomplete( "disable" );
    	}
    });
	url = $(location).attr('href');
	if (url.indexOf("Lookup") > -1){ //the user just searched a title, so highlight the matches
		highlight_matches();
	}
	if (url.indexOf('/users/sign_in') > -1 || $('.registration').length ){
		$('footer').css('bottom', '-120px')
	}
	if ($('#error_explanation').length){
		$('img[alt="Questionmark"]').hide()
	}
	if ($('#sign-up').hasClass('hidden')){
		$('#sign-up').show('highlight');
	}
	if ($('#sign-in').hasClass('hidden')){
		$('#sign-in').show('highlight', 2000);
	}
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
	//getting rid of the "you are already signed in message"...changing it to "Signed in successfully"
	if ($('.alert div').html() == "You are already signed in."){
			$('.alert-box').hide();
		}

	//adding link to end of alert when a deleted user tries to sign in again
	if ($('.alert div').html() == "Sorry, your account has previously been deleted."){
		$('.alert div').html("Sorry, your account has previously been deleted...<a href='recover'>Recover Account</a>")
	}

	//to show the post comment form and the answer comment form
	$('.comment_on_answer').on('click', function(){
		$(this).parents('div').next('.answer_comment_form').show('blind')
		$(this).hide();
	});

	$('#comment_on_post').on('click', function(){
		$('#post_comment_form').show('blind')
		$(this).hide();
	});


	$('#filter-image').click(function(){
		$('#filters-on').removeClass('hidden');
	});
	$('#title-search').focusin(function() {
		$('#filters-on').addClass('hidden');
	});
    $('#up-arrow, #down-arrow').on('mouseout', function(){
    	$(this).attr("src", "/images/arrow_hollow.png");
    });
    $('#up-arrow, #down-arrow').on('mouseover', function(){
    	$(this).attr("src", "/images/arrow.png");
    });
    $('.close').click(function(){
    	$(this).parents('.alert-box').hide('blind');
    });
  $('.rating_score').each(function(){
  	    var rating = $(this).html();
    	if (parseInt(rating) < 0){
    		$(this).parent().parent().parent().css("background-color", '#cf2a0e');
    	} else if (parseInt(rating) > 0){
    		$(this).parent().parent().parent().css("background-color", '#00FF40');
    	}
    });
  	$('#answered_true, #answered_false, #filter_rating, #filter_views, #filter_recent, #filter_oldest').on('click', function(){ 
		set_filter_image();
    });

    function highlight_matches(){
    	var search_query = $(location).attr('href').replace(/.*title=/, ""); //replaces everything before "title"
		search_query = search_query.replace(/&.*/, ""); //replaces everything after '&' that is right after title
		var reg = new RegExp(search_query,"gi"); //creating a regex that matches teh search query globally and case insensitive
    	$('.post_title a').each(function(){
    		$(this).html($(this).html().replace(reg, "<span class='highlight'>" + search_query + "</span>"));
    	});
    }
    function set_filter_image(){
	    var checked = false;
		var src = "https://cdn2.iconfinder.com/data/icons/windows-8-metro-style/128/empty_filter.png"
		$('#answered_true, #answered_false, #filter_rating, #filter_views, #filter_recent, #filter_oldest').each(function(){
			//empty filter
	        if((this).checked) {
	            checked = true;
				src = "https://cdn2.iconfinder.com/data/icons/windows-8-metro-style/128/filled_filter.png"
				//full filter
	        }
	        $('#filter-image').attr("src", src);
	    });
    }


    // Tooltip only Text
	$('#filter-image').hover(function(){
		        // Hover over code
		        var title = $(this).attr('title');
		        $(this).data('tipText', title).removeAttr('title');
		        $('<p class="tooltip"></p>')
		        .text(title)
		        .appendTo('body')
		        .fadeIn('slow');
		}, function() {
		        // Hover out code
		        $(this).attr('title', $(this).data('tipText'));
		        $('.tooltip').remove();
		}).mousemove(function(e) {
		        var mousex = e.pageX + 20; //Get X coordinates
		        var mousey = e.pageY + 10; //Get Y coordinates
		        $('.tooltip')
		        .css({ top: mousey, left: mousex })
		});
		if ($('.first-login').length){
			        $('#nav-button')
			        .after('<p class="tooltip smalltip instruction"><i class="step fi-fast-forward bigger-arrow "></i><br><span class="float-left">Edit Account and add a paypal email to start making MONEY! <span></p>');
			        $('.instruction').hide();
			        setTimeout(function(){ $('.instruction').show('highlight', 1000) }, 500);
			        setTimeout(function(){ 
			        	$('.instruction').hide('explode', 1000) 
			    }, 20000);
		    };
	    $('.instruction').click(function(){
	    	setTimeout(function(){ 
	    		$('.instruction').hide('explode', 1000);
	    	}, 500);
	    });
}
