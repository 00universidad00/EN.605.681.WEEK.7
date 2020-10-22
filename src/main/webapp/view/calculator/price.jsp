<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${result_hike_price!=null}">
    <section class="card mt-6">
        <div class="card-content">
            <table class="table is-fullwidth">
                <thead>
                <tr>
                    <th>Destination</th>
                    <th>Hikers</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Tour Length</th>
                    <th>Price per person</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>${result_hike_location}</td>
                    <td>${result_hike_members}</td>
                    <td>${result_hike_start}</td>
                    <td>${result_hike_end}</td>
                    <td>${result_hike_duration} Days</td>
                    <td>$${result_hike_price}0</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="has-text-centered">
            <p class="subtitle is-4">Total Price</p>
            <h1 class="title has-text-success is-1">$${result_hike_total}0</h1>
        </div>
    </section>
</c:if>
