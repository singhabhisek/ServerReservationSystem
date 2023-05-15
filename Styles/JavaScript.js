<script type="text/javascript">
    function ShowPopup(message) {
        $(function () {
            $("#dialog").html(message);
            $("#dialog").dialog({
                title: "Error Message",
                buttons: {
                    Close: function () {
                        $(this).dialog('close');
                    }
                },
                modal: true
            });
        });
        };

        function diff_hours() {

            var dt1 = document.getElementById('txtStartTimeCal').value;
            var dt2 = document.getElementById('txtEndTimeCal').value;

            if (dt1 && dt2) {
                var dt3 = new Date(dt1.replace('T', ' '));
                var dt4 = new Date(dt2.replace('T', ' '));
                if (dt3 > dt4) {
                    alert("Start Time is greater than End Time. Please correct");
                    document.getElementById('txtStartTimeCal').value = new Date().toISOString().split('T')[0] + "T" + new Date().toLocaleTimeString('en-US', {
                        hour12: false,
                        hour: "numeric",
                        minute: "numeric"
                    });
                    document.getElementById('txtEndTimeCal').value = "";
                    document.getElementById('txtTestDuration').value = "";
                    return;
                }

                var hourDiff = (dt4 - dt3);
                //alert(hourDiff);
                var minDiff = hourDiff / 60 / 1000; //in minutes
                var hDiff = hourDiff / 3600 / 1000; //in hours
                var humanReadable = {};
                humanReadable.hours = Math.floor(hDiff);
                humanReadable.minutes = minDiff - 60 * humanReadable.hours;

                if (hourDiff / 1000 / 60 < 30) {
                    alert("Please select a test duration of 30 minutes at least. Please correct");
                    document.getElementById('txtEndTimeCal').value = "";
                    document.getElementById('txtTestDuration').value = "";
                    return;
                }
                if (!dt1) {
                    document.getElementById("txtTestDuration").value = "";
                }
                else {
                    document.getElementById("txtTestDuration").value = humanReadable.hours + "hr " + humanReadable.minutes + "min";
                }
                document.getElementById("LinkButton3").click();
            }
        }
    </script>