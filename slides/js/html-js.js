$(document).ready(function(){
    // canvas is a reference to a <canvas> element
    var canvas = $("#mycanvas");
    if (canvas.length == 1) {
        canvas = canvas.get(0)
        initGame(canvas, document.getElementById("movecount"))
    }

    $("#make_progress").click(function(){
        var bar = $("#progress").get(0);
        bar.value += 10;
        bar.getElementsByTagName("span")[0].textContent = bar.value;
    });

    var datetest = document.createElement("input");
    datetest.setAttribute("type", "date");
    if (datetest.type == "text") {
        $("#birthday").datepicker({ dateFormat: "yy-mm-dd" });
    }

    beUnobtrusive();
});

function XbeUnobtrusive() {
    // If we get here, we have JavaScript and JQuery. Duh.
    $("div.details").each(function() {
        $(this).children("div").each(function () {
            $(this).css("font-weight", "bold")
                .addClass("toggleClosed");
            $(this).click(function() {
                $(this).toggleClass("toggleClosed")
                    .toggleClass("toggleOpen");
            });
        });
    });
}

function beUnobtrusive() {
    // If we get here, we have JavaScript and JQuery. Duh.
    $("div.details").each(processDetails);
}

function processDetails() {
    $(this).children("div").each(processDiv);
}

function processDiv() {
    $(this).css("font-weight", "bold")
        .addClass("toggleClosed")
        .click(toggleList);
}

function toggleList() {
    $(this).toggleClass("toggleClosed")
        .toggleClass("toggleOpen");
}
