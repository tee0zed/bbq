$(document).ready(function() {
    $(".gallery").hide()
    $("#photos").click(function () {
        $(".gallery").slideToggle({ duration:300 });
    });
});

