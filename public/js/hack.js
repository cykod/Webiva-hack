var Hack = {


  next: function(container, url) {
    $(container).load(url);
  },

  rate_up: function(container,id,url) {
    $(container).load(url, { hack_idea_id: id, points: 1 })
    $("#downlink").removeClass("selected");
    $("#uplink").addClass("selected");
  },

  rate_down: function(container,id,url) {
    $(container).load(url,{ hack_idea_id: id, points: -1 })
    $("#downlink").addClass("selected");
    $("#uplink").removeClass("selected");
  }

}
