@tool
extends PanelContainer
class_name GovernatedProject

var controller : Govenor
var data_ref : GovernedProjInfoCollected


func setup_from_info(proj:GovernedProjInfoCollected, gov_main:Govenor):
	data_ref = proj
	controller = gov_main
	
	%ProjLabel.text = proj.proj_name
	%HasSgLabel.text = 'Yes' if proj.has_sg else "No"
	if proj.has_sg:
		%SgLastEdit.text = str(proj.sg_last_access) if proj.sg_last_access else " - "
		%SgSinceEdit.text = str(proj.sg_time_since_last_access) if proj.sg_time_since_last_access else " - "
	else:
		%SgLastEdit.text = " - "
		%SgSinceEdit.text = " - "
	
	%NodedHas.text = 'Yes' if proj.has_noded else "No"
	if proj.has_noded:
		%NodedLastEdit.text = str(proj.noded_last_access)
		%NodedSinceEdit.text = str(proj.noded_time_since_last_access)
	else:
		%NodedLastEdit.text = " - "
		%NodedSinceEdit.text = " - "
