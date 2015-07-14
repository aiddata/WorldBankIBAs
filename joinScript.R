#Script to merge the extracted data
#Into the matched World Bank IBA dataset

library(maptools)

data_path <- "/home/aiddata/Desktop/R_Repo/WorldBankIBAs/dataExtracts/"

shapeBoundary <- readShapePoly("/home/aiddata/Desktop/R_Repo/WorldBankIBAs/shapeBoundary/matched_ibas_proj.shp")


pathPop <- "/home/aiddata/Desktop/R_Repo/WorldBankIBAs/dataExtracts/pop.csv"
pathPrecip <- "/home/aiddata/Desktop/R_Repo/WorldBankIBAs/dataExtracts/precip.csv"
pathSRTM <- "/home/aiddata/Desktop/R_Repo/WorldBankIBAs/dataExtracts/srtm_slope_access_merge.csv"
pathTemp <- "/home/aiddata/Desktop/R_Repo/WorldBankIBAs/dataExtracts/temp.csv"

readPop <- read.csv(pathPop)
readPrecip <- read.csv(pathPrecip)
readSRTM <- read.csv(pathSRTM)
readTemp <- read.csv(pathTemp)

#Remove irrelevant columns 
readPop <- cbind(readPop[39:length(readPop)],readPop["SitRecID"])
readPrecip <- cbind(readPrecip[39:length(readPrecip)],readPrecip["SitRecID"])
readSRTM <- cbind(readSRTM[39:length(readSRTM)],readSRTM["SitRecID"])
readTemp <- cbind(readTemp[39:length(readTemp)],readTemp["SitRecID"])

#Rename for Tracking
names(readTemp) <- gsub("X","Temp",names(readTemp))
names(readPrecip) <- gsub("X","Prec",names(readPrecip))

#Rename for cleanup
names(readPop) <- gsub("glds","Pop",names(readPop))
names(readPop) <- gsub("ag","",names(readPop))
names(readSRTM) <- gsub("time","UrbTravTim",names(readSRTM))


shapeBoundary <- merge(shapeBoundary,readPop,by="SitRecID")
shapeBoundary <- merge(shapeBoundary,readPrecip,by="SitRecID")
shapeBoundary <- merge(shapeBoundary,readSRTM,by="SitRecID")
shapeBoundary <- merge(shapeBoundary,readTemp,by="SitRecID")


writePolyShape(shapeBoundary, "/home/aiddata/Desktop/R_Repo/WorldBankIBAs/shapeBoundary/matched_ibas_proj_extractedData.shp")
