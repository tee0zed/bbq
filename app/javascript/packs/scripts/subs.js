$(document).ready(function() {
    $("#subscribe-form").hide()
    $("#subscribe").click(function () {
        $("#subscribe-form").slideToggle({ duration:300 });
    });

    $(".gallery").hide()
    $("#photos").click(function () {
        $(".gallery").slideToggle({ duration:300 });
    });
});

