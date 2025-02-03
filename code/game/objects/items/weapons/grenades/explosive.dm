/obj/item/projectile/bullet/pellet/fragment
	damage = 25
	armor_penetration = 24
	range_step = 3 //controls damage falloff with distance. projectiles lose a "pellet" each time they travel this distance. Can be a non-integer.

	base_spread = 0 //causes it to be treated as a shrapnel explosion instead of cone
	spread_step = 20

	silenced = 1
	fire_sound = null
	no_attack_log = 1
	muzzle_type = null
	do_not_pass_trench = TRUE

/obj/item/projectile/bullet/pellet/fragment/strong
	damage = 40
	range_step = 1 //controls damage falloff with distance. projectiles lose a "pellet" each time they travel this distance. Can be a non-integer.
	range = 5
	armor_penetration = 26

/obj/item/projectile/bullet/pellet/fragment/weak
	damage = 20
	range_step = 3
	armor_penetration = 20

/obj/item/grenade/frag
	name = "fragmentation grenade"
	desc = "A military fragmentation grenade, designed to explode in a deadly shower of fragments, while avoiding massive structural damage."
	icon_state = "frggrenade"
	arm_sound = 'sound/weapons/grenade_arm.ogg'
	throw_range = 10
	icon = 'icons/obj/grenade.dmi'

	var/list/fragment_types = list(/obj/item/projectile/bullet/pellet/fragment = 1)
	var/num_fragments = 12  //total number of fragments produced by the grenade (nerfed by x4. 72 / 4 = 18 let's see if this is too little -plinypotter)
	var/explosion_size = 1   //size of the center explosion

	//The radius of the circle used to launch projectiles. Lower values mean less projectiles are used but if set too low gaps may appear in the spread pattern
	var/spread_range = 7 //leave as is, for some reason setting this higher makes the spread pattern have gaps close to the epicenter

/obj/item/grenade/frag/attack_self(mob/user as mob)
	if(aspect_chosen(/datum/aspect/no_guns))//No grenades in slappers only please.
		to_chat(user, "The pin seems stuck, it won't go off.")
		return
	..()

/obj/item/grenade/frag/detonate()
	..()

	var/turf/O = get_turf(src)
	if(!O) return

	if(explosion_size)
		on_explosion(O)

	src.fragmentate(O, num_fragments, spread_range, fragment_types)

	qdel(src)


/atom/proc/fragmentate(var/turf/T=get_turf(src), var/fragment_number = 1, var/spreading_range = 5, var/list/fragtypes=list(/obj/item/projectile/bullet/pellet/fragment/))
	set waitfor = 0
	var/list/target_turfs = getcircle(T, spreading_range)
	var/fragments_per_projectile = round(fragment_number/target_turfs.len)

	playsound(src, 'sound/weapons/grenade_exp.ogg')
	for(var/turf/O in target_turfs)
		sleep(0)
		var/fragment_type = pickweight(fragtypes)
		var/obj/item/projectile/bullet/pellet/fragment/P = new fragment_type(T)
		P.pellets = fragments_per_projectile
		P.shot_from = src.name

		P.launch_projectile(O)

		//Make sure to hit any mobs in the source turf
		for(var/mob/living/M in T)
			//lying on a frag grenade while the grenade is on the ground causes you to absorb most of the shrapnel.
			//you will most likely be dead, but others nearby will be spared the fragments that hit you instead.
			if(M.lying && isturf(src.loc))
				P.attack_mob(M, 0, 5)
			else if(!M.lying && src.loc != get_turf(src)) //if it's not on the turf, it must be in the mob!
				P.attack_mob(M, 0, 25) //you're holding a grenade, dude!
			else
				P.attack_mob(M, 0, 50) //otherwise, allow a decent amount of fragments to pass

/obj/item/grenade/fire
	name = "incendiary grenade"
	desc = "A military incendiary grenade designed to spread and ignite a vast ammount of highly flammable liquid."
	icon_state = "fire_grenade"
	arm_sound = 'sound/weapons/grenade_arm.ogg'
	throw_range = 8

	var/fire_range = 3 // size of the fire zone

/obj/item/grenade/fire/detonate()
	..()

	var/turf/O = get_turf(src)
	if(!O) return

	new /obj/flamer_fire(loc, 8, 6, "red", fire_range)

	qdel(src)

/obj/mortar/frag
	name = "Mortar"
	desc = "You'll never see this it just explodes."

/obj/mortar/frag/New()
	..()
	sleep(0)
	explosion(get_turf(src), -1, -1, 2, 2, 0)
	fragmentate(get_turf(src), 72)
	qdel(src)

/obj/mortar/gas
	name = "gas mortar"

/obj/mortar/gas/New()
	..()
	create_reagents(10)
	reagents.add_reagent(/datum/reagent/toxin/mustard_gas, 20)
	var/location = get_turf(src)
	var/datum/effect/effect/system/smoke_spread/chem/S = new
	S.attach(location)
	S.set_up(reagents, 10, 0, location)
	spawn(0)
		S.start()
	qdel(src)



/obj/mortar/gas/blight
	name = "blight mortar"

/obj/mortar/gas/blight/New()
	..()
	create_reagents(10)
	reagents.add_reagent(/datum/reagent/toxin/corrupting, 60)
	var/location = get_turf(src)
	var/datum/effect/effect/system/smoke_spread/chem/S = new
	S.attach(location)
	S.set_up(reagents, 10, 0, location)
	spawn(0)
		S.start()
	qdel(src)


/obj/mortar/fire
	name = "fire mortar"

/obj/mortar/fire/New()//Just spawns fire.
	..()
	new /obj/flamer_fire(loc, 12, 10, "red", 8)
	qdel(src)

/obj/mortar/flare
	name = "illumination mortar"
	var/flare_type = /obj/effect/lighting_dummy/flare

obj/mortar/flare/blue
	flare_type = /obj/effect/lighting_dummy/flare/blue

/obj/mortar/flare/New()//Just spawns a flare.
	..()
	new flare_type(loc)
	qdel(src)

/obj/mortar/arty //Template object
	name = "Artillery Shell"
	desc = "You'll never see this it just explodes."

/obj/mortar/arty/New()
	..()
	sleep(0)
	qdel(src)

/obj/mortar/arty/shrapnel
	name = "Shrapnel Artillery Shell"
	desc = "You'll never see this it just explodes."

/obj/mortar/arty/shrapnel/New()
	..()
	sleep(0)
	fragmentate(get_turf(src), 84)
	qdel(src)

/obj/mortar/arty/he
	name = "HE Artillery Shell"
	desc = "You'll never see this it just explodes."

/obj/mortar/arty/he/New()
	..()
	sleep(0)
	explosion(get_turf(src), 1, 2, 3, 4, 5)
	fragmentate(get_turf(src), 14)
	qdel(src)

/obj/mortar/arty/incendiary
	name = "Incendiary Artillery Shell"
	desc = "You'll never see this it just explodes."

/obj/mortar/arty/incendiary/New()
	..()
	sleep(0)
	new /obj/flamer_fire(loc, 18, 14, "red", 12)
	qdel(src)

/obj/mortar/arty/phosgene
	name = "Phosgene Artillery Shell"
	desc = "You'll never see this it just explodes."

/obj/mortar/arty/phosgene/New()
	..()
	sleep(0)
	reagents.add_reagent(/datum/reagent/toxin/phosgene_gas, 200)
	var/location = get_turf(src)
	var/datum/effect/effect/system/smoke_spread/chem/S = new
	S.attach(location)
	S.set_up(reagents, 10, 0, location)
	spawn(0)
		S.start()
	qdel(src)

/obj/mortar/arty/phosphorus
	name = "White Phosphorous Artillery Shell"
	desc = "You'll never see this it just explodes."

/obj/mortar/arty/phosphorus/New()
	..()
	sleep(0)
	reagents.add_reagent(/datum/reagent/toxin/mustard_gas/white_phosphorus, 200)
	var/location = get_turf(src)
	var/datum/effect/effect/system/smoke_spread/chem/S = new
	S.attach(location)
	S.set_up(reagents, 10, 0, location)
	spawn(0)
		S.start()
	qdel(src)

/*/obj/mortar/arty/plasma
	name = "Plasma Artillery Shell"
	desc = "You'll never see this it just explodes."
	fragment_types = list(/obj/item/projectile/energy/pulse/pulserifle)

/obj/mortar/arty/plasma/New()
	..()
	sleep(0)
	fragmentate(get_turf(src), 84)
	qdel(src)*/

/obj/mortar/bombard //BIG GUN, be careful about how you use it. //Base template object.
	name = "Bombard Artillery Shell"
	desc = "You'll never see this it just explodes."

/obj/mortar/bombard/New()
	..()
	sleep(0)
	qdel(src)

/obj/mortar/bombard/shrapnel 
	name = "Bombard Shrapnel Artillery Shell"
	desc = "You'll never see this it just explodes."

/obj/mortar/bombard/shrapnel/New()
	..()
	sleep(0)
	fragmentate(get_turf(src), 240)
	qdel(src)

/obj/mortar/bombard/he
	name = "HE Bombard Artillery Shell"
	desc = "You'll never see this it just explodes."

/obj/mortar/bombard/he/New()
	..()
	sleep(0)
	explosion(get_turf(src), 3, 5, 7, 9, 11)
	fragmentate(get_turf(src), 48)
	qdel(src)

/obj/mortar/deathstrike //More or less a nuke. Don't misuse this.
	name = "Deathstrike Missile"
	desc = "You'll never see this it just explodes."

/obj/mortar/deathstrike/New()
	..()
	playsound(get_turf(src), 'sound/effects/siren.ogg', 100, TRUE)
	command_announcement.Announce("Warning. Deathstrike missile launch detected.")
	sleep(120)
	explosion(get_turf(src), 12, 18, 22, 24, 26)
	fragmentate(get_turf(src), 240)
	qdel(src)

/*/obj/mortar/deathstrike/vortex //More or less a nuke. Don't misuse this. //WIP until I add a way to get larger warp rifts. 
	name = "Deathstrike Vortex Missile"
	desc = "You'll never see this it just explodes."

/obj/mortar/deathstrike/vortex/New()
	..()
	playsound(source, 'sound/effects/siren.ogg', 100, TRUE)
	command_announcement.Announce("Warning. Deathstrike vortex missile launch detected.")
	sleep(120)
	new /turf/unsimulated/wall/supermatter/warp
	qdel(src)*/


/obj/item/grenade/frag/proc/on_explosion(var/turf/O)
	if(explosion_size)
		explosion(round(explosion_size / 8), round(explosion_size / 4), round(explosion_size / 2), explosion_size, round(explosion_size * 2), 0)

/obj/item/grenade/frag/warfare
	desc = "Throw it at THE ENEMEY!"
	icon_state = "warfare_grenade"


/obj/item/grenade/frag/ex_act(severity)
	. = ..()
	if(severity)
		detonate()


/obj/item/grenade/frag/shell
	name = "fragmentation grenade"
	desc = "A light fragmentation grenade, designed to be fired from a launcher. It can still be activated and thrown by hand if necessary."
	icon_state = "fragshell"

	explosion_size = 3
	num_fragments = 8

/obj/item/grenade/frag/high_yield
	name = "fragmentation bomb"
	desc = "Larger and heavier than a standard fragmentation grenade, this device is extremely dangerous. It cannot be thrown as far because of its weight."
	icon_state = "frag"

	w_class = ITEM_SIZE_SMALL
	throw_speed = 2
	throw_range = 8 //heavy, can't be thrown as far

	fragment_types = list(/obj/item/projectile/bullet/pellet/fragment=1)
	explosion_size = 3
	num_fragments = 8

/obj/item/grenade/frag/high_yield/krak
	name = "Krak Grenade"
	desc = "A potent anti armor grenade used by the Imperium of Man, mind the blast radius."
	icon_state = "krak_grenade"
	fragment_types = list(/obj/item/projectile/bullet/pellet/fragment/strong=1)
	explosion_size = 8
	throw_range = 7
	num_fragments = 4
	w_class = ITEM_SIZE_SMALL

/obj/item/grenade/frag/high_yield/krak2
	name = "Mechanicus Krak Grenade"
	desc = "An incredibly dangerous and unstable plasma-enchanced Krak Grenade. Stand well clear!"
	icon_state = "krak_grenade"
	fragment_types = list(/obj/item/projectile/bullet/pellet/fragment/strong=1)
	explosion_size = 12
	num_fragments = 7
	throw_range = 6
	w_class = ITEM_SIZE_SMALL

/obj/item/grenade/frag/high_yield/krak/detpack
	name = "Det Pack"
	desc = "A standard issue imperial detpack, while simple these explosives when combined with grenades or further detpacks are capable of destroying even baneblades. Stand well clear!"
	fragment_types = list(/obj/item/projectile/bullet/pellet/fragment/strong=1)
	explosion_size = 16
	num_fragments = 9
	throw_range = 4
	w_class = ITEM_SIZE_SMALL
	icon = 'icons/obj/assemblies.dmi'
	icon_state = "plastic-explosive0"
	item_state = "plasticx"

/obj/item/grenade/frag/high_yield/homemade
	name = "Pipe Grenade"
	desc = "A low yield explosive used by miners to clear out caves and demolish stone."
	icon_state = "fire_grenade"
	fragment_types = list(/obj/item/projectile/bullet/pellet/fragment/weak=1)
	explosion_size = 2
	num_fragments = 3
	throw_speed = 1.5
	throw_range = 8
	w_class = ITEM_SIZE_SMALL

/obj/item/grenade/frag/high_yield/krak/prime()
	update_mob()
	explosion(src.loc,1.5,1.5,1.5,flame_range = 1.5)
	qdel(src)

/obj/item/grenade/proc/prime()

/obj/item/grenade/proc/update_mob()
	if(ismob(loc))
		var/mob/M = loc
		M.unEquip(src)

/obj/item/grenade/frag/plasma
	name = "Plasma Grenade"
	desc = "A highly lethal plasma grenade, which fires a burst of high-energy plasma when detonating."
	icon_state = "smoke1"
	fragment_types = list(/obj/item/projectile/energy/pulse/pulserifle=3)
	explosion_size = 5
	num_fragments = 9
	throw_speed = 2
	throw_range = 8
	w_class = ITEM_SIZE_SMALL

