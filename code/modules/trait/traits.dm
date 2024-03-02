/datum/trait
	var/name = "Default Trait"
	var/description = "A default trait. If you see this someone fucked up."

/datum/trait/death_tolerant
	name = "death tolerant"
	description = "Dead bodies don't bother me like they do other people."

/datum/trait/child
	name = "child"
	description = "I strip corpses faster than the adults, and landmines don't bother me!"

/datum/trait/timestop_immune
	name = "Immune to Timestop"
	description = "I am immune to stopped time, through temporal mischief."

/datum/trait/timeslow_immune
	name = "Immune to Timeslowdown"
	description = "I am immune to slowed down time, through improved reaction speeds, or temporal mischief."

/datum/trait/timestopped
	name = "Timestopped"
	description = "I have been stopped in time, via temporal mischief."

/datum/trait/timeslowed
	name = "Timeslowed"
	description = "I have been slowed in time, through reaction speeds, or temporal mischief."


/mob/living/proc/has_trait(var/datum/trait/this_trait)
	return istype(trait, this_trait)

/mob/living/proc/set_trait(var/datum/trait/set_trait)
	trait = set_trait

/mob/living/proc/remove_trait()
	trait = null
