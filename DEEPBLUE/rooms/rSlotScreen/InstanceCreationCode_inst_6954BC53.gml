body = oGlobalData.partData[oGlobalData.getPartIndex(oGlobalData.equippedBody)];
main = body.main;
aux = body.aux;
def = body.def;

positions = 
[
	(room_width/4) * 1, 
	(room_width/4) * 2, 
	(room_width/4) * 3, 
]

spacing = 128;
topMargin = 128;

for (var i = 0; i < array_length(main); i++)
{
	if (main[i] != -1) //if valid slot
	{
		struct = //holds data used by the button
		{
			type : "main",
			index : i, 
			text : "main " + string(i + 1), 
		}
		
		if (typeof(main[i]) == "struct") //overwrite the draw text with the name of selected gun if one exists
		{
			struct.text = main[i].name;
		}
		
		instance_create_layer(positions[0], i*spacing + topMargin, "Instances", oSlotButton, struct);
	}
}

for (var i = 0; i < array_length(aux); i++)
{
	if (aux[i] != -1) //if valid slot
	{
		struct = 
		{
			type : "aux",
			index : i, 
			text : "aux " + string(i + 1), 
		}
		
		if (typeof(aux[i]) == "struct")
		{
			struct.text = aux[i].name;
		}
		
		instance_create_layer(positions[1], i*spacing + topMargin, "Instances", oSlotButton, struct);
	}
}

for (var i = 0; i < array_length(def); i++)
{
	if (def[i] != -1) //if valid slot
	{
		struct = 
		{
			type : "def",
			index : i, 
			text : "def " + string(i + 1), 
		}
		
		if (typeof(def[i]) == "struct")
		{
			struct.text = def[i].name;
		}
		
		instance_create_layer(positions[2], i*spacing + topMargin, "Instances", oSlotButton, struct);
	}
}