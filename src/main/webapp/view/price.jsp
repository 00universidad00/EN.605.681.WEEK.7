<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${result_hike_price!=null}">
    <section class="card">
        <div class="card-content">
            <table class="table is-fullwidth">
                <thead>
                <tr>
                    <th>Destination</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Tour Duration</th>
                    <th>Week Days</th>
                    <th>Weekends</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th>${result_hike_location}</th>
                    <td>${result_hike_start}</td>
                    <td>${result_hike_end}</td>
                    <td>${result_hike_duration}</td>
                    <td>${result_hike_weekdays}</td>
                    <td>${result_hike_weekends}</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="has-text-centered">
            <h1 class="title has-text-success is-1">$${result_hike_price}</h1>
        </div>
    </section>
</c:if>
