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
});
