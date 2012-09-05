if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
        updateGeo, handleError);
}
function updateGeo(position) {
    alert("You are here: "
          + position.coords.latitude
          + "," +  position.coords.longitude);
}
function handleError(err) {
    alert ('It all went terribly wrong.');
}