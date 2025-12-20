local ret = ... or {};

ret.RedirTable =
{
	Up = "Up",
	Down = "Down",
	Left = "Left",
	Right = "Right",
	UpLeft = "Up",
	UpRight = "Up",
};

local OldRedir = ret.Redir;

ret.Redir = function(sButton, sElement)
	sButton, sElement = OldRedir(sButton, sElement);

	--Point the head files back to the tap note
	if string.find(sElement, "Head") or sElement == "Tap Fake" then
		sElement = "Tap Note";
	end
	
	--Redirect non-directional elements to down
	if string.find(sElement, "Hold") or string.find(sElement, "Roll") or string.find(sElement, "Tap Explosion") or sElement == "Tap Mine" then
		sButton = "Down";
	end

	sButton = ret.RedirTable[sButton];

	return sButton, sElement;
end

local OldFunc = ret.Load;
function ret.Load()
	local t = OldFunc();

	-- The main "Explosion" part just loads other actors; don't rotate
	-- it.  The "Hold Explosion" part should not be rotated.
	if Var "Element" == "Explosion" or
	   Var "Element" == "Roll Explosion" then
		t.BaseRotationZ = nil;
	end
	return t;
end

ret.PartsToRotate =
{
	["Receptor"] = false,
	["Tap Note"] = true,
	["Tap Lift"] = true,
	["Tap Fake"] = true,
	["Ready Receptor"] = false,
	["Tap Explosion Bright"] = true,
	["Tap Explosion Dim"] = true,
	["Hold Head Active"] = true,
	["Hold Head Inactive"] = true,
	["Roll Head Active"] = true,
	["Roll Head Inactive"] = true
};
ret.Rotate =
{
	Up = 180,
	Down = 0,
	Left = 90,
	Right = -90,
	UpLeft = -45,
	UpRight = 45,
};

ret.Blank =
{
	["Hold Explosion"] = true,
	["Roll Explosion"] = true,
	["Hold Topcap Active"] = true,
	["Hold Topcap Inactive"] = true,
	["Roll Topcap Active"] = true,
	["Roll Topcap Inactive"] = true,
	["Hold Tail Active"] = true,
	["Hold Tail Inactive"] = true,
	["Roll Tail Active"] = true,
	["Roll Tail Inactive"] = true,
};

return ret;
