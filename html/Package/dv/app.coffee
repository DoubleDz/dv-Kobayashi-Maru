window.EpicMvc.app$dv=
	OPTIONS:
		login:		flow: 'main'
		template:	default: 'main'
	MODELS:
		User:		class: 'User',	inst: 'dvU'
	FLOWS:
		main:
			start: 'home'
			template: 'main'
			TRACKS:
				home:
					start:'landing'
					CLICKS:
						home:		call: 'User/home', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//main'} ]
					STEPS:
						landing:	page:'main'
