<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.kh.common.PageInfo"%>
<%@page import="com.kh.work.model.vo.Work"%>
<%@page import="java.util.ArrayList"%>
<%
	ArrayList<Work> list = (ArrayList<Work>)request.getAttribute("list");

	String search = (String)request.getAttribute("search");

	PageInfo pi = (PageInfo)request.getAttribute("pi");

	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	
	// 활중해제 후 메시지
	String scrMsg = (String)session.getAttribute("scrMsg");
	
	// workNo
	int workNo = 0;
	if(list.size() != 0){
		workNo = list.get(0).getWorkNo();
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
	<title>Admin Page</title>
	<link href="resources/css/admin_styles.css" rel="stylesheet" type="text/css"/>
	<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>
</head>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<body class="sb-nav-fixed">
    
    <%@ include file="../common/adminTopNav.jsp" %>
    
    <div id="layoutSidenav">
        
        <%@ include file="../common/adminSideNav.jsp" %>

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid">
                    <h1 class="mt-4">전체 작품 보기</h1>
                    
                    <br>
                    
                    <div>
                        <div class="diyDiv mb-4" style="display: inline-block; width: 20%">
                            <label id="writerName">
                            
                            <% if(list.size() != 0) { %> <%=list.get(0).getNickName() %> <% } %>
                            </label> 작가의 작품 목록
                            
                        </div>
                        <div class="diyDiv" style="display: inline-block; width: 79%;">
                            <label>
                            	<% if(list.size() != 0) { %> <%=list.get(0).getWorkTitle()%> <%}%>
                            </label>
                        </div> 
                    </div>
                    

                    <div class="card mb-4">
                        <div class="card-header"><i class="fas fa-table mr-1"></i>작품 에피소드 조회 목록
                            <button class="btn btn-primary" style="float:right;" id="searchBtn">검색</button>
                            <input type="text" class="search" id="epiSearch" style="float: right; width:220px;" placeholder="에피소드명을 입력하세요">
                            
                        </div>
                        <div class="card-body">

                            <div class="table-responsive">
                                <table class="table table-bordered" id="memberTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 20%;"></th>
                                            <th style="width: 60%;">Episode</th>
                                            <th style="width: 20%;">Secret</th>
                                        </tr>
                                    </thead>
                                    
                                    <tbody>
                                    	<%if(list.size() != 0) { %>
                                    		<% for(Work w : list) { %>
	                                        <tr>
	                                            <td><input type="checkbox" name="secretCheck" value="<%=w.getEpisodeNo()%>"></td>
	                                            <td>
	                                            	<%if(w.getSecretFlag().equalsIgnoreCase("n")) { %>
	                                            		<a href="<%=contextPath%>/episode.de?eNo=<%=w.getEpisodeNo()%>"><%=w.getEpisodeTitle() %></a>
	                                            	<% } else { %>
	                                            		<%=w.getEpisodeTitle() %>
	                                            	<% } %>
	                                            </td>
	                                            <td>
	                                            	<%if(w.getSecretFlag().equals("N")) { %> 조회 가능
	                                            	<% } else {%> 조회 불가
	                                            	<% } %>
	                                            </td>
	                                        </tr>
	                                        <% } %>
	                                    <% } else {%>
	                                    	<tr>
	                                    		<td colspan="3" style="text-align:center;">조회된 데이터가 없습니다</td>
	                                    	</tr>
	                                    <% } %>
                                    </tbody>
                                </table>

                                <% if(list.size() != 0) { %>
								<div style="float: right;">
                                <button class="btn btn-danger" id="secretBtn">숨김 처리</button>
	                            <button class="btn btn-danger" id="disSecretBtn">숨김 해제</button>
                                </div>
								<% } %>
                            </div>    
                            
                            <% if(list.size() != 0) { %>
                            <!-- 검색어를 받아온 게 있다면 -->
							<% if(search != null) { %>
							
							<!-- 페이징바 영역 -->
							<div class="pagingArea" align="center">
							
							<!-- 맨 처음으로 (<<) -->
							<button onclick="location.href='<%=contextPath%>/adSearch.ep?pageId=4&&no=<%=workNo%>&&search=<%=search %>';" class="btn btn-outline-primary"> &lt;&lt; </button>
							
							<!-- 이전페이지(<) -->
							<%if(currentPage == 1){ %>
							<button disabled class="btn btn-outline-primary"> &lt; </button>
							<%}else{ %>
							<button onclick="location.href='<%=contextPath%>/adSearch.ep?pageId=4&&no=<%=workNo%>&&currentPage=<%=currentPage-1%>&&search=<%=search %>';" class="btn btn-outline-primary"> &lt; </button>
							<%} %>
							
							<!-- 페이지 목록 -->
							<%for(int p=startPage; p<=endPage; p++){ %>
				
								<%if(currentPage == p){ %>
								<button disabled class="btn btn-primary"> <%=p%> </button>
								<%}else{ %>
								<button onclick="location.href='<%=contextPath%>/adSearch.ep?pageId=4&&no=<%=workNo%>&&currentPage=<%=p%>&&search=<%=search %>';" class="btn btn-outline-primary"> <%= p %> </button>
								<%} %>
				
							<%} %>
			
							<!-- 다음페이지(>) -->
							<%if(currentPage == maxPage){ %>
							<button disabled class="btn btn-outline-primary"> &gt; </button>
							<%}else{ %>
							<button onclick="location.href='<%=contextPath%>/adSearch.ep?pageId=4&&no=<%=workNo%>&&currentPage=<%=currentPage+1%>&&search=<%=search %>';" class="btn btn-outline-primary"> &gt; </button>
							<%} %>
			
			
							<!-- 맨 마지막으로 (>>) -->
							<button onclick="location.href='<%=contextPath%>/adSearch.ep?pageId=4&&no=<%=workNo%>&&currentPage=<%=maxPage%>&&search=<%=search %>'" class="btn btn-outline-primary"> &gt;&gt; </button>
			
							</div>
							
							<% } else { %>
							
							<!-- 페이징바 영역 -->
							<div class="pagingArea" align="center">
							
							<!-- 맨 처음으로 (<<) -->
							<button onclick="location.href='<%=contextPath%>/episodeList.wo?pageId=4&&no=<%=workNo %>';" class="btn btn-outline-primary"> &lt;&lt; </button>
							
							<!-- 이전페이지(<) -->
							<%if(currentPage == 1){ %>
							<button disabled class="btn btn-outline-primary"> &lt; </button>
							<%}else{ %>
							<button onclick="location.href='<%=contextPath%>/episodeList.wo?pageId=4&&no=<%=workNo%>&&currentPage=<%=currentPage-1%>';" class="btn btn-outline-primary"> &lt; </button>
							<%} %>
							
							<!-- 페이지 목록 -->
							<%for(int p=startPage; p<=endPage; p++){ %>
				
								<%if(currentPage == p){ %>
								<button disabled class="btn btn-primary"> <%=p%> </button>
								<%}else{ %>
								<button onclick="location.href='<%=contextPath%>/episodeList.wo?pageId=4&&no=<%=workNo%>&&currentPage=<%=p%>';" class="btn btn-outline-primary"> <%= p %> </button>
								<%} %>
				
							<%} %>
			
							<!-- 다음페이지(>) -->
							<%if(currentPage == maxPage){ %>
							<button disabled class="btn btn-outline-primary"> &gt; </button>
							<%}else{ %>
							<button onclick="location.href='<%=contextPath%>/episodeList.wo?pageId=4&&no=<%=workNo%>&&currentPage=<%=currentPage+1%>';" class="btn btn-outline-primary"> &gt; </button>
							<%} %>
			
			
							<!-- 맨 마지막으로 (>>) -->
							<button onclick="location.href='<%=contextPath%>/episodeList.wo?pageId=4&&no=<%=workNo%>&&currentPage=<%=maxPage%>'" class="btn btn-outline-primary"> &gt;&gt; </button>
			
							</div>
							
							<% } %>    
							<% } %>                                 
                        </div>
                    </div>
                </div>
            </main>
            
            <%@ include file="../common/adminFooter.jsp" %>
            
            <script>
            $(function(){
            	var workNo = "<%=workNo%>";
            	var msg = "<%=scrMsg%>";
    			
        		if(msg != "null") {
        			alert(msg);
        			<% session.removeAttribute("scrMsg");%>
        			<% scrMsg = null; %>
        			msg = "null";
        		}
        		
        		$("#searchBtn").click(function(){
                    var search = $("#epiSearch").val();
                    location.href = "<%=contextPath%>/adSearch.ep?pageId=4&&no=" + workNo + "&&search=" + search;
                 });
            	
            	// 숨김처리
                $("#secretBtn").click(function() {
        			var scrArr = new Array();
        			
        			$('input:checkbox[name=secretCheck]:checked').each(function() {
        				scrArr.push(this.value);
        			});
        			
        			if(scrArr.length >= 1) {
        				var scrNo = scrArr.join(", ");
        				
        				location.href = "<%=contextPath%>/adScrt.ep?pageId=4&&div=1&&workNo=" + workNo + "&&no=" + scrNo;
        			} else {
        				alert("숨김처리 할 작품을 선택해주세요.");
        			}
        		});
             	// 숨김해제
                $("#disSecretBtn").click(function() {
        			var scrArr = new Array();
        			
        			$('input:checkbox[name=secretCheck]:checked').each(function() {
        				scrArr.push(this.value);
        			});
        			
        			if(scrArr.length >= 1) {
        				var scrNo = scrArr.join(", ");
        				location.href = "<%=contextPath%>/adScrt.ep?pageId=4&&div=2&&workNo=" + workNo + "&&no=" + scrNo;
        			} else {
        				alert("숨김해제 할 작품을 선택해주세요.");
        			}
        		});
            });
         	
            </script>
            
        </div>
    </div>
</body>
</html>
