
ymaps.ready(init);
var myMap;

function init(){
    address = document.getElementById('ymaps').getAttribute('data-address');

    myMap = new ymaps.Map("ymaps", {
        center: [55.76, 37.64],
        zoom: 8
    });

    myGeocoder = ymaps.geocode(address);

    myGeocoder.then(
        function (res) {
            coordinates = res.geoObjects.get(0).geometry.getCoordinates();

            myMap.geoObjects.add(
                new ymaps.Placemark(
                    coordinates,
                    {iconContent: address},
                    {preset: 'islands#blueStretchyIcon'}
                )
            );

            myMap.setCenter(coordinates);
            myMap.setZoom(15);
        }, function (err) {
            alert('Не удалось определить местоположение.');
        }
    );
};
