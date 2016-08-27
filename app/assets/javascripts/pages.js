	$(document).ready(function() {
		
		$("div.toggle-dropdown.left").click(function() {
  		 	$(".drop-down-menu").show();
		});

		$(document).mouseup(function (e)
		{
    		var container = $(".drop-down-menu");

    		if (!container.is(e.target) // if the target of the click isn't the container...
        	&& container.has(e.target).length === 0) // ... nor a descendant of the container
    		{
        		container.hide();
    		}
		});
	});