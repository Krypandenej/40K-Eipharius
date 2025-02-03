/obj/item/organ/internal/kidneys
	name = "kidneys"
	icon_state = "kidneys"
	gender = PLURAL
	organ_tag = BP_KIDNEYS
	parent_organ = BP_GROIN
	min_bruised_damage = 25
	min_broken_damage = 45
	max_damage = 80
	sales_price = 15

/obj/item/organ/internal/kidneys/robotize()
	. = ..()
	icon_state = "kidneys-prosthetic"
	sales_price = 0

/obj/item/organ/internal/kidneys/Process()
	..()

	if(!owner)
		return

	// Coffee is really bad for you with busted kidneys.
	// This should probably be expanded in some way, but fucked if I know
	// what else kidneys can process in our reagent list.
	var/datum/reagent/coffee = locate(/datum/reagent/drink/coffee) in owner.reagents.reagent_list
	if(coffee)
		if(is_bruised())
			owner.adjustToxLoss(0.1)
		else if(is_broken())
			owner.adjustToxLoss(0.3)

	//If your kidneys aren't working, your body's going to have a hard time cleaning your blood.
	if(!owner.reagents.has_reagent(/datum/reagent/dylovene))
		if(prob(33))
			if(is_broken())
				owner.adjustToxLoss(0.5)
			if(status & ORGAN_DEAD)
				owner.adjustToxLoss(1)


/obj/item/organ/internal/kidneys/astartes
	name = "Haemastamen"
	icon_state = "kidneys"
	gender = PLURAL
	organ_tag = BP_KIDNEYS
	parent_organ = BP_GROIN
	min_bruised_damage = 50
	min_broken_damage = 90
	max_damage = 160
	sales_price = 300

/obj/item/organ/internal/kidneys/astartes/Process()
	..()

	if(!owner)
		return

	// Coffee is really bad for you with busted kidneys.
	// This should probably be expanded in some way, but fucked if I know
	// what else kidneys can process in our reagent list.
/*	var/datum/reagent/coffee = locate(/datum/reagent/drink/coffee) in owner.reagents.reagent_list
	if(coffee)
		if(is_bruised())
			owner.adjustToxLoss(0.1)
		else if(is_broken())
			owner.adjustToxLoss(0.3) //Keeping this as example code for how to do damage/healing effects.

	//If your kidneys aren't working, your body's going to have a hard time cleaning your blood.
	if(!owner.reagents.has_reagent(/datum/reagent/dylovene))
		if(prob(33))
			if(is_broken())
				owner.adjustToxLoss(0.5)
			if(status & ORGAN_DEAD)
				owner.adjustToxLoss(1)*/

	var/oxy = owner.get_blood_oxygenation()
	if(oxy < BLOOD_VOLUME_OKAY) //brain wants us to get MOAR OXY
		owner.add_chemical_effect(CE_BLOODRESTORE) ///Gives a pretty rapid blood regen; Astartes blood clots very quickly, and they produce a lot of it.
		owner.add_chemical_effect(CE_BLOODCLOT)
		owner.add_chemical_effect(CE_MAJORBLOODCLOT)
		owner.add_chemical_effect(CE_ANTIBIOTIC)
		owner.add_chemical_effect(CE_ANTIVIRAL)
