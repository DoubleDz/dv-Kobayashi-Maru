
class User extends window.EpicMvc.ModelJS
	constructor: (Epic,view_nm) ->
		ss =
		super Epic, view_nm
		
	action: (act,p) ->
		debug = "action:#{act}"
		switch act
			when "home"
				console.log debug
				@Table = {}
						
	loadTable: (tbl_nm) ->
		debug = "loadTable:#{tbl_nm}"

	fistLoadData: (oFist) ->
	fistGetFieldChoices: (oFist,field_nm) ->

window.EpicMvc.Model.User= User # Public API
