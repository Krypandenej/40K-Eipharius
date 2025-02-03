/datum/species/necron
	name = SPECIES_NECRON
	name_plural = "Necrons"
	secondary_langs = list(LANGUAGE_NECRON)
	name_language = null // Use the first-name last-name generator rather than a language scrambler
	icobase = 'icons/mob/human_races/r_necron.dmi'
	min_age = 60000000
	max_age = 120000000
	gluttonous = GLUT_ITEM_NORMAL
	total_health = 250
	mob_size = MOB_MEDIUM
	strength = STR_VHIGH
	blood_volume = 0
	radiation_mod = 0
	brute_mod =      0.2
	burn_mod =       0.2   
	flash_mod =      0.5                    // Stun from blindness modifier.
	metabolism_mod = 0                    // Reagent metabolism modifier
	passive_temp_gain = -7		                  // Species will gain this much temperature every second //This accounts for internal cooling systems, and the heat generated via various limbs.
	species_flags = SPECIES_FLAG_NO_EMBED|SPECIES_FLAG_NO_PAIN|SPECIES_FLAG_NO_SLIP|SPECIES_FLAG_NO_POISON|SPECIES_FLAG_NO_SCAN|SPECIES_NO_FBP_CONSTRUCTION
	vision_flags = SEE_SELF|SEE_MOBS
	inherent_verbs = list(
	/mob/living/carbon/human/necron/proc/necronsetup,
		)
	unarmed_types = list(
		/datum/unarmed_attack/stomp/necron,
		/datum/unarmed_attack/kick/necron,
		/datum/unarmed_attack/punch/necron
		)

	blood_color = "#4c0377"


	has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/chest/necron),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin/necron),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/necron),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm/necron),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/necron),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg/necron),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/necron),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand/necron),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/necron),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot/necron),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/necron)
		)

	has_organ = list(
		BP_EYES =     /obj/item/organ/internal/eyes/necron,
		BP_CELL =    /obj/item/organ/internal/necron,
		BP_BRAIN =    /obj/item/organ/internal/brain/necron
		)

/datum/species/necron/handle_post_spawn(var/mob/living/carbon/human/H)
	if(H.f_style)
		H.f_style = "Shaved"
	to_chat(H, "<big><span class='warning'>SYSTEMS BOOTING... YOU HAVE AWAKENED. SERVE YOUR LORD. PURGE THE PRIMITIVES INFESTING YOUR PLANET.</span></big>")
	H.update_eyes()
	return ..()

/mob/living/carbon/human/necron
	gender = MALE

/mob/living/carbon/human/necron/New(var/new_loc)
	h_style = "Bald"
	return ..()

/mob/living/carbon/human/necron/Initialize()
	. = ..()
	set_species(SPECIES_NECRON)
	warfare_faction = NECRON
	fully_replace_character_name(random_necron_warrior_name(src.gender))
	src.rejuvenate()

/mob/living/carbon/human/necron/proc/necronsetup()
	set name = "AWAKEN"
	set category = "AWAKEN"
	set desc = "Gives your equipment and stats."

	if(src.stat == DEAD)
		to_chat(src, "<span class='notice'>You can't do this when dead.</span>")
		return

	var/necronclass = input("Select a Class","Class Selection") as null|anything in list("Necron Warrior")
	switch(necronclass)
		if("Necron Warrior")
			warfare_faction = NECRON
			var/decl/hierarchy/outfit/outfit = outfit_by_type(/decl/hierarchy/outfit/job/security/necron)
			outfit.equip(src)
			src.add_stats(rand(25,30),rand(12,15),rand(25,30),rand(10,11)) //gives stats str, dext, end, int
			src.add_skills(rand(14,18),rand(19,21),rand(3,5),rand(12,14),rand(3,5)) //melee, ranged, med, eng, surgery
			src.set_trait(new/datum/trait/death_tolerant())
			src.set_quirk(new/datum/quirk/dead_inside())
			src.update_eyes() //should fix grey vision
			src.warfare_language_shit(LANGUAGE_LOW_GOTHIC) //secondary language
			src.warfare_language_shit(LANGUAGE_MECHANICUS)
			src.bladder = -INFINITY
			src.bowels = -INFINITY 
			src.thirst = INFINITY
			src.nutrition = INFINITY 
			src.verbs -= /mob/living/carbon/human/necron/proc/necronsetup //removes verb at the end so they can't spam it for whatever reason
