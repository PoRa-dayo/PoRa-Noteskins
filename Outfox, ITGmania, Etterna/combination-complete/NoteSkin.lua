--I am the bone of my noteskin
--Arrows are my body, and explosions are my blood
--I have created over a thousand noteskins
--Unknown to death
--Nor known to life
--Have withstood pain to create many noteskins
--Yet these hands will never hold anything
--So as I pray, Unlimited Stepman Works


local ret = ... or {};

--Defining on which direction the other directions should be bassed on
--This will let us use less files which is quite handy to keep the noteskin directory nice
--Do remember this will Redirect all the files of that Direction to the Direction its pointed to
ret.RedirTable =
{
	Up = "Down",
	Down = "Down",
	Left = "Down",
	Right = "Down",
	UpLeft = "Down",
	UpRight = "Down",
};

-- < 
--Between here we usally put all the commands the noteskin.lua needs to do, some are extern in other files
--If you need help with lua go to  http://kki.ajworld.net/lua/ssc/Lua.xml there are a bunch of codes there
--Also check out commen it has a load of lua codes in files there
--Just play a bit with lua its not that hard if you understand coding
--But SM can be an ass in some cases, and some codes jut wont work if you dont have the noteskin on FallbackNoteSkin=common in the metric.ini 
local OldRedir = ret.Redir;
ret.Redir = function(sButton, sElement)
	sButton, sElement = OldRedir(sButton, sElement);

	-- Instead of separate hold heads, use the tap note graphics.
	if sElement == "Hold Head Inactive" or
	   sElement == "Hold Head Active" or
	   sElement == "Roll Head Inactive" or
	   sElement == "Roll Head Active" or
	   sElement == "Tap Fake"
	then
		sElement = "Tap Note";
	end

	if not string.find(sElement, "Hold Body") and not string.find(sElement, "Hold Bottomcap") then
        sButton = ret.RedirTable[sButton];
	end

	return sButton, sElement;
end

local OldFunc = ret.Load;
function ret.Load()
	local t = OldFunc();

	--Explosion should not be rotated; it calls other actors.
	if Var "Element" == "Explosion"	then
		t.BaseRotationZ = nil;
	end

    --Rotate only the 8th tap notes
    if Var "Color" == "8th" then
        if Var "Element" == "Tap Note" or Var "Element" == "Tap Fake" or string.find(Var "Element", "Hold Head") or string.find(Var "Element", "Roll Head") then
            t.BaseRotationZ = ret.Rotate[Var "Button"];
        end
    end
	return t;
end
-- >


-- Parts of noteskins which we want to rotate
ret.PartsToRotate =
{
	["Receptor"] = true,
	["Tap Explosion Bright W1"] = true,
	["Tap Explosion Dim W1"] = true,
	["Tap Explosion Bright W2"] = true,
	["Tap Explosion Dim W2"] = true,
	["Tap Explosion Bright W3"] = true,
	["Tap Explosion Dim W3"] = true,
	["Tap Explosion Bright W4"] = true,
	["Tap Explosion Dim W4"] = true,
	["Tap Explosion Bright W5"] = true,
	["Tap Explosion Dim W5"] = true,
	["Tap Note"] = false,
	["Tap Fake"] = false,
	["Tap Lift"] = false,
	["Tap Addition"] = true,
	["Hold Explosion"] = true,
	["Hold Head Active"] = false,
	["Hold Head Inactive"] = false,
	["Roll Explosion"] = true,
	["Roll Head Active"] = false,
	["Roll Head Inactive"] = false,
};
-- Defined the parts to be rotated at which degree
ret.Rotate =
{
	Up = 180,
	Down = 0,
	Left = 90,
	Right = -90,
	UpLeft = 135,
	UpRight = 225,
};

-- Parts that should be Redirected to _Blank.png
-- you can add/remove stuff if you want
ret.Blank =
{
	["Hold Topcap Active"] = true,
	["Hold Topcap Inactive"] = true,
	["Roll Topcap Active"] = true,
	["Roll Topcap Inactive"] = true,
	["Hold Tail Active"] = true,
	["Hold Tail Inactive"] = true,
	["Roll Tail Active"] = true,
	["Roll Tail Inactive"] = true,
	["Tap Explosion Bright"] = true,
	["Tap Explosion Dim"] = true,
};

-- dont forget to close the ret cuz else it wont work ;>
return ret;
