class Activity extends window.EpicMvc.ModelJS
	constructor: (Epic,view_nm) ->
		ss =
			total_posts : 10
			active_post_url: false
		super Epic, view_nm, ss
		@cache_activities = []
	action: (act,p) ->
		debug = "action:#{act}"
		console.log debug, p
		r= {}; i= new window.EpicMvc.Issue @Epic, @view_nm, act; m= new window.EpicMvc.Issue @Epic, @view_nm, act
		switch act
			when "view_more"
				console.log debug
				total_posts += 6;
				@Table = {}
			when "set_active_post_url"
				console.log debug
				@active_post_url = p.url
				@invalidateTables ['ActivePostUrl']
		[r,i,m]
	loadTable: (tbl_nm) ->
		debug = "loadTable:#{tbl_nm}"
		switch tbl_nm
			when 'ActivityPost'
				results = @getActivities()
				console.log debug, results
				@Table[tbl_nm] = results
			when 'ActivePostUrl'
				table = []
				table.push { url: @active_post_url }
				@Table[tbl_nm] = table
	getActivities: () ->
		debug= "Activity.getActivities"
		console.log debug, @cache_activities
		return @cache_activities if @cache_activities.length
		results= []
		options = 
			url : 'http://www.dv-mobile.com/I/api/get_category_posts/?category_slug=featured&count=10'
		#	url : 'http://www.dv-mobile.com/dev/api/get_category_posts/?category_slug=featured&count=10'
			type : 'GET'
			dataType: 'jsonp'
		($.ajax options).always (data, textStatus, errorThrown) =>
			console.log debug, 'success function:', data
			if data.status is 'ok'
				for post in data.posts
					row = {}
					row.title = post.title
					row.url = post.url
					row.picture = ''
					if post.thumbnail_images
						row.picture = post.thumbnail_images.full.url
					console.log debug, row
					results.push row
				@cache_activities = results
				@invalidateTables ['ActivityPost']
				console.log 'final table', results
			else console.log debug, 'Unable to load activity feed:', errorThrown
window.EpicMvc.Model.Activity= Activity # Public API