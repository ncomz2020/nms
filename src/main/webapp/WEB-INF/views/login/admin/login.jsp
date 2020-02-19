<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script>
$(window).on('load', function () {

	$("#textId").keypress(function( event ) {
		if ( event.which == 13 ) {
			login();				
		}
	});
	$("#textNm").keypress(function( event ) {
		if ( event.which == 13 ) {
			login();				
		}
	});

	$("#textLang").change(function () {
		movePage('/admin/login?lang='+this.value)
	});
});

function login(bForce) {
	if (bForce == null) {
		bForce = false;
	}

	var f = document.formLogin;
	
	<!-- ////////// ID 저장 , 쿠키에 저장된 ID 값 불러온다 ///////// -->
	/*
	if (f.checkBox_01.checked == true) {
		var usercookieId = $(f.textId).val();
		setCookie("usercookieId",usercookieId ,7);
		
	}else{
		deleteCookie("usercookieId");
	}
	*/
	if (f.textId.value == "") {
		swal({
	        title: '<spring:message code="msg.login.valid.chk.id" />'
	    });
		f.textId.focus();
		return;
	}

	if (f.textNm.value == "") {
		swal({
	        title: '<spring:message code="msg.login.valid.chk.pw" />'
	    });
		f.textNm.focus();
		return;
	}
	
	var param = new Object();
	param.textId = replaceall($("#textId").val());
	param.textNm = replaceall($("#textNm").val());
	param.textLang = replaceall($("#textLang").val());
	param.force = bForce;
		
	$.ajax({
	url : '/login/admin/loginAction',
	type : 'POST',
	data : param,
	success : function(data) {
		if (data == "GO_MAIN") {
			console.log("go_main");
			movePage('/admin/dash/dashView');
			//movePage('/admin/user/userList');
		} else if (data == "ERROR_INPUT_NULL") {
    		swal({
    	        title: '<spring:message code="msg.login.error.input.null" />'
    	    });
    		deleteCookie("usercookieId");
		} else if (data == "LOGIN_FAIL") {
    		swal({
    	        title: '<spring:message code="msg.login.fail.login" />'
    	    });
    		deleteCookie("usercookieId");
		} else if (data == "ALREADY_LOGGED_IN") {
			movePage('/admin/dash/dashView');
			//movePage('/admin/user/userList');
		} else if (data == "ID_DOES_NOT_EXIST") {
    		swal({
    	        title: '<spring:message code="msg.login.does.not.id" />'
    	    });
    		deleteCookie("usercookieId");
		}
	},
	error : function(e) {
		console.log(e.responseText.trim());
		viewLayer(e.responseText.trim());
	},
	complete : function() {
	}
	});

}

//Validation Chk
function isValid() {

	return false;
}

function searchIdPw() {
	movePage('/login/admin/searchIdPw');
}

function goSignin() {
	movePage('/admin/user/userInsert');
}

//setCookie를 위한 함수, ID값 쿠키 생성
function setCookie(cookieName, value, exdays){
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var cookieValue = escape(value) + ((exdays==null)? "": "; expires="+ exdate.toGMTString());
	document.cookie = cookieName + "=" + cookieValue;
	//체크 박스 유지
	
}
//쿠키 삭제
function deleteCookie(cookieName){
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = cookieName + "= "+ "; expires="+ expireDate.toGMTString();
}
//쿠키 가져오기
function getCookie(cookieName){
	console.log(cookieName);				
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	  if(start != -1){
		start += cookieName.length;
		var end = cookieData.indexOf(';',start);
		if(end == -1) end = cookieData.length;
		cookieValue = cookieData.substring(start,end);
	} 
	return unescape(cookieValue);
}
</script>
<body class="fullPage"><!-- fullPage 창을 표시할려면 반드시 body에 fullPage 클래스명 추가 // 필수 -->

<div class="amb_layout_common amb_admin_layout_temp_01"><!-- class명 amb_layout_common :필수  / amb_admin_layout_temp_01:필수(사이트 레이아웃 결정) -->
	
	<div class="content loginStyle_ncomz"><!-- 로그인 스타일을 class명으로 지정함 // loginStyle04 // background 이미지 & 컨텐츠 센터형2 -->
		
		<!-- ////////////// 롤링 페이드 인아웃 관련 /////////////// -->
		<!-- 롤링 페이드 인아웃 이미지 영역 -->
		<div class="loginBgBox"> 
			<div id="loginBg1" class="loginBg bg01" style="opacity: 1;"></div>
			<div id="loginBg2" class="loginBg bg02" style="opacity: 0;"></div>
			<div id="loginBg3" class="loginBg bg03" style="opacity: 0;"></div>
		</div>

		<style type="text/css">
			.bgShow {z-index:1 !important}
		</style>

		

		<!-- ////////////// background color gradient 변경효과 관련 /////////////// -->
		<div id="gradientBg" class="bgGradient"></div>

		<script type="text/javascript">
		//background color gradient change 스크립트
		$(document).ready(function() {	
			var colors = new Array(
			  [62,35,255],
			  [77,153,77],
			  [179,11,59],
			  [31,108,140]
			);

			var step = 0;
			var colorIndices = [0,1,2,3];

			//transition speed
			var gradientSpeed = 0.001;

			function updateGradient(){	
				
				if ( $===undefined ) return;
				  
				var c0_0 = colors[colorIndices[0]];
				var c0_1 = colors[colorIndices[1]];
				var c1_0 = colors[colorIndices[2]];
				var c1_1 = colors[colorIndices[3]];

				var istep = 1 - step;
				var r1 = Math.round(istep * c0_0[0] + step * c0_1[0]);
				var g1 = Math.round(istep * c0_0[1] + step * c0_1[1]);
				var b1 = Math.round(istep * c0_0[2] + step * c0_1[2]);
				var color1 = "rgb("+r1+","+g1+","+b1+")";

				var r2 = Math.round(istep * c1_0[0] + step * c1_1[0]);
				var g2 = Math.round(istep * c1_0[1] + step * c1_1[1]);
				var b2 = Math.round(istep * c1_0[2] + step * c1_1[2]);
				var color2 = "rgb("+r2+","+g2+","+b2+")";

				$('#gradientBg').css({
					background: "-webkit-gradient(linear, left top, right top, from("+color1+"), to("+color2+"))"}).css({
					background: "-moz-linear-gradient(left, "+color1+" 0%, "+color2+" 100%)"}).css({
					background: "linear-gradient(to right, "+color1+" 0%, "+color2+" 100%)"});
			  
				step += gradientSpeed;
				if ( step >= 1 )
				{
					step %= 1;
					colorIndices[0] = colorIndices[1];
					colorIndices[2] = colorIndices[3];

					//pick two new target color indices
					//do not pick the same as the current one
					colorIndices[1] = ( colorIndices[1] + Math.floor( 1 + Math.random() * (colors.length - 1))) % colors.length;
					colorIndices[3] = ( colorIndices[3] + Math.floor( 1 + Math.random() * (colors.length - 1))) % colors.length;				
				}
			}

			setInterval(updateGradient,10);
		});
		</script>
		<!-- ////////////// background color gradient 변경효과 관련 /////////////// -->
		
		<!-- //////////////  센터 particle 부분  ////////////// -->
		<script src="/js/plugins/etc/modernizr-2.0.6.js"></script>

		<script type="text/javascript">
			window.addEventListener("load", windowLoadHandler, false);

			//for debug messages
			var Debugger = function() { };
			Debugger.log = function(message) {
				try {
					console.log(message);
				}
				catch (exception) {
					return;
				}
			}

			function windowLoadHandler() {
				canvasApp();
			}

			function canvasSupport() {
				return Modernizr.canvas;
			}

			function canvasApp() {
				if (!canvasSupport()) {
					return;
				}
				
				var theCanvas = document.getElementById("canvasOne");
				var context = theCanvas.getContext("2d");
				
				var displayWidth;
				var displayHeight;
				var timer;
				var wait;
				var count;
				var numToAddEachFrame;
				var particleList;
				var recycleBin;
				var particleAlpha;
				var r,g,b;
				var fLen;
				var m;
				var projCenterX;
				var projCenterY;
				var zMax;
				var turnAngle;
				var turnSpeed;
				var sphereRad, sphereCenterX, sphereCenterY, sphereCenterZ;
				var particleRad;
				var zeroAlphaDepth;
				var randAccelX, randAccelY, randAccelZ;
				var gravity;
				var rgbString;
				//we are defining a lot of variables used in the screen update functions globally so that they don't have to be redefined every frame.
				var p;
				var outsideTest;
				var nextParticle;
				var sinAngle;
				var cosAngle;
				var rotX, rotZ;
				var depthAlphaFactor;
				var i;
				var theta, phi;
				var x0, y0, z0;
					
				init();
				
				function init() {
					wait = 1;
					count = wait - 1;
					numToAddEachFrame = 8;
					
					//particle color
					r = 0;
					g = 220;
					b = 255;
					
					rgbString = "rgba("+r+","+g+","+b+","; //partial string for color which will be completed by appending alpha value.
					particleAlpha = 1; //maximum alpha
					
					displayWidth = theCanvas.width;
					displayHeight = theCanvas.height;
					
					fLen = 320; //represents the distance from the viewer to z=0 depth.
					
					//projection center coordinates sets location of origin
					projCenterX = displayWidth/2;
					projCenterY = displayHeight/2;
					
					//we will not draw coordinates if they have too large of a z-coordinate (which means they are very close to the observer).
					zMax = fLen-2;
					
					particleList = {};
					recycleBin = {};
					
					//random acceleration factors - causes some random motion
					randAccelX = 0.1;
					randAccelY = 0.1;
					randAccelZ = 0.1;
					
					gravity = 0; //try changing to a positive number (not too large, for example 0.3), or negative for floating upwards.
					
					particleRad = 2.5;
					sphereRad = 280;
					sphereCenterX = 0;
					sphereCenterY = 0;
					sphereCenterZ = -3 - sphereRad;
					
					//alpha values will lessen as particles move further back, causing depth-based darkening:
					zeroAlphaDepth = -750; 
					
					turnSpeed = 2*Math.PI/1600; //the sphere will rotate at this speed (one complete rotation every 1600 frames).
					turnAngle = 0; //initial angle
					
					timer = setInterval(onTimer, 1000/24);
				}
				
				function onTimer() {
					//if enough time has elapsed, we will add new particles.		
					count++;
						if (count >= wait) {
									
						count = 0;
						for (i = 0; i < numToAddEachFrame; i++) {
							theta = Math.random()*2*Math.PI;
							phi = Math.acos(Math.random()*2-1);
							x0 = sphereRad*Math.sin(phi)*Math.cos(theta);
							y0 = sphereRad*Math.sin(phi)*Math.sin(theta);
							z0 = sphereRad*Math.cos(phi);
							
							//We use the addParticle function to add a new particle. The parameters set the position and velocity components.
							//Note that the velocity parameters will cause the particle to initially fly outwards away from the sphere center (after
							//it becomes unstuck).
							var p = addParticle(x0, sphereCenterY + y0, sphereCenterZ + z0, 0.002*x0, 0.002*y0, 0.002*z0);
							
							//we set some "envelope" parameters which will control the evolving alpha of the particles.
							p.attack = 0;
							p.hold = 50;
							p.decay = 200;
							p.initValue = 0;
							p.holdValue = particleAlpha;
							p.lastValue = 0;
							
							//the particle will be stuck in one place until this time has elapsed:
							p.stuckTime = 80 + Math.random()*20;
							
							p.accelX = 0;
							p.accelY = gravity;
							p.accelZ = 0;
						}
					}
					
					//update viewing angle
					turnAngle = (turnAngle + turnSpeed) % (3*Math.PI);
					sinAngle = Math.sin(turnAngle);
					cosAngle = Math.cos(turnAngle);

					//background fill
					context.fillStyle = "#000";
					context.fillRect(0,0,displayWidth,displayHeight);
					
					//update and draw particles
					p = particleList.first;
					while (p != null) {
						//before list is altered record next particle
						nextParticle = p.next;
						
						//update age
						p.age++;
						
						//if the particle is past its "stuck" time, it will begin to move.
						if (p.age > p.stuckTime) {	
							p.velX += p.accelX + randAccelX*(Math.random()*2 - 1);
							p.velY += p.accelY + randAccelY*(Math.random()*2 - 1);
							p.velZ += p.accelZ + randAccelZ*(Math.random()*2 - 1);
							
							p.x += p.velX;
							p.y += p.velY;
							p.z += p.velZ;
						}
						
						/*
						We are doing two things here to calculate display coordinates.
						The whole display is being rotated around a vertical axis, so we first calculate rotated coordinates for
						x and z (but the y coordinate will not change).
						Then, we take the new coordinates (rotX, y, rotZ), and project these onto the 2D view plane.
						*/
						rotX = cosAngle*p.x + sinAngle*(p.z - sphereCenterZ);
						rotZ = -sinAngle*p.x + cosAngle*(p.z - sphereCenterZ) + sphereCenterZ;
						m = fLen/(fLen - rotZ);
						p.projX = rotX*m + projCenterX;
						p.projY = p.y*m + projCenterY;
							
						//update alpha according to envelope parameters.
						if (p.age < p.attack+p.hold+p.decay) {
							if (p.age < p.attack) {
								p.alpha = (p.holdValue - p.initValue)/p.attack*p.age + p.initValue;
							}
							else if (p.age < p.attack+p.hold) {
								p.alpha = p.holdValue;
							}
							else if (p.age < p.attack+p.hold+p.decay) {
								p.alpha = (p.lastValue - p.holdValue)/p.decay*(p.age-p.attack-p.hold) + p.holdValue;
							}
						}
						else {
							p.dead = true;
						}
						
						//see if the particle is still within the viewable range.
						if ((p.projX > displayWidth)||(p.projX<0)||(p.projY<0)||(p.projY>displayHeight)||(rotZ>zMax)) {
							outsideTest = true;
						}
						else {
							outsideTest = false;
						}
						
						if (outsideTest||p.dead) {
							recycle(p);
						}
						
						else {
							//depth-dependent darkening
							depthAlphaFactor = (1-rotZ/zeroAlphaDepth);
							depthAlphaFactor = (depthAlphaFactor > 1) ? 1 : ((depthAlphaFactor<0) ? 0 : depthAlphaFactor);
							context.fillStyle = rgbString + depthAlphaFactor*p.alpha + ")";
							
							//draw
							context.beginPath();
							context.arc(p.projX, p.projY, m*particleRad, 0, 2*Math.PI, false);
							context.closePath();
							context.fill();
						}
						
						p = nextParticle;
					}
				}
					
				function addParticle(x0,y0,z0,vx0,vy0,vz0) {
					var newParticle;
					var color;
					
					//check recycle bin for available drop:
					if (recycleBin.first != null) {
						newParticle = recycleBin.first;
						//remove from bin
						if (newParticle.next != null) {
							recycleBin.first = newParticle.next;
							newParticle.next.prev = null;
						}
						else {
							recycleBin.first = null;
						}
					}
					//if the recycle bin is empty, create a new particle (a new ampty object):
					else {
						newParticle = {};
					}
					
					//add to beginning of particle list
					if (particleList.first == null) {
						particleList.first = newParticle;
						newParticle.prev = null;
						newParticle.next = null;
					}
					else {
						newParticle.next = particleList.first;
						particleList.first.prev = newParticle;
						particleList.first = newParticle;
						newParticle.prev = null;
					}
					
					//initialize
					newParticle.x = x0;
					newParticle.y = y0;
					newParticle.z = z0;
					newParticle.velX = vx0;
					newParticle.velY = vy0;
					newParticle.velZ = vz0;
					newParticle.age = 0;
					newParticle.dead = false;
					if (Math.random() < 0.5) {
						newParticle.right = true;
					}
					else {
						newParticle.right = false;
					}
					return newParticle;		
				}
				
				function recycle(p) {
					//remove from particleList
					if (particleList.first == p) {
						if (p.next != null) {
							p.next.prev = null;
							particleList.first = p.next;
						}
						else {
							particleList.first = null;
						}
					}
					else {
						if (p.next == null) {
							p.prev.next = null;
						}
						else {
							p.prev.next = p.next;
							p.next.prev = p.prev;
						}
					}
					//add to recycle bin
					if (recycleBin.first == null) {
						recycleBin.first = p;
						p.prev = null;
						p.next = null;
					}
					else {
						p.next = recycleBin.first;
						recycleBin.first.prev = p;
						recycleBin.first = p;
						p.prev = null;
					}
				}	
			}
		</script>

		<div class="canvasBg2">
			<canvas id="canvasOne" width="900" height="700" />
		</div>
		<style type="text/css">
			.canvasBg2 {position:fixed; width:100%; height:100%; z-index:0; top:0; left:0; bottom:0; right:0; opacity:0.8 !important; overflow:hidden; background:#000;}
			.canvasBg2 canvas {display:block; width:900px; height:700px; position:absolute; top:50%; left:50%; margin-top:-350px; margin-left:-450px;}
		</style>
		<!-- //////////////  센터 particle 부분  ////////////// -->


		<!-- 좌측 컨텐츠 영역 -->
		<div  class="loginDetail">
			<!-- -->
			<div id="canvas" class="canvasBg"></div>
			
			
			<!-- Main library  -->
			<script src="/js/plugins/three3D/three.min.js"></script>
		  
			
			<script src="/js/plugins/three3D/renderers/Projector.js"></script>
			<script src="/js/plugins/etc/canvas-renderer.js"></script>
			
			<script type="text/javascript">
			var mouseX = 0, mouseY = 0,

            windowHalfX = window.innerWidth / 2,
            windowHalfY = window.innerHeight / 2,

            SEPARATION = 200,
            AMOUNTX = 1,
            AMOUNTY = 1,

            camera, scene, renderer;

            init_make();
            animate();

            function init_make() {
                /*
                 *   Define variables
                 */
                var container, separation = 1000, amountX = 50, amountY = 50, color = 0xffffff,
                particles, particle;

                container = document.getElementById("canvas");


                camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 1, 10000 );
                camera.position.z = 100;

                scene = new THREE.Scene();

                renderer = new THREE.CanvasRenderer({ alpha: true });
                renderer.setPixelRatio( window.devicePixelRatio );
                renderer.setClearColor( 0x000000, 0 );   // canvas background color
                renderer.setSize( window.innerWidth, window.innerHeight );
                container.appendChild( renderer.domElement );

                var PI2 = Math.PI * 2;
                var material = new THREE.SpriteCanvasMaterial( {

                    color: color,
                    opacity: 0.8,
                    program: function ( context ) {
                        context.beginPath();
                        context.arc( 0, 0, 0.5, 0, PI2, true );
                        context.fill();
                    }
                });

                var geometry = new THREE.Geometry();

                /*
                 *   Number of particles
                 */
                for ( var i = 0; i < 150; i ++ ) {

                    particle = new THREE.Sprite( material );
                    particle.position.x = Math.random() * 2 - 1;
                    particle.position.y = Math.random() * 2 - 1;
                    particle.position.z = Math.random() * 2 - 1;
                    particle.position.normalize();
                    particle.position.multiplyScalar( Math.random() * 10 + 600 );
                    particle.scale.x = particle.scale.y = 5;

                    scene.add( particle );

                    geometry.vertices.push( particle.position );
                }

                /*
                 *   Lines
                 */

                var line = new THREE.Line( geometry, new THREE.LineBasicMaterial( { color: color, opacity: 0.05 } ) );
                scene.add( line );

                document.addEventListener( 'mousemove', onDocumentMouseMove, false );
                document.addEventListener( 'touchstart', onDocumentTouchStart, false );
                document.addEventListener( 'touchmove', onDocumentTouchMove, false );

                window.addEventListener( 'resize', onWindowResize, false );

            }

            function onWindowResize() {
                windowHalfX = window.innerWidth / 2;
                windowHalfY = window.innerHeight / 2;

                camera.aspect = window.innerWidth / window.innerHeight;
                camera.updateProjectionMatrix();

                renderer.setSize( window.innerWidth, window.innerHeight );
            }

            function onDocumentMouseMove(event) {
                mouseX = (event.clientX - windowHalfX) * 0.05;
                mouseY = (event.clientY - windowHalfY) * 0.2;
            }

            function onDocumentTouchStart( event ) {
                if ( event.touches.length > 1 ) {
                    event.preventDefault();
                    mouseX = (event.touches[ 0 ].pageX - windowHalfX) * 0.7;
                    mouseY = (event.touches[ 0 ].pageY - windowHalfY) * 0.7;
                }
            }

            function onDocumentTouchMove( event ) {
                if ( event.touches.length == 1 ) {
                    event.preventDefault();
                    mouseX = event.touches[ 0 ].pageX - windowHalfX;
                    mouseY = event.touches[ 0 ].pageY - windowHalfY;
                }
            }

            //

            function animate() {
                requestAnimationFrame( animate );
                render();
            }

            function render() {
                camera.position.x += ( mouseX - camera.position.x ) * 0.1;
                camera.position.y += ( - mouseY + 200 - camera.position.y ) * 0.05;
                camera.lookAt( scene.position );
                renderer.render( scene, camera );
            }
			
			</script>
			

			<div class="effectTextWrap">
				<div class="ncomzTitle">
					<em>N</em>
					<em>C</em>
					<em>O</em>
					<em>M</em>
					<em>Z</em>
				</div>
				

				<div class="bigText">
					<div class="text1">WE ARE</div>
					<div class="text2">WEB DEVELOPER</div>

					<div class="exText">We provide a variety of solutions and platforms with innovative convergence services. We strive to make our complex systems simple and easy to use, and we strive to provide a sincere answer to your needs.</div>
				</div>

				<style>
					.effectTextWrap {position: absolute; top: 50%;  right: 50%; transform: translate(50%,-60%); color:#fff;}
					.ncomzTitle{font-size:80px; color:#00dcff; font-family:Roboto !important; font-weight:600; text-transform:uppercase; letter-spacing:-0.05em; transform:scaleY(0.85);
								text-shadow:1px 1px 1px #0090a7,
											1px 2px 1px #0090a7,
											1px 3px 1px #0090a7,
											1px 4px 1px #0090a7,
											1px 5px 1px #0090a7,
											1px 6px 1px #0090a7,
											1px 7px 1px #0090a7,
											1px 13px 6px rgba(0,0,0,0.4),
											1px 17px 10px rgba(0,0,0,0.2),
											1px 20px 35px rgba(0,0,0,0.2),
											1px 25px 60px rgba(0,0,0,0.4);
					}
					.ncomzTitle em:nth-of-type(1) {
						text-shadow:1px 1px 1px #01a780,
									1px 2px 1px #01a780,
									1px 3px 1px #01a780,
									1px 4px 1px #01a780,
									1px 5px 1px #01a780,
									1px 6px 1px #01a780,
									1px 7px 1px #01a780,
									1px 13px 6px rgba(0,0,0,0.4),
									1px 17px 10px rgba(0,0,0,0.2),
									1px 20px 35px rgba(0,0,0,0.2),
									1px 25px 60px rgba(0,0,0,0.4);
					}
					.ncomzTitle em {display:inline-block; letter-spacing:-0.1em; animation:ani_bounceInDown 0.5s ease-out 0s 1 alternate; }
					.ncomzTitle em:nth-of-type(1) {animation-delay: 0s; color:#00ffc4;}
					.ncomzTitle em:nth-of-type(2) {animation-delay: 0.2s;}
					.ncomzTitle em:nth-of-type(3) {animation-delay: 0.4s;}
					.ncomzTitle em:nth-of-type(4) {animation-delay: 0.6s;}
					.ncomzTitle em:nth-of-type(5) {animation-delay: 0.8s;}
					.bigText {font-size:24px; margin-top:30px;}
					.bigText .text1,
					.bigText .text2 {display:inline-block; text-transform:;}

					.bigText .text1 {font-weight:700; color:#00dcff;}
					.bigText .text2 {}
					.exText {opacity:0.5; font-size:13px; margin-top:10px;}

					@keyframes ani_bounceInDown {
						0%   {opacity:0; transform:translateY(-2000px);}
						60%  {opacity:1; transform:translateY(30px);}
						80%  {transform: translateY(-10px);}
						100% {transform: translateY(0);}
					 }

					 @media only screen and (max-width: 1200px) {
						.effectTextWrap {width:70%;}
						.ncomzTitle{font-size:70px; letter-spacing:-0.1em;}
					 }
				</style>

				<script src="//cdnjs.cloudflare.com/ajax/libs/typed.js/1.1.1/typed.min.js"></script>
				<script>
				$(function() {
					$('.text2').typed({
						strings: ["Web Developer", "App Developer", "Creative Design",  "Service planning"],
						typeSpeed: 50,
						backSpeed: 10,
						backDelay: 2000,
						showCursor: false,
						loop: true
					});
					$(".exText").typed({
						strings: ["We provide a variety of solutions and platforms with innovative convergence services. We strive to make our complex systems simple and easy to use, and we strive to provide a sincere answer to your needs."],
						typeSpeed: 1,
						backSpeed: 0,
						backDelay: 0,
						showCursor: false,
						loop: false
					});
				});

				
				</script>
			</div>
			
			
			
		</div>
		
		
		<!-- 우측 실제 로그인 영역 -->
		<div class="loginPage">
			<div class="loginPageBox">
				<h1>
					<span class="title"><spring:message code="msg.login.login.title" /> <em class="ex"><spring:message code="msg.login.login.subtitle" /></em></span>
				</h1>

				<!-- 필요없는 경우 삭제 
				<div class="selectLang">
					<a href="#" class="amb_btnstyle middle" id="" >O'ZB</a>				
					<a href="#" class="amb_btnstyle middle active" id="" >РУС</a>				
					<a href="#" class="amb_btnstyle middle" id="" >ENG</a>				
				</div>

				
				<script type="text/javascript">
					$(document).on("click", ".selectLang a", function(){
						$(this).siblings().removeClass('active');
						$(this).addClass('active');
					});
				</script>
				<!-- //필요없는 경우 삭제 -->
				<form method="post" id="formLogin" action="/login/login" name="formLogin">
					<fieldset class="loginBox">				
						<input type="text" class="id" id="textId" name="textId" placeholder="ID" value="admin"/>
						<input type="password" class="pw" id="textNm" name="textNm" placeholder="PASSWORD" value="admin"/>
						
						 
						<select id="textLang" name="textLang">
							<option value="" selected>언어선택</option>
						    <option value="ko">한국어</option>
						    <option value="en">English</option>
						</select>
						
	
						<div class="loginSetting">
							<span class="fl">
								<!-- <input type="checkbox" id="checkBox_01" checked/><label for="checkBox_01" class="inp_func">로그인 상태 유지</label> -->
							</span>
	
							<span class="fr">
								<!-- <a href="javascript:searchIdPw();" class="underline"><spring:message code="msg.login.search.idpw" /></a> -->
							</span>
							
						</div>
	
						<div class="loginBtn">
							<a href="javascript:login()" class="amb_btnstyle blue large">LOGIN</a>
						</div>
					</fieldset>
					<div class="copyright"><spring:message code="msg.login.bottom.copyright" /></div>
				</form>				
			</div>
		</div>
		<!-- //우측 실제 로그인 영역 -->
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {	
	var _this = $('.loginPage');

	// 로그인 페이지에서만 필요한 ui js // body에 클래스명 추가
	_this.parents('body').addClass('loginPage');

});
</script>
</body>




