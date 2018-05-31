// populating drop down B on selection of A drop down

$(document).on('change','#bug_type_id', function(){
	var status_select = $("#status_id");
   	if($(this).val() == "bug"){
   		var bug_options = ["new", "started", "resolved"];
   		status_select.html("");
   		bug_options.forEach(function(option,index){
   			status_select.append(`<option value='${option}'>${option}</option>`);
   		})
   	}
   	else{
   	var status_options = ["new", "started", "completed"];
   	status_select.html("");
   	status_options.forEach(function(option,index){
   		status_select.append(`<option value='${option}'>${option}</option>`)
   	})
   	// $("#status_id").html("<option value='new'>new</option><option value='new22'>new221	</option>");
   	}
})

// populating drop down B on selection of A drop down
// ::::::::::::::::assigning bug to user ::::::::::::::::

$( document ).on("ready", function() {
   //alert("gggggggggggg")

  $('.assign_bug_button'). on( 'click' , function(){
   //alert("ggsdfsdfdzf")

   complete_id = this.id; 
   var obj = complete_id.split("_");
   id = obj[1];
   assign_bug_to_user(id);
  });

  function assign_bug_to_user(bug_id){

    var path = "bugs/assign_bug";
    $.ajax({
      type: "GET",
      url: path,
      data: {"id" : bug_id},
      success: function( response ) {
       // console.log(response);
       // console.log("success");
       $("#assigned_to_id_"+ bug_id).text(response["name"]);
       $("#bug_status_id_"+ bug_id).text("started"); 
       $("#"+ complete_id).hide();

        $("#"+ complete_id).closest('td').append('<button class="btn btn-success resolved_bug_button" id="res_bug_'+bug_id+'" > Bug Resolved ?</button>');

       console.log(response["name"]);
      }
    });
  }

  $(document).on("click",".resolved_bug_button", function (){
    complete_id = this.id;
    var obj = complete_id.split("_");
    id = obj[2];
    resolve_bug_for_user(id);
  });

  function resolve_bug_for_user(bug_id){
    var path = "bugs/resolved_bug";
    $.ajax({
      type: "GET",
      url: path,
      data: {"id" : bug_id},
      success: function( response ){
        $("#bug_status_id_" + bug_id).text("completed");
        $("#res_bug_"+bug_id).hide();
      }

    });
  }
});