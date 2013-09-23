class Activity extends window.EpicMvc.ModelJS
	constructor: (Epic,view_nm) ->
		ss =
			total_posts : 6
		super Epic, view_nm, ss
		@cache_activities = []
	action: (act,p) ->
		debug = "action:#{act}"
		switch act
			when "view_more"
				console.log debug
				total_posts += 6;
				@Table = {}
						
	loadTable: (tbl_nm) ->
		debug = "loadTable:#{tbl_nm}"
		switch tbl_nm
			when 'ActivityPost'
				results = @getActivities()
				console.log debug, results
				@Table[tbl_nm] = results
	getActivities: () ->
		debug= "Activity.getActivities"
		console.log debug, @cache_activities
		return @cache_activities if @cache_activities.length
		results= []
		options = 
			url : 'http://www.dv-mobile.com/site/?json=get_posts&count=6'
			type : 'GET'
			dataType: 'jsonp'
		($.ajax options).always (data, textStatus, errorThrown) =>
			console.log debug, 'success function:', data
			for post in data.posts
				row = {}
				row.title = post.title_plain
				row.url = post.url
				row.picture = ''
				if post.thumbnail_images
					row.picture = post.thumbnail_images.full.url
				console.log debug, row
				results.push row
			@cache_activities = results
			@invalidateTables ['ActivityPost']
			console.log 'final table', results
window.EpicMvc.Model.Activity= Activity # Public API