window.EpicMvc.app$dv=
	OPTIONS:
		login:		flow: 'main'
		template:	default: 'main', slide: 'modal'
	MODELS:
		User:		class: 'User',	inst: 'dvU'
	MACROS:
		close_modal: call:'Pageflow/restore_path'
	CLICKS:
		close_modal: macro: 'close_modal'
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
						go_mobile_activation: 	 call: 'Pageflow/save_path', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//mobile_activation'} ]
						go_mobile_sdk_api: 		 call: 'Pageflow/save_path', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//mobile_sdk_api'} ]
						go_mobile_strat_plan: 	 call: 'Pageflow/save_path', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//mobile_strat_plan'} ]
						go_mobile_voice: 		 call: 'Pageflow/save_path', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//mobile_voice'} ]
						go_social_integration:	 call: 'Pageflow/save_path', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//social_integration'} ]
						go_cloud_strat: 		 call: 'Pageflow/save_path', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//cloud_strat'} ]
						go_about_dvmobile: 		 call: 'Pageflow/save_path', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//about_dvmobile'} ]
						go_about_leadership: 		 call: 'Pageflow/save_path', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//about_leadership'} ]
						go_about_career: 		 call: 'Pageflow/save_path', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//about_career'} ]
					STEPS:
						landing:	page:'main'
						mobile_activation: page:'mobile_activation', modal: 'slide'
						mobile_sdk_api: page:'mobile_sdk_api', modal: 'slide'
						mobile_strat_plan: page:'mobile_strat_plan', modal: 'slide'
						mobile_voice: page:'mobile_voice_activation', modal: 'slide'
						social_integration: page:'social_integration', modal: 'slide'
						cloud_strat: page:'cloud_strat', modal: 'slide'
						about_dvmobile: page:'about_dvmobile', modal: 'slide'
						about_leadership: page:'about_leadership', modal: 'slide'
						about_career: page:'about_career', modal: 'slide'
