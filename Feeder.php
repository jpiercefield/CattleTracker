
<!DOCTYPE html>
<? php
include_once 'PHP/pfunctions.php'
echo '<p> Duhhh </p>';
?>

<html>
<head>
    
  <meta name="viewport" content ="width=device-width,initial-scale=1,user-scalable=yes" />
  <meta charset="UTF-8">
  <title>Feeder - Cattle Tracker</title>
  
  
  
<style type="text/css">

/***************-----START TOOLBAR-----***************/
/* NOTE: The styles were added inline because Prefixfree needs access to your styles and they must be inlined if they are on local disk! */
*, *:after, *:before {
  box-sizing: border-box;
}

.animenu__toggle {
  display: none;
  cursor: pointer;
  background-color: #134;
  border: 0;
  padding: 10px;
  height: 40px;
  width: 40px;
}
.animenu__toggle:hover {
  background-color: #0186ba;
}

.animenu__toggle__bar {
  display: block;
  width: 20px;
  height: 2px;
  background-color: #fff;
  transition: 0.15s cubic-bezier(0.75, -0.55, 0.25, 1.55);
}
.animenu__toggle__bar + .animenu__toggle__bar {
  margin-top: 4px;
}

.animenu__toggle--active .animenu__toggle__bar {
  margin: 0;
  position: absolute;
}
.animenu__toggle--active .animenu__toggle__bar:nth-child(1) {
  transform: rotate(45deg);
}
.animenu__toggle--active .animenu__toggle__bar:nth-child(2) {
  opacity: 0;
}
.animenu__toggle--active .animenu__toggle__bar:nth-child(3) {
  transform: rotate(-45deg);
}

.animenu {
  display: block;
}
.animenu ul {
  padding: 0;
  list-style: none;
  font: 0px 'Open Sans', Arial, Helvetica;
}
.animenu li, .animenu a {
  display: inline-block;
  font-size: 15px;
}

/* Menu Bar Text */
.animenu a {
  color: #cccc99;
  text-decoration: none;
}

.animenu__nav {
  background-color: #134;
  position: relative;
}
.animenu__nav > li {
  position: relative;
  border-right: 1px solid #666633;
}
.animenu__nav > li > a {
  padding: 10px 40px;
  text-transform: uppercase;
}
.animenu__nav > li > a:first-child:nth-last-child(2):before {
  content: "";
  position: absolute;
  border: 4px solid transparent;
  border-bottom: 0;
  border-top-color: currentColor;
  top: 50%;
  margin-top: -2px;
  right: 10px;
}
.animenu__nav > li:hover > ul {
  opacity: 1;
  visibility: visible;
  margin: 0;
}
.animenu__nav > li:hover > a {
  color: #fff;
}

.animenu__nav__child {
  min-width: 100%;
  position: absolute;
  top: 100%;
  left: 0;
  z-index: 1;
  opacity: 0;
  visibility: hidden;
  margin: 20px 0 0 0;
  background-color: #55552b;
  transition: margin .15s, opacity .15s;
}
.animenu__nav__child > li {
  width: 100%;
  border-bottom: 1px solid #77773c;
}
.animenu__nav__child > li:first-child > a:after {
  content: '';
  position: absolute;
  height: 0;
  width: 0;
  left: 1em;
  top: -6px;
  border: 6px solid transparent;
  border-top: 0;
  border-bottom-color: inherit;
}
.animenu__nav__child > li:last-child {
  border: 0;
}
.animenu__nav__child a {
  padding: 10px;
  width: 100%;
  border-color: #55552b;
}
.animenu__nav__child a:hover {
  background-color: #0186ba;
  border-color: #0186ba;
  color: #fff;
}

@media screen and (max-width: 767px) {
  .animenu__toggle {
    display: inline-block;
  }
  .animenu__nav, .animenu__nav__child {
      display: none;
   }

  .animenu__nav {
    margin: 10px 0;
  }
  .animenu__nav > li {
    width: 100%;
    border-right: 0;
    border-bottom: 1px solid #77773c;
  }
  .animenu__nav > li:last-child {
    border: 0;
  }
  .animenu__nav > li:first-child > a:after {
    content: '';
    position: absolute;
    height: 0;
    width: 0;
    left: 1em;
    top: -6px;
    border: 6px solid transparent;
    border-top: 0;
    border-bottom-color: inherit;
  }
  .animenu__nav > li > a {
    width: 100%;
    padding: 10px;
    border-color: #221;
    position: relative;
  }
  .animenu__nav a:hover {
    background-color: #0186ba;
    border-color: #0186ba;
    color: #fff;
  }

  .animenu__nav__child {
    position: static;
    background-color: #55552b;
    margin: 0;
    transition: none;
    visibility: visible;
    opacity: 1;
  }
  .animenu__nav__child > li:first-child > a:after {
    content: none;
  }
  .animenu__nav__child a {
    padding-left: 20px;
    width: 100%;
  }
}
.animenu__nav--open {
  display: block !important;
}
.animenu__nav--open .animenu__nav__child {
  display: block;
}
/***************-----END TOOLBAR-----***************/


/* MAIN CONTAINER FOR Video AND 24 Hours, 7 Day, 30 Day Feed */
#containerMain {
   height: 65%;
   margin: auto;
   left: 0;
   position: absolute;
   right: 0;
   top: 17.5%;
   bottom: 17.5%;
   width: 90%;
}

/***** Containers for Video Feed AND Buttons ******/
/*---------------------------------------*/
/* M - Holds(Video, and then */
#containerVideo {
   bottom: 0;
   height: 100%;
   margin: auto;
   position: absolute;
   right: 0;
   top: 0;
   width: 50%; 
   background-color: rgba(255, 216, 0, 0.4);     
}

/***** 24 Hours, 7 Day, 30 Day Feed ******/
/*---------------BEGIN--------------------*/

/* Container for 24 Hours, 7 Day, 30 Day Feed */
#containerFeed{
   bottom: 0;
   margin: auto;
   position: absolute;
   right: 50%;
   top: 0;
   width: 50%;   
}

/* Style the tab */
div.tab {
    position: relative;
    overflow: hidden;
    background-color: #134; /* Tab Background Color */
    width: 100%;
}

/* Style the links inside the tab */
div.tab a {
    position: relative;
    float: left;
    width: 33.33%;
    display: block;
    color: black;
    text-align: center;
    padding: 2vw; overflow: hidden;
    text-decoration: none;
    transition: 0.3s;
    font-size : 2vw;overflow: hidden;
    border: 3px solid #cccc99; /* Tab Inside Border Color */
}

/* Change background color of links on hover */
div.tab a:hover {
    background-color: #55552b; /* Hover Color */
}

/* Create an active/current tablink class */
div.tab a:focus, .active {
    background-color: #55552b; /* Clicked Color */
}

/* Style the tab content */
.tabcontent {
    position: relative;
    height: 100%;
    top: 0;
    margin: 0;
    display: none;
    border-top: none;
    border-bottom: none;
}


/***** ---END--- Containers for Video Feed AND Buttons ******/

html, body {
   margin: 0; 
   padding: 0; 
   width: 100%; 
   height: 100%; 
   overflow: hidden; 
   text-align: left;
   font-family: "Lato", sans-serif;
}

/* Background Photo Scale to fit */
html { 
  background: url(Images/photo_bg.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}



/* TEST TABLEEEEE *************/
h1{
  font-size: 30px;
  color: #55552b;
  text-transform: uppercase;
  font-weight: 300;
  text-align: center;
  margin-bottom: 15px;
}
table{
  width:100%;
  table-layout: fixed;
}
.tbl-header{
  background-color: rgbargba(17, 51, 68, 1);
 }
.tbl-content{
  height:300px;
  overflow-x:auto;
  margin-top: 0px;
  border: 5px solid rgba(17, 51, 68, 1);
  background-color: rgba(17, 51, 68, 1);
}
th{
  padding: 20px 15px;
  text-align: left;
  font-weight: 500;
  font-size: 14px;
  color: #000;
  text-transform: uppercase;
  text-decoration: underline;
  background-color: rgba(17, 51, 68, 1);
  border-bottom: solid 2px rgba(255, 216, 0, 0.4);
}
td{
  padding: 15px;
  text-align: left;
  vertical-align:middle;
  font-weight: bold;
  font-size: 16px;
  color: #000;
  border-bottom: solid 2px rgba(255, 216, 0, 0.4);
}

/* demo styles */

section{
  margin: 50px;
}

/* for custom scrollbar for webkit browser*/

::-webkit-scrollbar {
    width: 6px;
} 
::-webkit-scrollbar-track {
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
} 
::-webkit-scrollbar-thumb {
    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
}
/*TEST TABLE END*/

</style>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  
</head>
<body>
    <? php 
      echo "fuck it":
      ?>
  <nav class="animenu"> 
  <button class="animenu__toggle">
    <span class="animenu__toggle__bar"></span>
    <span class="animenu__toggle__bar"></span>
    <span class="animenu__toggle__bar"></span>
  </button>
  <ul class="animenu__nav">
    <li>

      <a href="index.php">Home</a>
    </li>
    <li>
      <a href="Feeder.php">Live Feeder</a>
      <ul class="animenu__nav__child">
        <li><a href="Feeder.php">Feeder Home</a></li>
        <li><a href="FeederSettings.php">Settings</a></li>
      </ul>
    </li> 
    <li>
      <a href="Tracker.php">Cattle Tracker</a>
      <ul class="animenu__nav__child">
        <li><a href="Tracker.php">Tracker Home</a></li>
        <li><a href="">Create New Geofence</a></li>
        <li><a href="TrackerSettings">Settings</a></li>
      </ul>
    </li>     
    <li>
      <a href="Database.php">Database</a>
      <ul class="animenu__nav__child">
        <li><a href="">Search</a></li>
        <li><a href="Add.php">Add Herd/Cow</a></li>
        <li><a href="Delete.php">Delete Herd/Cow</a></li>
      </ul>
    </li>                
  </ul>
</nav>
<script>
$(document).ready(function(){
  $.ajax({
    type: "POST",
    url: "/PHP/pfunctions.php",
    cache: false,
    data: {
      what: "test",
    },

  })
})
</script>
<div id="containerMain">
   <div id="containerFeed">
      <div class="tab">
         <a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 
                  '24 Hours')" id="defaultOpen"><font color="cccc99">24 Hours</font></a>
         <a href="javascript:void(0)" class="tablinks" onclick="openCity(event,
                  '7 Days')"><font color="cccc99">7 Days</font></a>
         <a href="javascript:void(0)" class="tablinks" onclick="openCity(event,
                  '30 Days')"><font color="cccc99">30 Days</font></a>
      </div>

      <div id="24 Hours" class="tabcontent">
         <h1>24 Hour Feed</h1>
            <div class="tbl-header">
               <table cellpadding="0" cellspacing="0" border="0">
                  <thead>
                     <tr>
                        <th>Tag ID</th>
                        <th>Time</th>
                     </tr>
                  </thead>
               </table>
            </div>
            <div class="tbl-content">
               <table cellpadding="0" cellspacing="0" border="0">
                  <tbody>
                     <tr>
                        <td>135</td>
                        <td>8:23 P.M.</td>
                     </tr>
                     <tr>
                        <td>456</td>
                        <td>9:42 P.M.</td>
                     </tr>
                  </tbody>
               </table>
            </div>
         </div>

      <div id="7 Days" class="tabcontent">
         <h1>7 Day Feed</h1>
            <div class="tbl-header">
               <table cellpadding="0" cellspacing="0" border="0">
                  <thead>
                     <tr>
                        <th>Tag ID</th>
                        <th>Time</th>
                     </tr>
                  </thead>
               </table>
            </div>
            <div class="tbl-content">
               <table cellpadding="0" cellspacing="0" border="0">
                  <tbody>
                     <tr>
                        <td>222</td>
                        <td>7:13 P.M.</td>
                     </tr>
                     <tr>
                        <td>333</td>
                        <td>10:43 P.M.</td>
                     </tr>
                  </tbody>
               </table>
            </div>
         </div>   
                
      <div id="30 Days" class="tabcontent">
         <h1>30 Day Feed</h1>
            <div class="tbl-header">
               <table cellpadding="0" cellspacing="0" border="0">
                  <thead>
                     <tr>
                        <th>Tag ID</th>
                        <th>Time</th>
                     </tr>
                  </thead>
               </table>
            </div>
            <div class="tbl-content">
               <table cellpadding="0" cellspacing="0" border="0">
                  <tbody>
                     <tr>
                        <td>444</td>
                        <td>1:23 A.M.</td>
                     </tr>
                     <tr>
                        <td>555</td>
                        <td>3:41 P.M.</td>
                     </tr>
                  </tbody>
               </table>
            </div>
         </div>
   </div>

   <div id="containerVideo">
      <br><br><br><br><center>Video Feed Here</center> <br><br><br>
      <bold><center>COMING SOON!</center></bold>           
   </div>
</div>

      <script src="js/index.js"></script>
<script>
function openCity(evt, cityName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}

// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();
</script>
<script>
$(window).on("load resize ", function() {
  var scrollWidth = $('.tbl-content').width() - $('.tbl-content table').width();
  $('.tbl-header').css({'padding-right':scrollWidth});
}).resize();
</script>
</body>
</html>