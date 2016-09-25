
drop table if exists traffic.crash;

CREATE TABLE traffic.crash (
	crash_data_identifier VARCHAR(89) NOT NULL, 
	county VARCHAR(31), 
	city VARCHAR(33), 
	year_of_crash VARCHAR(24), 
	month_of_crash VARCHAR(42), 
	time_of_day VARCHAR(57), 
	data_source VARCHAR(22), 
	this_unit_was_causal_unit VARCHAR(37), 
	highway_classifications VARCHAR(35), 
	primary_contributing_circumstance VARCHAR(71), 
	first_harmful_event VARCHAR(51), 
	e_most_harmful_event VARCHAR(49), 
	e_distracted_driving VARCHAR(52), 
	e_manner_of_crash VARCHAR(78), 
	school_bus_related VARCHAR(38), 
	crash_severity VARCHAR(31), 
	ems_arrival_delay VARCHAR(31), 
	aldot_region VARCHAR(24), 
	unit_type VARCHAR(39), 
	non_motorist_indicator VARCHAR(50), 
	commercial_motor_vehicle_indicator VARCHAR(22), 
	driver_raw_age VARCHAR(22), 
	driver_race VARCHAR(23), 
	driver_gender VARCHAR(23), 
	driver_residence_distance VARCHAR(23), 
	driver_license_state VARCHAR(23), 
	driver_first_license_class VARCHAR(86), 
	driver_second_license_class VARCHAR(22), 
	driver_license_status VARCHAR(40), 
	driver_cdl_status VARCHAR(50), 
	dl_restriction_violations_1 VARCHAR(68), 
	dl_restriction_violations_2 VARCHAR(93), 
	endorsement_violations_1 VARCHAR(24), 
	e_endorsement_violations_2 VARCHAR(93), 
	e_driver_employment_status VARCHAR(24), 
	driver_condition VARCHAR(39), 
	driver_officer_opinion_alcohol VARCHAR(46), 
	driver_officer_opinion_drugs VARCHAR(44), 
	driver_type_alcohol_test_given VARCHAR(30), 
	e_driver_type_drug_test_given VARCHAR(67), 
	driver_alcohol_test_results VARCHAR(26), 
	e_driver_drug_test_results VARCHAR(65), 
	initial_travel_direction VARCHAR(31), 
	vehicle_maneuvers VARCHAR(34), 
	vehicle_most_harmful_event VARCHAR(87), 
	contributing_circumstance VARCHAR(62), 
	first_harmful_event_location VARCHAR(51), 
	e_sequence_of_events_1 VARCHAR(87), 
	e_sequence_of_events_2 VARCHAR(49), 
	e_sequence_of_events_3 VARCHAR(68), 
	e_sequence_of_events_4 VARCHAR(49), 
	model_year VARCHAR(22), 
	make VARCHAR(32), 
	body_passenger_cars_only VARCHAR(51), 
	e_owners_state VARCHAR(24), 
	license_tag_state VARCHAR(22), 
	vehicle_usage VARCHAR(53), 
	e_emergency_status VARCHAR(36), 
	e_placard_required VARCHAR(26), 
	e_placard_status VARCHAR(37), 
	hazardous_cargo VARCHAR(26), 
	e_hazardous_released VARCHAR(87), 
	attachment VARCHAR(26), 
	oversized_load_requiring_permit VARCHAR(42), 
	had_oversized_load_permit VARCHAR(111), 
	contributing_vehicle_defect VARCHAR(50), 
	speed_limit VARCHAR(60), 
	estimated_speed_at_impact VARCHAR(14), 
	citation_issued VARCHAR(59), 
	vehicle_damage VARCHAR(18), 
	vehicle_towed VARCHAR(34), 
	areas_damaged_1 VARCHAR(38), 
	e_areas_damaged_2 VARCHAR(30), 
	e_areas_damaged_3 VARCHAR(29), 
	point_of_initial_impact VARCHAR(26), 
	driver_seating_position VARCHAR(32), 
	driver_victim_occ_type VARCHAR(21), 
	driver_safety_equipment VARCHAR(48), 
	driver_airbag_status VARCHAR(47), 
	driver_age VARCHAR(33), 
	driver_ejection_status VARCHAR(22), 
	driver_injury_type VARCHAR(50), 
	driver_first_aid_by VARCHAR(77), 
	driver_transport_immediate VARCHAR(43), 
	e_driver_transport_type VARCHAR(74), 
	e_involved_road_bridge VARCHAR(44), 
	e_road_surface_type VARCHAR(24), 
	roadway_condition VARCHAR(22), 
	e_environmental_contributing_circumstances VARCHAR(24), 
	contributing_material_in_roadway VARCHAR(14), 
	contributing_material_source VARCHAR(87), 
	roadway_curvature_and_grade VARCHAR(28), 
	vision_obscured_by VARCHAR(32), 
	traffic_control VARCHAR(43), 
	traffic_control_functioning VARCHAR(35), 
	opposing_lane_separation VARCHAR(19), 
	trafficway_lanes VARCHAR(28), 
	e_turn_lanes VARCHAR(30), 
	one_way_street VARCHAR(10), 
	workzone_related VARCHAR(51), 
	e_workzone_type VARCHAR(31), 
	e_workers_present VARCHAR(50), 
	e_law_enforcement_present_in_workzone VARCHAR(39), 
	cmv_indicator VARCHAR(24), 
	e_cmv_weight VARCHAR(34), 
	cmv_hazard_materials_involvement VARCHAR(42), 
	e_cmv_hazard_materials_released VARCHAR(76), 
	e_cmv_bus_usage VARCHAR(24), 
	e_cmv_vehicle_configuration VARCHAR(54), 
	e_cmv_cargo_type VARCHAR(78), 
	e_cmv_cargo_body_type VARCHAR(48), 
	e_cmv_sequence_of_events_1 VARCHAR(76), 
	e_cmv_sequence_of_events_2 VARCHAR(41), 
	e_cmv_sequence_of_events_3 VARCHAR(41), 
	e_cmv_sequence_of_events_4 VARCHAR(41), 
	e_cmv_motor_carrier_type VARCHAR(27), 
	datetime VARCHAR(74), 
	care_dv_case_number_ncv VARCHAR(14), 
	vehicle_model_ncv VARCHAR(46)
);
