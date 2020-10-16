<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="price" method="post">
    <c:if test="${display_error==true}">
        <div id="modal" class="modal is-active">
            <div class="modal-background"></div>
            <div class="modal-content">
                <article class="message is-danger">
                    <div class="message-header">
                        <p>Error</p>
                        <button class="delete" aria-label="delete"  onclick="closeModal()" type="submit" name="clear_error"></button>
                    </div>
                    <div class="message-body preformatted">
                            ${error}
                    </div>
                </article>
            </div>
        </div>
    </c:if>
</form>