<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="h" tagdir="/WEB-INF/tags"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description"
          content="Start your development with Pigga landing page.">
    <meta name="author" content="Devcrud">
    <title>Home Shopping Site</title>
    <link rel="stylesheet" href="/css/hdcss.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <style>
        /* Pagination container */
        #paging {
            margin-top: 20px;
            text-align: center;
        }

        /* Pagination links */
        .pagination {
            display: inline-block;
            margin-bottom: 0;
        }

        .pagination .page-item {
            display: inline;
        }

        .pagination .page-link {
            color: #007bff;
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            padding: 6px 12px;
            margin: 0 4px;
        }

        .pagination .page-item.disabled .page-link {
            color: #6c757d;
            pointer-events: none;
            cursor: default;
        }

        .pagination .page-item.active .page-link {
            color: #fff;
            background-color: #007bff;
            border-color: #007bff;
        }

        .pagination {
            display: inline-block;
            margin: 0 auto;
        }

        .pagination li {
            display: inline;
            margin: 0 1px;
        }

        .pagination li.active a {
            color: #fff;
            background-color: #007bff;
            border-color: #007bff;
        }

        .pagination li a {
            color: #007bff;
            border: 1px solid #007bff;
            padding: 6px 12px;
        }

        .pagination li a:hover {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
        }

        .pagination li.disabled a {
            color: #6c757d;
            cursor: not-allowed;
            background-color: #fff;
            border-color: #6c757d;
        }
        #container_booklist{
            width: 1050px;
            margin: 0 auto;
        }
        #row2{
            width: 1050px;
            margin-bottom: 40px;
        }
    </style>
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="40" id="home">
<header>
    <%@include file="../../tags/header.jsp"%>
</header>

<div id="container_booklist">
    <div id="row2">
        <form action = "/com.solponge/productList/search" accept-charset="utf-8" name = "book_info" method = "get">
        <h3 id="newbook">
            <c:choose>
                <c:when test="${status.equals('Yes')}">
                    검색된 책<span>
                </c:when>
                <c:when test="${!status.equals('Yes')}">
                    새로나온책<span>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>

                    <select name="SearchSelect">
                      <option value="all">전체</option>
                      <option value="product_title">도서명</option>
                      <option value="product_writer">저자</option>
                    </select>
                    <input type="text" name="SearchValue" size="15" value="검색 내용">
                    <button type="submit"><img src="/img/Magnifier.png" style="width: 20px;" alt="Search"></button>
            </span>
        </h3>
        </form>
        <c:forEach var="productNew" items="${paginatedProducts}">
            <div class="column2">
                <a href="/com.solponge/product/${productNew.product_num}"><img
                        src="${productNew.product_img}"
                        alt="${productNew.product_title}"
                        style="width: 187px; height: 256px; align-items:center; display: flex; justify-content:center; margin: 0"
                /></a>
                <c:set var="title" value="${productNew.product_title}"/>
                <c:choose>
                    <c:when test="${fn:length(title) >= 16}">
                        <a href="/com.solponge/product/${productNew.product_num}"><h2>${fn:substring(title, 0, 13)}...</h2></a>
                    </c:when>
                    <c:otherwise>
                        <a href="/com.solponge/product/${productNew.product_num}"><h2>${title}</h2></a>
                    </c:otherwise>
                </c:choose>
                <a href="/com.solponge/product/${productNew.product_num}"><p>${productNew.product_price}원</p></a>
            </div>
        </c:forEach>
        <nav id="paging" aria-label="Page navigation example" style="clear: both;">
            <ul class="pagination justify-content-center" style="padding: 0">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${url}page=${currentPage - 1}" tabindex="-1"
                       aria-disabled="${currentPage == 1}">Previous</a>
                </li>
                <c:choose>
                    <c:when test="${totalPages <= 10}">
                        <c:set var="startPage" value="1"/>
                        <c:set var="endPage" value="${totalPages}"/>
                    </c:when>
                    <c:when test="${currentPage <= 6}">
                        <c:set var="startPage" value="1"/>
                        <c:set var="endPage" value="10"/>
                    </c:when>
                    <c:when test="${currentPage > totalPages - 6}">
                        <c:set var="startPage" value="${totalPages - 9}"/>
                        <c:set var="endPage" value="${totalPages}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="startPage" value="${currentPage - 5}"/>
                        <c:set var="endPage" value="${currentPage + 4}"/>
                    </c:otherwise>
                </c:choose>
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <li class="page-item ${currentPage == pageNum ? 'active' : ''}">
                        <a class="page-link" href="${url}page=${pageNum}">${pageNum}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}" style="margin-right: 44px">
                    <a class="page-link" href="${url}page=${currentPage + 1}" aria-disabled="${currentPage == totalPages}">Next</a>
                </li>
            </ul>
        </nav>
    </div>
</div>
<footer>
    <%@include file="../../tags/footer.jsp" %>
</footer>
</body>
</html>