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
                alert("Страница автоматически перезагрузится через 10 секунд");
                setTimeout(function () { location.href = "/"; }, 10000);
            });
        }

        /*поиск значения простого элемента*/
        function ebi(e) {
            return document.getElementById(e).value
        }

        function logout() {
            document.cookie = "id=";
            location.href = '/login.html';
        }
        function r() {
            var t = { init: "saveOut"};
            var mask = [ebi("Output1"), ebi("Output2"), ebi("Output3"), ebi("Output4"), ebi("Output5"), ebi("Output6"), ebi("Output7"), ebi("Output8")];
            t["mask"] = mask;
            e.style.opacity = "0", setTimeout(
                function () {
                    e.style.display = "none"
                }, 600), send("web_control.lua", t,
                function (e) {
                    alert("Сохранение выполнено.");
                })
        }

        var t, e = document.getElementById("Modal");

        document.body.addEventListener("click",
            function (t) {
                var i = document.getElementById("list");
                "myTopnav" == t.target.id ? nav() :
                "btn_exit" == t.target.id ? logout() :
                "btn_save" == t.target.id ? (e.style.opacity = "1", e.style.display = "block") :
                "close_m" == t.target.id | "close" == t.target.id ? (e.style.opacity = "0", setTimeout(
                    function () { e.style.display = "none" }, 600)) :
                "save_m" == t.target.id ? r() :
                ("LI" == t.target.tagName && t.target.id && (document.getElementById("wifi_id").value = t.target.id, document.getElementById("wifi_pass").value = "", document.getElementById("wifi_pass").focus(), document.getElementById("wifi_mode").options[1].selected = "true"), i.style.display = "none")
            })


        var ind;
        var elName;
        for (ind = 1; ind <= 8; ind++) {
            elName = "Tr" + ind;
            var s = document.getElementById(elName)
            s.onchange = function () {
                for (ind2 = 1; ind2 <= 8; ind2++) {
                    var elName2 = "Tr" + ind2;
                    var sts = document.getElementById(elName2), n = sts.querySelectorAll('[type="checkbox"]'), itog = 0;
                    for (var j = 0; j < n.length; j++)
                        n[j].checked ? itog += parseFloat(n[j].value) : itog;
                    document.getElementById("Output" + ind2).innerHTML = itog;
                }
            }
        }

    };