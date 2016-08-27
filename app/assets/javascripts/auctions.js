	$(document).ready(function() {
	// disable auto discover
		Dropzone.autoDiscover = false;
		$("#owl-example").owlCarousel();

		$("#agree_button").click(function() {
  		   $("#guidelines").fadeOut();
  		   $("#auction-form").delay(300).fadeIn(800);
		});
		$('#auction_category').change(function() {
    		 if ($('#auction_category :selected').text() === "Pendant") {
    			$("#dry-pipe-options").hide()
    			$("#rig-options").hide()
    			$("#accessories-options").hide()
    			$("#pendant-options").show()
    		} else if ($('#auction_category :selected').text() === "Accessories") {
    			$("#pendant-options").hide()
    			$("#dry-pipe-options").hide()
    			$("#rig-options").hide()
    			$("#accessories-options").show()
    		} else if ($('#auction_category :selected').text() === "Dry Pipe") {
    			$("#pendant-options").hide()
    			$("#rig-options").hide()
    			$("#accessories-options").hide()
    			$("#dry-pipe-options").show()
    		} else if ($('#auction_category :selected').text() === "Rig") {
				$("#pendant-options").hide()
    			$("#dry-pipe-options").hide()
    			$("#accessories-options").hide()
    			$("#rig-options").show()

    		}  

    	});


	    // grap our upload form by its id
		$("#new_auction").dropzone({
		// restrict image size to a maximum 1MB
			maxFilesize: 20,
			dictDefaultMessage: false,
			autoProcessQueue: false,
  			uploadMultiple: true,
        	parallelUploads: 100,
        	maxFiles: 4,
		// changed the passed param to one accepted by
			previewsContainer: '#dropzonePreview',
			paramName: "attachment",
		// show remove links on each image upload
			addRemoveLinks: true,
			clickable: '#dropzone-click-target',
			init: function(){
				var myDropzone = this;

				this.on('addedfile', function(file) {
					$("#create_auction").removeAttr('disabled').removeClass('disabledbtn');
					$("#hide1").hide(); 
					$("#hide2").hide();   
					$(".add-more-images").show();   // Called when a file is added to the list.    
		    	});

		    	$('#new_auction').on('submit', function(e){
		    		e.preventDefault();
    				e.stopPropagation();
    				myDropzone.processQueue();
    				$("#create_auction").hide();
    				$("#auction_submitted").show();
    				var form = $(this);
    				var post_url = form.attr('action');
    				var post_data = form.serialize();
				});
		        this.on('success', function(file, responseText) { 
		        	window.location.href = responseText.fileID;      // Called when file uploaded successfully.     

		    	});
	   		} 

		});	
	});