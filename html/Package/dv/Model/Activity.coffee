class Activity extends window.EpicMvc.ModelJS
	constructor: (Epic,view_nm) ->
		ss =
			total_posts : 6
		super Epic, view_nm, ss
		
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
		console.log debug
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
				row.picture = ''
				if post.attachments[0]
					row.picture = post.attachments[0].url
				console.log debug, row
				results.push row
			@Table['ActivityPost'] = results
			console.log 'final table', results
		return results
window.EpicMvc.Model.Activity= Activity # Public API