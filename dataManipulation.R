slotMaster <- read.csv("SlotMaster.csv")
moveMaster <- read.csv("MoveMaster.csv")

#* internal dataframe for manipulation purposes
internalProcess <- moveMaster

#* appending required column with calculated data
From_Phy_Seq <- moveMaster$from_location_id
internalProcess <- cbind(internalProcess,From_Phy_Seq)
internalProcess$From_Phy_Seq<-slotMaster[match(moveMaster$from_location_id, slotMaster$slot_id),grep("physical_seq_nbr", colnames(slotMaster))]



To_Phy_Seq_Nbr <- moveMaster$from_location_id
internalProcess <- cbind(internalProcess,To_Phy_Seq_Nbr)
internalProcess$To_Phy_Seq_Nbr<-slotMaster[match(moveMaster$to_location_id, slotMaster$slot_id),grep("physical_seq_nbr", colnames(slotMaster))]

WHSE_Area <- moveMaster$from_location_id
internalProcess <- cbind(internalProcess,WHSE_Area)
internalProcess$WHSE_Area<-slotMaster[match(moveMaster$to_location_id, slotMaster$slot_id),grep("whse_area_code", colnames(slotMaster))]


Phy_Seq_Diff <- moveMaster$from_location_id
internalProcess <- cbind(internalProcess,Phy_Seq_Diff)
internalProcess$Phy_Seq_Diff<-abs(internalProcess$From_Phy_Seq - internalProcess$To_Phy_Seq_Nbr)

#* exporting the finalData for usage
print(head(internalProcess, 25))
write.csv(internalProcess,'finalOutput.csv')
