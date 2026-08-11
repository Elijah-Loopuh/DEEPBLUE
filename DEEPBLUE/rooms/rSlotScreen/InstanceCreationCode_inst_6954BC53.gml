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
	if(main[i] != -1) //if valid slot
	{
		struct = 
		{
			type : "main",
			index : i, 
			text : "main " + string(i + 1), 
		}
		instance_create_layer(positions[0], i*spacing + topMargin, "Instances", oSlotButton, struct);
	}
}

for (var i = 0; i < array_length(aux); i++)
{
	if(aux[i] != -1) //if valid slot
	{
		struct = 
		{
			type : "aux",
			index : i, 
			text : "aux " + string(i + 1), 
		}
		instance_create_layer(positions[1], i*spacing + topMargin, "Instances", oSlotButton, struct);
	}
}

for (var i = 0; i < array_length(def); i++)
{
	if(def[i] != -1) //if valid slot
	{
		struct = 
		{
			type : "def",
			index : i, 
			text : "def " + string(i + 1), 
		}
		instance_create_layer(positions[2], i*spacing + topMargin, "Instances", oSlotButton, struct);
	}
}