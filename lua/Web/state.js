window.onload =
    function () {        

        function send(page, data, callback) {
            var req = new XMLHttpRequest();
            req.open("POST", page, true);
            req.setRequestHeader('Content-Type', 'application/json');
            req.addEventListener("load", function () {
                if (req.status < 400) {
                    callback(req.responseText);
                } else {
                    callback(req.status);
                }
            });
            req.send(JSON.stringify(data));
        }

        function nav() {
            var x = document.getElementById("myTopnav");
            if (x.classList.contains("res")) {
                x.classList.remove('res');
            } else {
                x.classList.add('res');
            }
        }

        function reboot() {
            send("web_control.lua", { init: "reboot" }, function (res) {
                alert("The page will automatically reboot after 10 seconds");
                setTimeout(function () { location.href = "/"; }, 10000);
            });
        }

        function fsl(t) {
            for (i = 0; i < t.options.length; i++)
                if (t.options[i].selected)
                    return t.options[i].value
        }

        function logout() {
            document.cookie = "id=";
            location.href = '/login.html';
        }
		
        function r() {
            var t = { init: "OnOff"};
			t["elValue"] = elValue;
			t["elChecked"] = elChecked;
			e.style.opacity = "0", setTimeout(
                function () {e.style.display = "none"}, 600), send("web_control.lua", t,
					function (e) {
									
					})
        }

        var t, e = document.getElementById("Modal");
		var elValue = -1;
        var elChecked = -1;

        document.body.addEventListener("click",
            function (t) {
                var i = document.getElementById("list");
                "myTopnav" == t.target.id ? nav() :
                "btn_exit" == t.target.id ? logout() :
                "checkboxEx" == t.target.className ? (e.style.opacity = "1", e.style.display = "block", elValue = t.target.value, elChecked = t.target.checked) :
                "close_m" == t.target.id | "close" == t.target.id ? (e.style.opacity = "0", setTimeout(function () { e.style.display = "none" }, 600)) :
                "save_m" == t.target.id ? r() : null;                
            })

    };