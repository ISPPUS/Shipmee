
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@taglib prefix="acme" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript" src="scripts/jquery.js"></script>
<link rel="stylesheet" href="styles/assets/css/style-profile.css"
	type="text/css">
<link rel="stylesheet" href="styles/assets/css/style-self.css"
	type="text/css">
<script src="scripts/jquery.bootpag.min.js"></script>
<style type="text/css">
.btn-grey {
	background-color: #D8D8D8;
	color: #FFF;
}

.review-block-description .btn {
	text-transform: uppercase;
	font-size: 11px;
	font-weight: 600;
	padding: 6px 15px;
	margin-right: 5px;
}

.rating-block {
	padding: 15px 15px 20px 15px;
	border-radius: 3px;
}

.bold {
	font-weight: 700;
}

.padding-bottom-7 {
	padding-bottom: 7px;
}

.review-block {
	padding: 15px;
	border-radius: 3px;
	margin-bottom: 15px;
}

.review-block-name {
	font-size: 12px;
}

.review-block-date {
	font-size: 12px;
}

.review-block-rate {
	font-size: 13px;
	margin-bottom: 15px;
}

.review-block-title {
	font-size: 15px;
	font-weight: 700;
	margin-bottom: 10px;
}

.review-block-description {
	font-size: 16px;
	text-align: center;
}

.info-profile-comment {
	text-align: left;
}

.review-block-rate .glyphicon {
	color: #ffcd00;
}

@media ( min-width : 770px) {
	.info-profile-comment {
		text-align: center;
	}
}

.review-block hr {
	border: 1px solid #e4e4e4 !important;
}
</style>

<security:authorize access="hasRole('ADMIN')" var="isAdmin" />


<div class="container">
	<div class="row">
		<div class="col-md-6 col-lg-6">
			<div class="well profile-user profile">
				<jstl:if test="${isPrincipal}">
					<a href="user/user/edit.do"><i
						class="glyphicon glyphicon-pencil img-edit" title="Edit"></i></a>
				</jstl:if>
				<jstl:if test="${!isPrincipal}">
					<a href="complaint/user/create.do?userId=${user.id}"><i
						class="glyphicon glyphicon-exclamation-sign img-report"
						title="Complaint"></i></a>
				</jstl:if>
				<div class="modal-body text-center">

					<jstl:choose>
						<jstl:when test="${not empty user.photo}">
							<jstl:set var="imageUser" value="${user.photo}" />
						</jstl:when>
						<jstl:otherwise>
							<jstl:set var="imageUser" value="images/anonymous.png" />
						</jstl:otherwise>
					</jstl:choose>
					<img src="${imageUser}" name="aboutme" width="140" height="140"
						border="0" class="img-circle">



					<h3 class="media-heading profile-name">${user.name}
						<small> <jstl:if test="${user.isVerified}">
								<i class="glyphicon glyphicon-ok img-verified" title="Verified"></i>
							</jstl:if>
							
							<jstl:if test="${isAdmin && !user.isVerified && !user.dniPhoto != ''}">
								<br />
								<a href="user/administrator/verifyUser.do?userId=${user.id}"> 
									(<spring:message code="user.verifyUser" />)
								</a>
							</jstl:if>
							<jstl:if test="${isAdmin && user.isVerified}">
								<br />
								<a href="user/administrator/unverifyUser.do?userId=${user.id}"> 
									(<spring:message code="user.unverifyUser" />)
								</a>
							</jstl:if>



						</small>
					</h3>
					<span><strong><spring:message
								code="user.achievements" />: </strong></span> <span class="label label-warning">Nuevo</span>
					<span class="label label-info">Primer env�o</span> <span
						class="label label-info">Primer viaje</span> <span
						class="label label-success">Experimentado</span>
					<hr>

					<div class="titulo-apartado">
						<strong><spring:message code="user.public" /></strong>
					</div>
					<div class="datos text-left">
						<span> <strong><spring:message code="user.name" />:
						</strong>${user.name} ${user.surname}
						</span> <br /> <span> <strong><spring:message
									code="user.birthDate" />: </strong> <fmt:formatDate
								value="${user.birthDate}" pattern="dd/MM/yyyy" /></span> <br />
					</div>

					<jstl:if test="${isPrincipal || isAdmin}">

						<div class="titulo-apartado">
							<strong><spring:message code="user.private" /></strong> <i
								class="glyphicon glyphicon-lock"></i>
						</div>
						<div class="datos text-left">
							<span> <strong><spring:message
										code="user.username" />: </strong> <security:authentication
									property="principal.username" /></span> <br /> <span> <strong><spring:message
										code="user.email" />: </strong>${user.email}</span> <br /> <span> <strong><spring:message
										code="user.phone" />: </strong>${user.phone}</span> <br /> <span> <strong><spring:message
										code="user.dni" />: </strong>${user.dni}</span>
						</div>
						<div class="datos text-center">
							<jstl:if test="${isAdmin && !user.isVerified && !user.dniPhoto != ''}">
								<br />
								<a href="user/administrator/verifyUser.do?userId=${user.id}"> 
									(<spring:message code="user.verifyUser" />)
								</a>
							</jstl:if>
							<jstl:if test="${isAdmin && user.isVerified}">
								<br />
								<a href="user/administrator/unverifyUser.do?userId=${user.id}"> 
									(<spring:message code="user.unverifyUser" />)
								</a>
							</jstl:if>
						

						</div>
					</jstl:if>

					<hr>
					<div class="col-xs-12 col-sm-4 col-xs-4 emphasis" id="clickeable"
						onclick="location.href='shipment/list.do?userId=${user.id}';">
						<h2>
							<strong> <jstl:out value=" ${shipmentsCreated}" />
							</strong>
						</h2>
						<p>
							<small> <spring:message code="profile.shipments" />
							</small>
						</p>
					</div>
					<div class="col-xs-12 col-sm-4 col-xs-4 emphasis" id="clickeable"
						onclick="location.href='route/list.do?userId=${user.id}';">
						<h2>
							<strong> <jstl:out value=" ${routesCreated}" />
							</strong>
						</h2>
						<p>
							<small> <spring:message code="profile.routes" />
							</small>
						</p>
					</div>
					<div class="col-xs-12 col-sm-4 col-xs-4 emphasis" id="clickeable"
						onclick="location.href='shipment/list.do?userId=${user.id}';">
						<h2>
							<strong> <jstl:out value=" ${ratingsCreated}" />
							</strong>
						</h2>
						<p>
							<small> <spring:message code="user.ratingsCreated" />
							</small>
						</p>
					</div>
				</div>



			</div>
		</div>
		<div class="col-md-6 col-lg-6">
			<div class="row " style="margin-top: 2%;">
				<div class="col-sm-12" style="padding-left: 0% !important">

					<div class="review-block well profile-user profile">
						<jstl:if test="${rating != null}">
							<div class="row ">
								<div class="col-xs-12 col-md-12" style="text-align: center">
									<h4>
										<spring:message code="rating.create" />
									</h4>
								</div>
								<div class="col-xs-12 col-md-5">
									<div class="center-block col-xs-3 col-lg-12"
										style="text-align: center;">
										<img class="img-responsive"
											style="margin: 0 auto; width: 60px;"
											src="${rating.author.photo}">
									</div>
									<div class="col-xs-9 col-lg-12 info-profile-comment">
										<div class="review-block-name">
											<a href="user/profile.do?userId=${rating.author.id}">${rating.author.userAccount.username}</a>
										</div>
									</div>

								</div>
								<div class="col-xs-12 col col-md-7">
									<div class="review-block-rate"
										style="text-align: right; margin-right: 10%;">
										<div class="lead evaluation">
											<div id="colorstar " class="starrr ratable"></div>

										</div>
									</div>
									<div class="review-block-description" style="">
										<form:form action="rating/user/edit.do"
											modelAttribute="rating" method="post" class="form-horizontal"
											role="form">
											<form:hidden path="user" />
											<form:hidden id="value" path="value" value="0" />


											<textarea style="resize: none;" id="comment" name="comment"
												class="form-control"></textarea>

											<form:errors class="error create-message-error"
												path="comment" />

											<!-- Action buttons -->
											<acme:submit name="save" code="rating.save" />
										</form:form>

									</div>
								</div>
							</div>
							<hr />
						</jstl:if>
						<jstl:if test="${empty ratings.content}">
							<div class="row ">
								<div class="col-xs-12">
									<div class="center-block col-xs-4 col-lg-12"
										style="text-align: center;">
										<h4>
											<spring:message code="rating.anything" />
										</h4>
									</div>
								</div>
							</div>
						</jstl:if>
						<jstl:forEach items="${ratings.content}" var="ratingRow">
							<div class="row ">
								<div class="col-xs-12 col-md-4">
									<div class="center-block col-xs-4 col-lg-12"
										style="text-align: center;">
										<img class="img-responsive"
											style="margin: 0 auto; width: 60px;"
											src="${ratingRow.author.photo}">
									</div>
									<div class="col-xs-6 col-lg-12 info-profile-comment">
										<div class="review-block-name">
											<a href="user/profile.do?userId=${ratingRow.author.id}">${ratingRow.author.userAccount.username}</a>
										</div>
										<div class="review-block-date">
											<fmt:formatDate type="both" dateStyle="short"
												timeStyle="short" value="${ratingRow.createdDate}" />
										</div>
									</div>

								</div>
								<div class="col-xs-12 col col-md-8">
									<div class="review-block-rate"
										style="text-align: right; margin-right: 10%;">

										<jstl:forEach var="i" begin="1" end="${ratingRow.value}">

											<img src='images/star.svg' alt='*' style="width: 6%" />

										</jstl:forEach>
										<jstl:forEach var="i" begin="${ratingRow.value}" end="4">

											<img src='images/star_n.svg' alt='*' style="width: 6%" />

										</jstl:forEach>
																
								
									</div>
									<div class="review-block-description" style="">${ratingRow.comment}</div>
								</div>
							</div>
							<hr />

						</jstl:forEach>

					</div>

				</div>
				<div id="pagination" style="text-align: center" class="copyright">

					<script>
		$('#pagination').bootpag({
			total : <jstl:out value="${total_pages}"></jstl:out>,
			page : <jstl:out value="${page}"></jstl:out>,
			maxVisible : 5,
			leaps : true,
			firstLastUse : true,
			first : '<',
	        last: '>',
			wrapClass : 'pagination',
			activeClass : 'active',
			disabledClass : 'disabled',
			nextClass : 'next',
			prevClass : 'prev',
			lastClass : 'last',
			firstClass : 'first'
		}).on('page', function(event, num) {
			
			var user_id = getUrlParameter('userId');
			if (user_id === undefined) {
				user_id = '';
			}
			window.location.href = "user/profile.do?userId="+user_id+"&pagecomment="+num;
			page = 1
		});
		
		var getUrlParameter = function getUrlParameter(sParam) {
		    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
		        sURLVariables = sPageURL.split('&'),
		        sParameterName,
		        i;

		    for (i = 0; i < sURLVariables.length; i++) {
		        sParameterName = sURLVariables[i].split('=');

		        if (sParameterName[0] === sParam) {
		            return sParameterName[1] === undefined ? true : sParameterName[1];
		        }
		    }
		};

	</script>

				</div>
			</div>

		</div>
	</div>

</div>


<br />

<script type="text/javascript">


	// Starrr plugin (https://github.com/dobtco/starrr)
var __slice = [].slice;

(function($, window) {
  var Starrr;

  Starrr = (function() {
    Starrr.prototype.defaults = {
      rating: void 0,
      numStars: 5,
      change: function(e, value) {}
    };

    function Starrr($el, options) {
      var i, _, _ref,
        _this = this;

      this.options = $.extend({}, this.defaults, options);
      this.$el = $el;
      _ref = this.defaults;
      for (i in _ref) {
        _ = _ref[i];
        if (this.$el.data(i) != null) {
          this.options[i] = this.$el.data(i);
        }
      }
      this.createStars();
      this.syncRating();
      this.$el.on('mouseover.starrr', 'span', function(e) {
        return _this.syncRating(_this.$el.find('span').index(e.currentTarget) + 1);
      });
      this.$el.on('mouseout.starrr', function() {
        return _this.syncRating();
      });
      this.$el.on('click.starrr', 'span', function(e) {
        return _this.setRating(_this.$el.find('span').index(e.currentTarget) + 1);
      });
      this.$el.on('starrr:change', this.options.change);
    }

    Starrr.prototype.createStars = function() {
      var _i, _ref, _results;

      _results = [];
      for (_i = 1, _ref = this.options.numStars; 1 <= _ref ? _i <= _ref : _i >= _ref; 1 <= _ref ? _i++ : _i--) {
        _results.push(this.$el.append("<span class='glyphicon .glyphicon-star-empty'></span>"));
      }
      return _results;
    };

    Starrr.prototype.setRating = function(rating) {
      if (this.options.rating === rating) {
        rating = void 0;
      }
      this.options.rating = rating;
      this.syncRating();
      return this.$el.trigger('starrr:change', rating);
    };

    Starrr.prototype.syncRating = function(rating) {
      var i, _i, _j, _ref;

      rating || (rating = this.options.rating);
      if (rating) {
        for (i = _i = 0, _ref = rating - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          this.$el.find('span').eq(i).removeClass('glyphicon-star-empty').addClass('glyphicon-star');
        }
      }
      if (rating && rating < 5) {
        for (i = _j = rating; rating <= 4 ? _j <= 4 : _j >= 4; i = rating <= 4 ? ++_j : --_j) {
          this.$el.find('span').eq(i).removeClass('glyphicon-star').addClass('glyphicon-star-empty');
        }
      }
      if (!rating) {
        return this.$el.find('span').removeClass('glyphicon-star').addClass('glyphicon-star-empty');
      }
    };

    return Starrr;

  })();
  return $.fn.extend({
    starrr: function() {
      var args, option;

      option = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      return this.each(function() {
        var data;

        data = $(this).data('star-rating');
        if (!data) {
          $(this).data('star-rating', (data = new Starrr($(this), option)));
        }
        if (typeof option === 'string') {
          return data[option].apply(data, args);
        }
      });
    }
  });
})(window.jQuery, window);

$(function() {
  return $(".starrr").starrr();
});

$( document ).ready(function() {
    
    var correspondence=["","Really Bad","Bad","Fair","Good","Excelent"];
      
  $('.ratable').on('starrr:change', function(e, value){
   
     $("#value").attr("value", value);
    
  });
  
});
	</script>