if live.getEntryFile then
	return live.getEntryFile('MetYouNode')
else
	return {
    	entry = "MetYouNode"
	}
end