
class User extends window.EpicMvc.ModelJS
	constructor: (Epic,view_nm) ->
		ss =
			active_service_part: ''
		super Epic, view_nm, ss
		
	action: (act,p) ->
		debug = "action:#{act}"
		switch act
			when "home"
				console.log debug
				@Table = {}
			when "focus_service_part"
				console.log debug
				@active_service_part = p.service_part
				@Table = {}
			when "clear_service_part"
				console.log debug
				@active_service_part = ''
				@Table = {}
	loadTable: (tbl_nm) ->
		debug = "loadTable:#{tbl_nm}"
		switch tbl_nm
			when 'Options'
				table = []
				options =
					active_service_part : @active_service_part
				table.push options
				console.log debug, table
				@Table[tbl_nm] = table

	fistLoadData: (oFist) ->
	fistGetFieldChoices: (oFist,field_nm) ->

window.EpicMvc.Model.User= User # Public API
