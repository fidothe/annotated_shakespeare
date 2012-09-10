$(document).ready(function(){
    map(37.506136, -122.246677, false);
    $("#updateMap").click(function(){
        $(this).css("display", "none");
        $("#oxfordmap").html("You are ...");
        if (navigator.geolocation) {
	    navigator.geolocation.getCurrentPosition(
                updateMap, handleError);
        } else {
            // Oh well.
            // We could do more here, but we're not
        }
    });
});

function updateMap(position) {
    map(position.coords.latitude,
        position.coords.longitude,
        true);
}

function handleError(err) {
    alert ('Geolocation failed');
}

function map(lat,lng,showMarker) {
    var mapCenter = new google.maps.LatLng(lat,lng);
    var mapopts = {
        zoom: 15,
        center: mapCenter,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var mapdiv = document.getElementById("oxfordmap");
    var map = new google.maps.Map(mapdiv,mapopts);
    var icon = "http://norman.walsh.name/googlemap/markerblue.png";
    if (showMarker) {
        var marker = new google.maps.Marker({
            position: mapCenter,
            map: map,
            icon: icon
        });
        $("#whereareyou").html("You are here!");
    }
}
