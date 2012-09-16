$(document).ready(function(){
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
