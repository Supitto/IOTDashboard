// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"


function addData(chart, label, data) {
  chart.data.labels.push(label);
  chart.data.datasets.forEach((dataset) => {
      dataset.data.push(data);
  });
  chart.update();
} 

  let socket = new Socket("/sensor_stream", {params: {token: window.userToken}})

  socket.connect()
  // Now that you are connected, you can join channels with a topic:
  let channel = socket.channel("sensor_in",{})//:".concat(window.myLine.datasets[0].label), {})
  


  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })
    channel.on("new_value", payload =>
    {
      let date = new Date();
      
      //Para o menu principal
      if($("#qtd_medicoes").length)
      {
        $("#qtd_medicoes").html(1+Number($("#qtd_medicoes").text()));
      }

      //Chat de ultimas medições-geral
      if($("#rotator-all").length)
      {
        $('<li><div class="chat-body clearfix"> <div class="row"><span class="col-xs-4">'.concat(date).concat('</span> <strong class="col-xs-6" >').concat(payload.value).concat('</strong></div> </div></li>')).insertAfter($('#list-head'))
        $('#rotator-all').children()[$('#rotator-all').children().length-1].remove()
      }

      //Para quando houver um grafico
      if(typeof window.myLine != "undefined")
      {
      if(payload.sensor_name === window.myLine.data.datasets[0].label)
      {
        window.myLine.data.labels.splice(0,1);
        window.myLine.data.labels.push(date.getHours()+":"+date.getMinutes()+":"+date.getSeconds());
        
        window.myLine.data.datasets[0].data.splice(0,1);
        window.myLine.data.datasets[0].data.push(payload.value);
        window.myLine.update();
        $('<li><div class="chat-body clearfix"> <div class="row"><span class="col-xs-4">'.concat(date).concat('</span> <strong class="col-xs-6" >').concat(payload.value).concat('</strong></div> </div></li>')).insertAfter($('#list-head'))
        $('#rotator').children()[$('#rotator').children().length-1].remove()
      }}
    })
  

  export default socket
