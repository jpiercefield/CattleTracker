
/*var imported = document.createElement('script');
imported.src = '/js/bootbox.min.js';
document.head.appendChild(imported);*/

/*function db_search(){
    $.ajax({
        type:"POST",
        url:"PHP/pfunctions.php",
        dataType:"json",
        cache:false,     
        data: {
            tag_id: $("#db_tag_input").val(),
            animal_id: $("#db_animal_input").val(),
            pasture_num: $("#db_pasture_input").val(),
            herd_num: $("#db_herd_input").val(),
            animal_type: $("#db_type_select").val(),
            type:"db_search",
        },
        success: function(json){
            if($.trim(json.error)) { alert(json.error); return;}  
            trHTML = '<tr class="header"><th style="width:20%;">Tag ID</th><th style="width:20%;">Cow ID</th><th style="width:10%;">Type</th><th style="width:10%;">Weight</th><th style="width:10%;">Herd</th><th style="width:10%;">Pasture</th><th style="width:10%;">Edit</th></tr>';
            $.each(json, function(index, element){
                trHTML += '<tr><td>' + element.tag_id + '</td><td>' + element.animal_id + '</td><td>' +element.a_type + '</td><td>' + element.weight + '</td><td>'  + element.herd_id + '</td><td>' + element.pasture_id +'</td><td><button type= "button" data-id=" '+index+' " class="btn btn-default editButton">Edit</button> </td></tr>';
            });
            $('#db_result_table').html(trHTML);
            
        },
    });
    
}*/

function call_alert(value){
    alert(value);
}