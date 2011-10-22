var Hack = {


  next: function(container, url) {
    $(container).load(url);
  },

  rate_up: function(id) {
    $.post("/website/hack/page/rate_up", { hack_idea_id: id })
    $("#downlink").removeClass("selected");
    $("#uplink").addClass("selected");
  },

  rate_down: function(id) {
    $.post("/website/hack/page/rate_down", { hack_idea_id: id })
    $("#downlink").addClass("selected");
    $("#uplink").removeClass("selected");
  }

}
