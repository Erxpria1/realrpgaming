function getJobTitleFromID(jobID)
	if (tonumber(jobID)==1) then
		return "Teslimat Şoförü"
	elseif (tonumber(jobID)==2) then
		return "Taksi Şoförü"
	elseif  (tonumber(jobID)==3) then
		return "Otobüs Şoförü"
	elseif (tonumber(jobID)==4) then
		return "Şehir Bakım Görevlisi"
	elseif (tonumber(jobID)==5) then
		return "Tamirci"
	elseif (tonumber(jobID)==6) then
		return "Çilingir"
	elseif (tonumber(jobID)==7) then
		return "Uzun Yol Tır Şoförü"
	else
		return "İşsiz"
	end
end