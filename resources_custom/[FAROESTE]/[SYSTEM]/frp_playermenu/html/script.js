$(function() {
    window.addEventListener('message', function(event) {

        if (event.data.type === "openHUD") {
            let item = event.data;
            
            $("#username").html(addCommas(item.data.username));
            $("#charname").html(addCommas(item.data.charname));
            $("#playtime").html(addCommas(item.data.playtime));
            $("#money").html(addCommas(item.data.money));
            $("#level").html(addCommas(item.data.level));
            $("#uid").html(addCommas(item.data.uid));
            $("#cid").html(addCommas(item.data.cid));
            $("#gold").html(addCommas(item.data.gold));
            $("#xp").html(addCommas(item.data.xp));
            $("#role").html(addCommas(item.data.role));
            setTimeout(function() {
                $('.center').css('display', 'block')
            }, 100);
        } else if (event.data.type === "closeAll") {
            $('.center').css('display', 'none')
        }



    });
});