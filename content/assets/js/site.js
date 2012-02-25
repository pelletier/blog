$(document).ready(function(){
    
    /* Update copyright year */
    var now = new Date();
    $('.copyright .now').html(now.getFullYear());

    /* Pictures rollover */
    $('.post img').hover(
    function(event){
        var title = $(this).attr('alt');
        var content = "<div id='imglegend'>"+title+"</div>";
        $(this).after(content);
        $('#imglegend').fadeIn();
        var pos = $(this).offset();
        var t = pos.top + $(this).height() - $('#imglegend').height();
        $('#imglegend').css('top', t);
        $('#imglegend').css('left', pos.left);
        $('#imglegend').css('width', $(this).width() - 40);

    },
    function(event){
        $('#imglegend').fadeOut('slow', function(event){
            $('#imglegend').remove();
        });
    });


    /* Pictures resize */
    var resize_images = function() {
        var w = $('.post').width();
        $('.post img').each(function(){
            if ( $(this).width() > w ) {
                $(this).width('100%');
            }
        });
    }

    $(window).resize(resize_images);
    resize_images(); // In case you have a small window when the page loads

});
