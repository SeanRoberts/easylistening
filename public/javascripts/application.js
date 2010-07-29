// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function updatePlayer() {
	$.get('/player/now_playing', null, function(data) {
		$('#info').html(data);
	});
}

$(function() {
	setInterval('updatePlayer();', 1000);
	$('.play-link').click(function(e) {
		e.preventDefault();
		$.get(this);
	});
});