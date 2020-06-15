$(".event-misc").ready(function() {
    $(".gallery").hide()
    $("#photos").click(function () {
        $(".gallery").slideToggle({ duration:300 });
    });

    $(".photo-loader").hide()
    $("#loader").click(function () {
        $(".photo-loader").slideToggle({ duration:300 });
    });

    $(".map-container").show()
    $("#map").click(function () {
        $(".map-container").slideToggle({ duration:300 });
    });
});

