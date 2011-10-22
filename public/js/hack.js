var Hack = {


  next: function(container, url) {
    $(container).load(url);
  },

  rate_up: function(id,url) {
    $.post(url, { hack_idea_id: id, points: 1 })
    $("#downlink").removeClass("selected");
    $("#uplink").addClass("selected");
  },

  rate_down: function(id,url) {
    $.post(url, { hack_idea_id: id, points: 2 })
    $("#downlink").addClass("selected");
    $("#uplink").removeClass("selected");
  }

}
