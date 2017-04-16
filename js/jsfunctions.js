$(document).ready(function(){

    jQuery.support.cors = true;

    $.ajax(
    {
        type: "POST",
        url: "pfunctions.php",
        dataType: "json",
        cache: false,
        data:{
						type:"30",
		  },
        success: function (json) {
            
         var trHTML = '';
           if($.trim(json.error)) { alert(json.error); return;}           
         $.each(json, function(index, element){
            trHTML += '<tr><td>' + element.ref_id + '  </td><td>' + element.last_visit_date + '  </td></tr>';
        });
               
        $('#tbl30-content').append(trHTML);
        
        },
    })
})