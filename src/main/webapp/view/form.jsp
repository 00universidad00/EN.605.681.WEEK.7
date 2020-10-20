<form action="price" method="post">
    <div class="columns">
        <div class="column">
            <div class="field">
                <p class="control has-icons-left">
                <span class="select is-fullwidth">
                    <select onchange="populateList(this.value)" name="hike_id">
                        <option value="0" selected>
                            Gardiner Lake
                        </option>
                        <option value="1">
                            Hellroaring Plateau
                        </option>
                        <option value="2">
                            The Beathen Path</option>
                    </select>
                </span>
                    <span class="icon is-small is-left">
                    <i class="fas fa-map-marker-alt"></i>
                </span>
                </p>
                <p class="help">Destination</p>
            </div>
        </div>
        <div class="column">
            <input id="hike_dates" class="input" name="hike_dates">
            <p class="help">Start Date</p>
        </div>
        <div class="column is-2">
            <div class="field">
                <p class="control">
                    <span class="select is-fullwidth">
                        <select id="hike_duration" name="hike_duration">
                        </select>
                    </span>
                </p>
                <p class="help">Tour Length</p>
            </div>
        </div>
        <div class="column is-2">
            <div class="field">
                <p class="control has-icons-left">
                <span class="select is-fullwidth">
                    <select id="hike_members" name="hike_members">
                        <option value="1" selected>
                            1
                        </option>
                        <option value="2">
                            2
                        </option>
                        <option value="3">
                            3
                        </option>
                        <option value="4">
                            4
                        </option>
                        <option value="5">
                            5
                        </option>
                        <option value="6">
                            6
                        </option>
                        <option value="7">
                            7
                        </option>
                        <option value="8">
                            8
                        </option>
                        <option value="9">
                            9
                        </option>
                        <option value="10">
                            10
                        </option>
                    </select>
                </span>
                    <span class="icon is-small is-left">
                    <i class="fas fa-user"></i>
                </span>
                </p>
                <p class="help">Hikers</p>
            </div>
        </div>
        <div class="column is-2">
            <button id="get_price" class="button is-primary is-fullwidth" type="submit" value="Send">
                <span class="icon">
                  <i class="fas fa-dollar-sign"></i>
                </span>
                <span>Get Price</span>
            </button>
        </div>
    </div>
</form>
<script>
    // get elements
    const get_price = document.getElementById('get_price');
    const dates = document.getElementById('hike_dates');
    const duration = document.getElementById("hike_duration");

    // prepare ui after page loads or refresh
    window.onload = function exampleFunction() {
        // initialize trip duration options
        populateList(0);
        // disable get prices button
        get_price.disabled = true
    }

    // format calendar picker
    bulmaCalendar.attach(dates, {
        type: 'date',
        dateFormat: 'MM/DD/YYYY',
        labelFrom: "Date",
        showFooter: false,
        showHeader: false
    });

    // evaluate selected date
    if (dates) {
        // bulmaCalendar instance is available as element.bulmaCalendar
        dates.bulmaCalendar.on('select', function (dates) {
            // Save calendar value in input field
            dates.value = dates.data.value();
            // enable get price button
            get_price.disabled = false
        });
    }

    // function used to load hike duration options
    function populateList(value) {
        // select hike duration list
        const select = duration;
        // create list of possible durations
        const durations = [{3: "3 Days", 5: "5 Days"}, {2: "2 Days", 3: "3 Days", 4: "4 Days"}, {5: "5 Days", 7: "7 Days"}];
        // build array based on function value
        const array = durations[value];
        // clear old values
        const length = select.options.length;
        for (let i = length - 1; i >= 0; i--) {
            select.options[i] = null;
        }
        // load new values
        for (const index in array) {
            select.options[select.options.length] = new Option(array[index], index);
        }
    }
</script>