-- title:   Writer's Block Simulator
-- author:  Quinten Konyn, qkonyn@gmail.com
-- desc:    You have writer's block! It's a struggle to get started. Will you ever be able to put your thoughts to paper?
-- site:    quintenkonyn.recurse.com/projects/writers-block/
-- license: MIT License
-- version: 0.1
-- script:  lua

t=0

w=240
h=136

x=18
y=20

textbox = ""
len = 0

timer = 0

math.randomseed(tstamp())

function TIC()
 paper()
 if timer == 0 then
		type()
	else
		backspace()
	end
	text()
	cursor()
	t=t+1
end

-- from keyp doc example
function gets()
	A="abcdefghijklmnopqrstuvwxyz0123456789-=[]\\;'`,./ "
	S="ABCDEFGHIJKLMNOPQRSTUVWXYZ)!@#$%^&*(_+{}|:\"~<>? "
	for i=0,3 do
		local c=peek(0xff88+i)
		if c>0 and c<=#A and keyp(c,20,3) then
			return key(64)and S:sub(c,c)or A:sub(c,c)
		end
	end
	return nil
end

alphabet = {'a','b','c','d','e','f','g',
	'h','i','j','k','l','m','n','o','p','q',
	'r','s','t','u','v','w','x','y','z'}
caps = {'A','B','C','D','E','F','G',
	'H','I','J','K','L','M','N','O','P','Q',
	'R','S','T','U','V','W','X','Y','Z'}
space=48
shift=64
BACKSPACE=51
function type()
	if t > 1 then --fixes ctrl+r to run bug
    c=gets()
    if c then textbox=textbox..c end
		if c == ' ' then
			roll =  math.random()
			if roll > 0.5 and #textbox > 8 then
			 timer = 200
			end
		end
    if keyp(BACKSPACE) then
      remove_one()
    end
	end
end

function remove_one()
      textbox = textbox:sub(1, -2) -- remove last letter
end

function backspace()
	--timer = timer - 1
  c=gets()
  if c or timer == 0 then
    remove_one()
    if #textbox > 0 then
      timer = 50
    elseif #textbox == 0 then
      timer = 0
    end
  end
end

function cursor()
	if t % 60 > 30 then
		print("_",x + len + 1 ,y+1)
	end
end

function paper()
--background
	cls(12)
-- red lines
	line(16, 0, 16, h, 2)
--	line(w-16, 0, w-16, h, 2) (needs to be faded)
-- blue lines
	for i = 0,11 do
		line(0, y -3 + i * 10, w, y - 3 + i * 10, 10)
	end
-- holes (only some, this is just the top of the paper)
	circ(8, 27, 4, 0)
	circ(8, h-15, 4, 0)
end

function text()
	len = print(textbox, x, y)
end


-- <TILES>
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <TRACKS>
-- 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </TRACKS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

