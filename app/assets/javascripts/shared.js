micropost_picture_changed = function () {

    var size_in_megabytes = this.files[0].size / 1024 / 1024;
    if (size_in_megabytes > 5) {
        alert('Maximum file size is 5MB, Please choose a smaller file.')
    }
    else {
        // 检查是否支持FileReader对象
        if (typeof FileReader != 'undefined') {
            var acceptedTypes = {
                'image/png': true,
                'image/jpeg': true,
                'image/gif': true
            };
            if (acceptedTypes[this.files[0].type] === true) {
                var reader = new FileReader();
                reader.onload = function (event) {
                    var image = new Image();
                    image.src = event.target.result;
                    image.width = 100;
                    document.getElementById('add_picture').insertBefore(image, document.getElementById('picture_input'));
                };
                reader.readAsDataURL(this.files[0]);
            }
        }
    }
};

var CalendarHandler = {
    currentYear: 0,
    currentMonth: 0,
    isRunning: false,
    showYearStart: 2015,
    tag: 0,
    currentType: 0,//0 day, 1 month, 2 year
    ajaxUrl: "",
    initialize: function (y, m, d, url) {
        CalendarHandler.ajaxUrl = url;
        var nowDate = new Date();
        CalendarHandler.showYearStart = nowDate.getFullYear() - 5;
        var $calendarItem = CalendarHandler.CreateCalendar(y, m, d);
        $("#Container").append($calendarItem);

        CalendarHandler.currentType = 0;

        $("#context").css("height", $("#CalendarMain").height() - $("#title").height() + 1 + "px");
        $("#center").css("height", $("#context").height() + "px");
        $("#selectYearDiv").css("height", $("#context").height() + "px").css("width", $("#context").width() + "px");
        $("#selectMonthDiv").css("height", $("#context").height() + "px").css("width", $("#context").width() + "px");
        $("#centerCalendarMain").css("height", $("#context").height() + "px").css("width", $("#context").width() + "px");

        $calendarItem.css("height", $("#context").height() - 30 + "px"); //.css("visibility","hidden");
        $("#Container").css("height", "0px").css("width", "0px").css("margin-left", $("#context").width() / 2 + "px").css("margin-top", $("#context").height() / 2 + "px");
        $("#Container").animate({
            width: $("#context").width() + "px",
            height: ($("#centerCalendarMain").height() - $("#week").height()) * 2 + "px",
            marginLeft: "0px",
            marginTop: "0px"
        }, 300, function () {
            $calendarItem.css("visibility", "visible");
        });

        $(".dayItem").css("width", $("#context").width() + "px");
        var itemPaddintTop = $(".dayItem").height() / 6;
        $(".item").css({
            "width": $(".week").width() / 7 + "px",
            "line-height": itemPaddintTop + "px",
            "height": itemPaddintTop + "px"
        });
        $(".week>h3").css("width", $(".week").width() / 7 + "px");
        //this.RunningTime();
    },
    CreateSelectYear: function (showYearStart) {

        CalendarHandler.currentType = 2;
        CalendarHandler.showYearStart = showYearStart;
        $(".currentDay").show();
        $("#selectYearDiv").children().remove();
        var nowDate = new Date;
        var nowYear = nowDate.getFullYear();

        var itemWidth = ($("#selectYearDiv").width() - 3) / 4; //3 border
        var itemHeight = ($("#selectYearDiv").height() - 2) / 3; //2 border
        var yearIndex = 1;
        for (var i = showYearStart; i < showYearStart + 12; ++i, ++yearIndex) {

            if (i == nowYear) {
                $yearItem = $("<div class=\"currentYearSd\" id=\"" + yearIndex + "\">" + i + "</div>")
            } else {
                $yearItem = $("<div id=\"" + yearIndex + "\">" + i + "</div>");
            }

            $("#selectYearDiv").append($yearItem);

            $yearItem.click(function () {
                $calendarItem = CalendarHandler.CreateCalendar(Number($(this).html()), 1, 1);
                $("#Container").append($calendarItem);
                CalendarHandler.CSS()
                CalendarHandler.isRunning = true;
                $($("#Container").find(".dayItem")[0]).animate({
                    height: "0px"
                }, 300, function () {
                    $(this).remove();
                    CalendarHandler.isRunning = false;
                });
                $("#centerMain").animate({
                    marginLeft: -$("#center").width() + "px"
                }, 500);
            });

            if (yearIndex % 4 == 1)
                $yearItem.css("width", itemWidth + 1 + "px");
            else if (yearIndex % 4 == 0)
                $yearItem.css("border-right", "none").css("width", itemWidth + "px");
            else
                $yearItem.css("width", itemWidth + 1 + "px");

            if (yearIndex <= 8)
                $yearItem.css("height", itemHeight + 1 + "px").css("line-height", itemHeight + 1 + "px");
            else
                $yearItem.css("height", itemHeight + "px").css("line-height", itemHeight + "px").css("border-bottom", "none");

        }

        $("#centerMain").animate({
            marginLeft: "0px"
        }, 300);
    },
    RefreshCurrentYearLabel: function () {
        $(".selectYear").html(this.currentYear + "年");
    },
    CreateSelectMonth: function () {
        $(".currentDay").show();
        $("#selectMonthDiv").children().remove();
        CalendarHandler.RefreshCurrentYearLabel();
        var nowDate = new Date;
        this.currentType = 1;

        var itemWidth = ($("#selectMonthDiv").width() - 3) / 4; //3 border
        var itemHeight = ($("#selectMonthDiv").height() - 2) / 3; //2 border

        for (var i = 1; i < 13; i++) {
            if ((i == nowDate.getMonth() + 1) && (CalendarHandler.currentYear == nowDate.getFullYear()))
                $monthItem = $("<div class=\"currentMontSd\" id=\"" + i + "\">" + i + "月</div>");
            else
                $monthItem = $("<div id=\"" + i + "\">" + i + "月</div>");

            $("#selectMonthDiv").append($monthItem);
            $monthItem.click(function () {
                $calendarItem = CalendarHandler.CreateCalendar(CalendarHandler.currentYear, Number($(this).attr("id")), 0);
                $("#Container").append($calendarItem);
                CalendarHandler.CSS()
                CalendarHandler.isRunning = true;
                $($("#Container").find(".dayItem")[0]).animate({
                    height: "0px"
                }, 300, function () {
                    $(this).remove();
                    CalendarHandler.isRunning = false;
                });
                $("#centerMain").animate({
                    marginLeft: -$("#center").width() + "px"
                }, 500);
            });

            if (i % 4 == 1)
                $monthItem.css("width", itemWidth + 1 + "px");
            else if (i % 4 == 0)
                $monthItem.css("border-right", "none").css("width", itemWidth + "px");
            else
                $monthItem.css("width", itemWidth + 1 + "px");

            if (i <= 8)
                $monthItem.css("height", itemHeight + 1 + "px").css("line-height", itemHeight + 1 + "px");
            else
                $monthItem.css("height", itemHeight + "px").css("line-height", itemHeight + "px").css("border-bottom", "none");
        }

        $("#centerMain").animate({
            marginLeft: -$("#center").width() * 2 + "px"
        }, 300);
    },
    IsRuiYear: function (aDate) {
        return (0 == aDate % 4 && (aDate % 100 != 0 || aDate % 400 == 0));
    },
    CalculateWeek: function (y, m, d) {
        var arr = "7123456".split("");
        with (document.all) {
            var vYear = parseInt(y, 10);
            var vMonth = parseInt(m, 10);
            var vDay = parseInt(d, 10);
        }
        var week = arr[new Date(y, m - 1, vDay).getDay()];
        return week;
    },
    CalculateMonthDays: function (m, y) {
        var mDay = 0;
        if (m == 0 || m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) {
            mDay = 31;
        } else {
            if (m == 2) {
                //判断是否为芮年
                var isRn = this.IsRuiYear(y);
                if (isRn == true) {
                    mDay = 29;
                } else {
                    mDay = 28;
                }
            } else {
                mDay = 30;
            }
        }
        return mDay;
    },
    CreateCalendar: function (y, m, d) {
        this.currentType = 0;
        $dayItems = $("<div class=\"dayItem\"></div>");

        var nowDate = new Date();
        if ((y == nowDate.getFullYear() && m == nowDate.getMonth() + 1) || (y == 0 && m == 0))
            $(".currentDay").hide();

        var nowYear = y == 0 ? nowDate.getFullYear() : y;
        this.currentYear = nowYear;
        var nowMonth = m == 0 ? nowDate.getMonth() + 1 : m;
        this.currentMonth = nowMonth;
        var nowDay = d == 0 ? nowDate.getDate() : d;

        $(".selectYear").html(nowYear + "年");
        $(".selectMonth").html(nowMonth + "月");

        var nowDaysNub = this.CalculateMonthDays(nowMonth, nowYear);
        var nowWeek = parseInt(this.CalculateWeek(nowYear, nowMonth, 1));
        var lastMonthDaysNub = this.CalculateMonthDays((nowMonth - 1), nowYear);

        //生成上月剩下的日期
        if (nowWeek != 0) {
            for (var i = (lastMonthDaysNub - (nowWeek - 1)); i < lastMonthDaysNub; i++) {
                $dayItems.append("<div class=\"item lastItem\">" + (i + 1) + "</div>");
            }
        }

        //生成当月的日期
        for (var i = 0; i < nowDaysNub; ++i) {
            if ((nowYear == nowDate.getFullYear()) && (nowMonth == nowDate.getMonth() + 1) && (i == (nowDate.getDate() - 1)))
                $curDayItem = $("<div class=\"item itemBtn currentItem \">" + (i + 1) + "</div>");
            else
                $curDayItem = $("<div class=\"item itemBtn\">" + (i + 1) + "</div>");

            $curDayItem.click(function () {
                CalendarHandler.OnClickedDay(Number($(this).html()));
            })

            $dayItems.append($curDayItem);
        }

        //获取总共已经生成的天数
        var hasCreateDaysNub = nowWeek + nowDaysNub;
        //如果小于42，往下个月推算
        if (hasCreateDaysNub < 42) {
            for (var i = 0; i <= (42 - hasCreateDaysNub); i++) {
                $dayItems.append("<div class=\"item lastItem\">" + (i + 1) + "</div>");
            }
        }

        return $dayItems;
    },
    CSS: function () {
        var itemH = $(".dayItem").height() / 6;
        var itemW = $(".week").width() / 7;
        $(".item").css({
            "width": itemW + "px",
            "line-height": itemH + "px",
            "height": itemH + "px"
        });
    },
    CalendarNext: function () {
        if (this.isRunning == false) {
            if (CalendarHandler.currentType == 1) { // month model
                ++this.currentYear;
                this.CreateSelectMonth();
            } else if (CalendarHandler.currentType == 2) { // year model

                CalendarHandler.CreateSelectYear(CalendarHandler.showYearStart + 12);

            } else {
                $(".currentDay").show();
                var m = this.currentMonth == 12 ? 1 : this.currentMonth + 1;
                var y = this.currentMonth == 12 ? (this.currentYear + 1) : this.currentYear;
                var d = 0;
                var nowDate = new Date();

                if (y == nowDate.getFullYear() && m == nowDate.getMonth() + 1)
                    d = nowDate.getDate();
                else
                    d = 1;

                $calendarItem = this.CreateCalendar(y, m, d);
                $("#Container").append($calendarItem);

                this.CSS();
                this.isRunning = true;
                $($("#Container").find(".dayItem")[0]).animate({
                    height: "0px"
                }, 300, function () {
                    $(this).remove();
                    CalendarHandler.isRunning = false;
                });
            }
        }
    },
    CalendarLast: function () {
        if (this.isRunning == false) {
            if (CalendarHandler.currentType == 1) { //month model
                --this.currentYear;
                this.CreateSelectMonth();
            } else if (CalendarHandler.currentType == 2) { //year model

                CalendarHandler.CreateSelectYear(CalendarHandler.showYearStart - 12);

            } else /* if (CalendarHandler.currentType == 0)*/ { // day model
                $(".currentDay").show();
                var nowDate = new Date();
                var m = this.currentMonth == 1 ? 12 : this.currentMonth - 1;
                var y = this.currentMonth == 1 ? (this.currentYear - 1) : this.currentYear;
                var d = 0;

                if (y == nowDate.getFullYear() && m == nowDate.getMonth() + 1)
                    d = nowDate.getDate();
                else
                    d = 1;

                var oldH = $(".dayItem").height();

                $calendarItem = this.CreateCalendar(y, m, d);
                $("#Container").prepend($calendarItem);

                var itemH = oldH / 6;
                $(".item").css({
                    "width": $(".week").width() / 7 + "px",
                    "line-height": itemH + "px",
                    "height": itemH + "px"
                });

                this.isRunning = true;

                $calendarItem.css("height", 0 + "px");
                $calendarItem.animate({
                    height: oldH + "px"
                }, 300, function () {
                    $($("#Container").find(".dayItem")[1]).remove();
                    CalendarHandler.isRunning = false;
                });
            }
        }
    },
    CreateCurrentCalendar: function () {
        if (this.isRunning == false) {
            $(".currentDay").hide();
            $calendarItem = this.CreateCalendar(0, 0, 0);
            $("#Container").append($calendarItem);
            this.isRunning = true;
            $($("#Container").find(".dayItem")[0]).animate({
                height: "0px"
            }, 300, function () {
                $(this).remove();
                CalendarHandler.isRunning = false;
            });
            this.CSS();
            $("#centerMain").animate({
                marginLeft: -$("#center").width() + "px"
            }, 500);
        }
    },
    /*RunningTime: function () {
     var mTiming = setInterval(function () {
     var nowDate = new Date();
     var h = nowDate.getHours() < 10 ? "0" + nowDate.getHours() : nowDate.getHours();
     var m = nowDate.getMinutes() < 10 ? "0" + nowDate.getMinutes() : nowDate.getMinutes();
     var s = nowDate.getSeconds() < 10 ? "0" + nowDate.getSeconds() : nowDate.getSeconds();
     var nowTime = h + ":" + m + ":" + s;
     $("#footNow").html(nowTime);
     }, 1000);

     },*/
    OnClickedDay: function (d) {
        if (this.ajaxUrl.length > 0) {
            $.ajax({
                url: this.ajaxUrl,
                type: 'post',
                data: {date: {year: CalendarHandler.currentYear, month: CalendarHandler.currentMonth, day: d}},
                dataType: 'script',
                error: function () {
                    alert('error');
                },
            });
        }
    }
};