var gConnection; // websocket gConnection


function ws_connect() {
	 
	 	 var processingInstance;	
		if (!processingInstance) processingInstance = Processing.getInstanceById('pjs');
	 
    if ('WebSocket' in window) {


/// crée la connection ///

        //writeToScreen('Connecting');
        gConnection = new WebSocket('ws://' + window.location.host + '/maxmsp');

	    gConnection.onopen = function(ev) {
            var message = 'update on';
            gConnection.send(message);
        };

        gConnection.onclose = function(ev) {
		   //soun.stop();
				//processingInstance.changeC(false);
        };


  		 gConnection.onerror = function(ev) {
				processingInstance.changeC(false);
            alert("WebSocket error");
        };



// recoit de max (donc des autres utilisateur si max redirige) //

        gConnection.onmessage = function(ev) {
       // 
		
		 if(ev.data.substr(0, 3) == "rx ")
          {
            json = ev.data.substr(3);
			
			if(json.substr(0, 5) == "btap ") processingInstance.change();
     		//if(json == "connect") processingInstance.changeC(true);
     	
			if(json.substr(0, 5) == "seek ") {
			 values = JSON.parse(json.substr(5));
			 processingInstance.changeR(values.x);
			}
			
		  	  
		  
		  }
		  
        };

		
    

    } else {
        alert("WebSocket is malheureusement not available!!!\n" +
              "Vous ne pourrez pas utiliser cette machine ou ce browser.");
			  var processingInstance;	 
				if (!processingInstance) processingInstance = Processing.getInstanceById('pjs');
				processingInstance.changeC(false);
    }
}




// user connect/disconnect
function toggleConnection() {
    //if (connectButton.label == "WebSocket Connect") {
      ws_connect();

   // }
   // else {
      gConnection.close();

    //}
}
//
//// user turn updates on/off
//function toggleUpdate(el) {
//    var tag=el.innerHTML;
//    var message;
//    if (tag == "Enable Update") {
//        message = 'update on';
//        el.innerHTML = "Disable Update";
//    }
//    else {
//        message = 'update off';
//        el.innerHTML = "Enable Update";
//    }
//    writeToScreen('SENT: ' + message);
//    gConnection.send(message);
//}




var timerUncoup=setTimeout();
function timeur_defin(){  // compte à rebour pour arreter la connection
clearTimeout(timerUncoup);
timerUncoup=setTimeout(function(){
	pjs.changeOnoff(false);
	if(gConnection) gConnection.send('lala');
	if (gConnection) gConnection.close();
	}
	,10000);
	
}


function timeur(){
var timerRegulier = setInterval(function () {myTimer()}, 1000);
function myTimer() {
	var processingInstance;	
	if (!processingInstance) processingInstance = Processing.getInstanceById('pjs');
	processingInstance.changeT();
   
   //if(gConnection) gConnection.send("qsff");
   
   // var d = new Date();
    //document.getElementById("demo").innerHTML = d.toLocaleTimeString();
	
}
//clearInterval(timerRegulier)
	
//var timerUncoup=setTimeout(function(){alert('Hello')},3000); //juste attent
//clearTimeout(timerUncoup);
}


