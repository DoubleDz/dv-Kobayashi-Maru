window.EpicMvc.fist$mnc=
	FIELDS:
		
		Company:   { db_nm:'companynm',type:'text', req:true, h2h:'trim_spaces', label: 'Company Name'}
		First:     { db_nm:'firstnm',  type:'text', req:true, h2h:'trim_spaces', label: 'First Name'}
		Last:      { db_nm:'lastnm',   type:'text', req:true, h2h:'trim_spaces', label: 'Last Name'}
		Phone:     { db_nm:'phone',    type:'text', req:true, h2h:'trim_spaces', label: 'Phone Number'}

	FISTS:
	
		Contact: ['Company','First','Last','Phone']

	
