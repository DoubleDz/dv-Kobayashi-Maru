window.EpicMvc.app$dv=
	OPTIONS:
		login:		flow: 'main'
		template:	default: 'main', slide: 'modal'
	MODELS:
		User:		class: 'User',	inst: 'dvU'
		Activity:	class: 'Activity', inst: 'dvA'
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
						clear_service_part: call: 'User/clear_service_part'
						go_mobile_activation: 	 call: 'User/focus_service_part', p:{service_part:'mobile_activation'}
						go_mobile_sdk_api: 		 call: 'User/focus_service_part', p:{service_part:'mobile_sdk_api'}
						go_mobile_strat_plan: 	 call: 'User/focus_service_part', p:{service_part:'mobile_strat_plan'}
						go_mobile_voice: 		 call: 'User/focus_service_part', p:{service_part:'mobile_voice_activation'}
						go_social_integration:	 call: 'User/focus_service_part', p:{service_part:'social_integration'}
						go_cloud_strat: 		 call: 'User/focus_service_part', p:{service_part:'cloud_strat'}
						go_mobile_customization: 	call: 'User/focus_service_part', p:{service_part:'mobile_customization'}
						go_about_dvmobile: 		 call: 'Pageflow/save_path', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//about_dvmobile'} ]
						go_about_leadership: 		 call: 'Pageflow/save_path', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//about_leadership'} ]
						go_about_career: 		 call: 'Pageflow/save_path', RESULTS: [
							r:{}, call: 'Pageflow/path', p:{path:'//about_career'} ]
						go_news_post: 	call: 'Activity/set_active_post_url', use_fields: 'url', RESULTS: [
							r: {}, call: 'Pageflow/save_path', RESULTS: [
								r:{}, call: 'Pageflow/path', p:{path:'//news_post'} ] ]	 		
					STEPS:
						landing:	page:'main'
						about_dvmobile: page:'about_dvmobile', modal: 'slide'
						about_leadership: page:'about_leadership', modal: 'slide'
						about_career: page:'about_career', modal: 'slide'
						news_post: page: 'news_post', modal: 'slide'
