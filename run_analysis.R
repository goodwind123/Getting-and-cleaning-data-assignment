#reading data
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subj_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subj_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")

#column names
activitynames<-read.table("./UCI HAR Dataset/activity_labels.txt")
features<-read.table("./UCI HAR Dataset/features.txt")

#merge x and y
x<-rbind(x_test,x_train)
y<-rbind(y_test,y_train)
subj<-rbind(subj_test,subj_train)

#subset mean and std from x
features<-features[grep("mean\\(\\)|std\\(\\)",features[,2]),]
x<-x[,features[,1]]
colnames(x)<-features[,2]
colnames(subj)<-"subject"

#labels for y
colnames(y)<-"activity"
y$activitylabel<-factor(y$activity,labels=as.character(activitynames[,2]))

#merge everything
all<-cbind(subj,y,x)
all<-all[,-2]
all_summary<-all%>%
  group_by(activitylabel,subject) %>%
  summarize_each(funs(mean))
#export table
write.table(all_summary,file="./UCI HAR Dataset/tidydata.txt",col.names=TRUE,row.names=FALSE)


  
