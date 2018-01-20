$(document).ready(function () {
    //To update selection
    $('#dropdown-menu-search').on('click', function(event) {
    	event.stopPropagation();
    	
    });
    $( "#rcom-label").change(function() {
    	$('#search-dd').removeClass('open');
    	var selected=$(this).val();
    	if(selected==0)
    		$('#rcom').val("mbcf");
    	else
    		$('#rcom').val("pb");
    });
    $('#search-btn').click(function(){
    	$('#search-form').submit();
    });
    
    $('.dropdown-menu a').click(function(){
        
        //remove the error border and text
        $(this).closest("div").children('button').removeClass('error-border').removeClass('error-text');
        $(this).closest("div").children('label').removeClass('error-text');
        
        //process the drop down change request
        $text=$(this).text();
        if($(this).attr('class')==="dropdown-reset"){
        	$(this).closest("div").children('button').children('.selected').text(
        			$(this).closest("div").children('button').children('.selected').attr('data'));
        	$(this).closest("div").children('.hidden-input').val("");
    	}
        else{
        	$(this).closest("div").children('button').children('.selected').text($text);
        	$(this).closest("div").children('.hidden-input').val($text)
        }
    });
    $('#btn-signup').click(function(){
    	$('#signupform').submit();
    });
    $('#signupform').submit(function(){
    	$error=false;
    	$('#signupbox .dropdown-toggle').each(function (){
        	if($(this).children('.selected').text()===$(this).children('.selected').attr('data')){
                $(this).addClass('error-border').addClass('error-text');
                $(this).parent().children('label').addClass('error-text');
                $error=true;
            }
        	else{
        		$(this).removeClass('error-border');
        	}
    	})
    	if($error)
    		return false;
    	else
    		return true;
    });
});