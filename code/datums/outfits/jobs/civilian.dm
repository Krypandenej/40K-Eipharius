/decl/hierarchy/outfit/job/assistant
	name = OUTFIT_JOB_NAME("Assistant")
	l_ear = /obj/item/device/radio/headset

/decl/hierarchy/outfit/job/service
	l_ear = /obj/item/device/radio/headset/headset_service
	hierarchy_type = /decl/hierarchy/outfit/job/service

/decl/hierarchy/outfit/job/service/bartender
	name = OUTFIT_JOB_NAME("Bar Servitor")
	uniform = /obj/item/clothing/under/rank/bartender
	id_type = /obj/item/card/id/civilian/bartender
	pda_type = null
	pda_slot = null
	head = /obj/item/clothing/head/servitorhead
	l_ear = /obj/item/device/radio/headset/headset_service
	r_ear = null
	suit = /obj/item/clothing/suit/servitor
	back = /obj/item/storage/backpack/satchel/servitor

/decl/hierarchy/outfit/job/service/chef
	name = OUTFIT_JOB_NAME("Chef")
	uniform = /obj/item/clothing/under/color/brown
	suit = /obj/item/clothing/suit/guardchef
	head = /obj/item/clothing/head/chefhat
	id_type = /obj/item/card/id/civilian/chef
	pda_type = null
	pda_slot = null
	back = /obj/item/storage/backpack/satchel/warfare
	shoes = /obj/item/clothing/shoes/jackboots
	neck = /obj/item/reagent_containers/food/drinks/canteen
	l_ear = null
	r_ear = null
	backpack_contents = list(
	/obj/item/reagent_containers/food/snacks/warfare/rat = 1,
	/obj/item/stack/thrones = 1,
	/obj/item/stack/thrones2 = 1,
	/obj/item/stack/thrones3/five = 1,
		)

/decl/hierarchy/outfit/job/service/gardener
	name = OUTFIT_JOB_NAME("Farmer")
	uniform = null
	suit = null
	gloves = null
	r_pocket = null
	id_type = null
	pda_type = null
	pda_slot = null
	l_ear = /obj/item/device/radio/headset/heads/cmo
	r_ear = null
	back = /obj/item/storage/backpack/satchel/warfare
	shoes = /obj/item/clothing/shoes/jackboots
	neck = /obj/item/reagent_containers/food/drinks/canteen
	l_hand = null
	r_pocket = /obj/item/storage/box/coin
	belt = /obj/item/storage/plants
	backpack_contents = list(/obj/item/reagent_containers/food/snacks/warfare/rat = 1,
	/obj/item/stack/thrones2 = 1,
	/obj/item/stack/thrones3/five = 1,

	)

/decl/hierarchy/outfit/job/service/gardener/New()
	..()
	backpack_overrides[/decl/backpack_outfit/backpack]      = /obj/item/storage/backpack/hydroponics
	backpack_overrides[/decl/backpack_outfit/satchel]       = /obj/item/storage/backpack/satchel/satchel_hyd
	backpack_overrides[/decl/backpack_outfit/messenger_bag] = /obj/item/storage/backpack/messenger/hyd

/decl/hierarchy/outfit/job/service/janitor
	name = OUTFIT_JOB_NAME("Janitor Servitor")
	uniform = /obj/item/clothing/under/rank/janitor
	id_type = /obj/item/card/id/civilian/janitor
	pda_type = null
	pda_slot = null
	head = /obj/item/clothing/head/servitorhead/janitor
	l_ear = /obj/item/device/radio/headset/headset_service
	r_ear = null
	suit = /obj/item/clothing/suit/servitor/janitor
	back = /obj/item/storage/backpack/satchel/servitor

/decl/hierarchy/outfit/job/librarian
	name = OUTFIT_JOB_NAME("Record Keeper")
	uniform = /obj/item/clothing/under/suit_jacket/red
	id_type = /obj/item/card/id/civilian/librarian
	pda_type = null
	pda_slot = null

/decl/hierarchy/outfit/job/service/undertaker
	name = OUTFIT_JOB_NAME("Undertaker")
	uniform = /obj/item/clothing/under/child_jumpsuit/warfare
	id_type = /obj/item/card/id/civilian/bartender
	neck = /obj/item/reagent_containers/food/drinks/canteen
	l_ear = null
	r_ear = null
	suit = /obj/item/clothing/suit/child_coat/red
	back = /obj/item/storage/backpack/satchel/warfare
	l_hand = /obj/item/shovel
	pda_type = null
	pda_slot = null
	backpack_contents = list(
	/obj/item/reagent_containers/food/snacks/warfare/rat = 1,
	/obj/item/stack/thrones = 1,
	/obj/item/stack/thrones2 = 1,)
