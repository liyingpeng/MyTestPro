if live.getEntryFile then
	return live.getEntryFile('LoosePulleyNode')
else
	return {
    	entry = "LoosePulleyNode"
	}
end