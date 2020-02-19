<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="toDay" class="java.util.Date" />

<html>
<head>
<title><spring:message code="msg.login.login.title" /></title>
<script type="text/javascript"> // 차트 공통 요소로써 차트가 존재하는 페이지에 반드시 한번만 존재해야함 
	//chart 공통 부분							
	Chart.defaults.global.responsive = true; //가변형
	Chart.defaults.global.responsiveAnimationDuration = 500; //가변형 animation
	Chart.defaults.global.maintainAspectRatio = false; //가로세로 비율 유지,
	

	//폰트 
	Chart.defaults.global.defaultFontColor = "#222"; 
	Chart.defaults.global.defaultFontFamily = "Arial, Helvetica, sans-serif"; 
	Chart.defaults.global.defaultFontSize = 12; 							

	//툴팁
	Chart.defaults.global.tooltips.cornerRadius = 2 ;
	Chart.defaults.global.tooltips.bodySpacing = 5;
	Chart.defaults.global.tooltips.xPadding = 10;
	Chart.defaults.global.tooltips.yPadding = 10;

	//animation
	Chart.defaults.global.animation.duration = 1800;
	Chart.defaults.global.animation.easing = "easeOutBounce";
</script>

<script type="text/javascript">
	// line chart용 //공통을 채울때
	Chart.defaults.global.elements.line.borderWidth = 1;

	Chart.defaults.global.elements.point.radius = 3;
	Chart.defaults.global.elements.point.hoverRadius = 5;
	Chart.defaults.global.elements.point.hoverBorderWidth = 0;
</script>
<!-- //차트가 필요한 곳에서만 사용 -->


</head>
<body>
<div class="rowBox mgT20">
	<div class="g_column w_1_1">
		<h3>
			<span class="title"><spring:message code="msg.dashboard.project.title"/></span>
		</h3>
		<div class="unitBox chartBox" style="height:320px;">
			<canvas id="lineChart03" style=""></canvas>
			<div id="chartLegend03" class="chartLegend"></div><!-- 커스텀으로 제작된 legend 부분 -->
		</div>
	</div>
</div>

<div class="rowBox mgT20">
	<div class="g_column w_2_1">
		<h3>
			<span class="title"><spring:message code="msg.dashboard.team.title"/></span>
		</h3>
		<div class="unitBox chartBox legendLeft" style="height:320px;">
			<canvas id="pieChart04" style=""></canvas>
			<div id="chartLegend04" class="chartLegend"></div><!-- 커스텀으로 제작된 legend 부분 -->	
		</div>
			
			
	</div>
</div>

</body>
<script type="text/javascript"> 
<!-- 포로젝트 현황 라인차트 생성 스크립트 시작 -->
	//리스트 안의 총합 구하는 부분	
	function getSum (total, num) {
		return total + num;
	}
	
	//data 부분
	var lineData = {
		labels: ${projectResultList[4]},
		datasets: [{
			label: "계약건수 ",
			data: ${projectResultList[0]},
			backgroundColor: "rgba(49,141,231,0.0)",//background 의 opacity를 0으로
			borderColor : "rgba(49,141,231,0.6)",
			lineTension: 0.0,
			pointBackgroundColor:"rgba(49,141,231,0.5)",
			pointHoverBackgroundColor :"rgba(49,141,231,1.0)",
		},{
			label: "진행건수",
			data: ${projectResultList[1]},
			backgroundColor: "rgba(80,80,80,0.0)",//background 의 opacity를 0으로
			borderColor : "rgba(80,80,80,0.7)",
			lineTension: 0.0,
			pointBackgroundColor:"rgba(80,80,80,0.5)",
			pointHoverBackgroundColor :"rgba(80,80,80,1.0)",
		},{
			label: "종료건수",
			data: ${projectResultList[2]},
			backgroundColor: "rgba(243,73,80,0.0)",//background 의 opacity를 0으로
			borderColor : "rgba(243,73,80,0.7)",
			lineTension: 0.0,
			pointBackgroundColor:"rgba(243,73,80,0.5)",
			pointHoverBackgroundColor :"rgba(243,73,80,1.0)",
		},{
			label: "미계약건수",
			data: ${projectResultList[3]},
			backgroundColor: "rgba(0,203,129,0.0)",//background 의 opacity를 0으로
			borderColor : "rgba(0,203,129,0.7)",
			lineTension: 0.0,
			pointBackgroundColor: "rgba(0,203,129,0.5)",
			pointHoverBackgroundColor : "rgba(0,203,129,1.0)",
		}],
		
	};
	
	//각종 세부 option부분
	var options = {							
		layout: {
			padding: {left: 0, right: 0, top: 50, bottom: 0},
		},
		legend: {display: false},
		scales:{
			xAxes: [{
						gridLines: {display:false, tickMarkLength:15, zeroLineWidth:0, zeroLineColor:"rgba(0, 0, 0, 0.4)",},
					}],
			yAxes: [{
						position: "left",
						gridLines: {display:true, color:"rgba(0, 0, 0, 0.07)", drawTicks:true, tickMarkLength:10, zeroLineColor:"rgba(0, 0, 0, 0.4)", lineWidth:1},
						ticks: {padding:15, min:0, stepSize:1}
					}]
		},
		
		// 커스텀 툴팁
		tooltips: {
			mode: 'index',
			intersect: false,												
			callbacks: {
				label: function (tooltipItem, data) {
					var amount = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
					var tt = data.datasets[tooltipItem.datasetIndex].label;
					return tt + ': '+ amount + '건 ';
				}
			},
		},
		
		// 커스텀 라벨
		legendCallback: function(chart) {
			//console.log(chart.data);
			var text = [];
			text.push('<ul>');
			for (var i=0; i<chart.data.datasets.length; i++) {
				var total = 0;
				if(i == 0) {
					total = ${projectResultList[0]}.reduce(getSum);
				} else if (i == 1) {
					total = ${projectResultList[1]}.reduce(getSum);
				} else if (i == 2) {
					total = ${projectResultList[2]}.reduce(getSum);
				} else if (i == 3) {
					total = ${projectResultList[3]}.reduce(getSum);
				}
				
				text.push('<li>');
				text.push('<span style="background-color:' + chart.data.datasets[i].borderColor + '"></span>' + chart.data.datasets[i].label + ' ' + total + ' 건' +  '');
				text.push('</li>'); 
				
				/*
				text.push('<li>');
				text.push('<span style="background-color:' + chart.data.datasets[i].borderColor + '"></span>' + chart.data.datasets[i].label + '');
				text.push('</li>');
				*/
			}
			text.push('</ul>');
			return text.join("");
		}
	};
				
	var ctx = document.getElementById("lineChart03").getContext("2d");
	var myChart  = new Chart(ctx, {
		type: 'line',
		data: lineData,
		options: options
	});

	document.getElementById('chartLegend03').innerHTML = myChart.generateLegend();//커스텀 legend를 생성함				
<!-- 포로젝트 현황 라인차트 생성 스크립트 종료 -->	
	
<!-- 팀별인원 현황 도넛차트 생성 스크립트 시작 -->							
	//data 부분
	var pieData = {
		labels: ${teamResultList[0]},
		datasets: [{
			backgroundColor : ${teamResultList[2]},
			hoverBackgroundColor : ${teamResultList[2]},
			data : ${teamResultList[1]}
		}]
	};
	
	//각종 세부 option부분
	var pieOptions = {							
		layout: {
			padding: {left: 250, right: 0, top: 40, bottom: 40},
		},
		cutoutPercentage: 70,
		elements: {
			arc: {borderWidth: 0}
		},
		legend: {display: false},
		
		// 커스텀 라벨
		legendCallback: function(chart) {
			console.log(chart.data);
			console.log(chart.data.datasets[0].data);
			var text = [];
			text.push('<ul>');
			for (var i=0; i<chart.data.datasets[0].data.length; i++) {
				text.push('<li>');
				//text.push('<span style="background-color:' + chart.data.datasets[0].backgroundColor[i] + '"></span>' + chart.data.labels[i] + '' + '( ' + chart.data.datasets[0].data[i] + ' 명 )');
				text.push('<span style="background-color:' + chart.data.datasets[0].backgroundColor[i] + '"></span>' + chart.data.labels[i] + '');
				text.push('</li>');
			}
			
			text.push('</ul>');
			return text.join("");
		},
		
		tooltips: {
			mode: 'index',
			intersect: true,		
			position : 'average',
			callbacks: {
				label: function (tooltipItem, data) {
					var amount = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
					var tt = data.labels[tooltipItem.index];
					return tt + ': '+ amount + '명 ';
				}
			},
		},
	};
	
	var ctx2 = document.getElementById("pieChart04").getContext("2d");
	
	var myChart2  = new Chart(ctx2, {
		type: 'doughnut',
		data: pieData,
		// 도넛 가운데 텍스트 추가 부분
		plugins : [{
			beforeDraw: function(chart) {
			    var width = chart.chart.width,
			        height = chart.chart.height,
			        ctx2 = chart.chart.ctx;

			    ctx2.restore();
			    var fontSize = (height / 114).toFixed(2);
			    ctx2.font = fontSize + "em sans-serif";
			    ctx2.textBaseline = "middle";

			    var text = ${total_cnt}+ " 명",
			        textX = Math.round((width + 250 - ctx2.measureText(text).width) / 2),
			        textY = height / 2;

			    ctx2.fillText(text, textX, textY);
			    ctx2.save();
			  }
		}],
		options: pieOptions
	});
	
	document.getElementById('chartLegend04').innerHTML = myChart2.generateLegend();//커스텀 legend를 생성함			
<!-- 팀별인원 현황 도넛차트 생성 스크립트 시작 -->
</script>						
</html>