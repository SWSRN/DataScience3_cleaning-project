# run_analysis_wrangler.R  

install.packages("data.table")
library(data.table)

activity_labels <- (read.csv(file="activity_labels.txt", sep=" ", 
	header=FALSE, col.names=c("num", "activity")))[,2]
activity_labels <- tolower(activity_labels)   # lower case is preferred.

features_labels <- (read.csv(file="features.txt", , sep=" ", 
	header=FALSE, colClasses = "character", col.names=c("num", "features")))[,2]
# Clean up labels so allowed as table column variable names. 
# Otherwise get lots of "." by default
features_labels <- gsub("\\(", "", features_labels)	# get rid of (
features_labels <- gsub(")", "", features_labels)	# get rid of )
features_labels <- gsub(",", "_", features_labels)	# convert , to . so allowed as variable names.
features_labels <- gsub("-", "_", features_labels)	# convert - to _ so allowed as variable names.

subject_train <-  read.csv(file="subject_train.txt", header=FALSE, col.names="id_subject")
subject_test  <-  read.csv(file="subject_test.txt", header=FALSE, col.names="id_subject")

activity_train <- read.csv(file="y_train.txt", header=FALSE, col.names="id_activity")
activity_test  <- read.csv(file="y_test.txt", header=FALSE, col.names="id_activity")

features_train <- read.table(file="X_train.txt", col.names=features_labels)
features_test  <- read.table(file="X_test.txt", col.names=features_labels)

# Make 2 boring vectors filled with only "train" or "test" for which stage 
# of the experiment. Will help make data tidy.
len_train <- dim(subject_train)[1]
len_test <- dim(subject_test)[1]

stage_train <- c(rep("train", times=len_train))
stage_test <- c(rep("test", times=len_test))

#Glue together "test" columns using cbind, then also for "train" columns
all_train <- data.table(cbind(stage_train, activity_train, subject_train, features_train))
all_test  <- data.table(cbind(stage_test, activity_test, subject_test, features_test))

# rename columns stage_train and stage_test to what we want for a single joined column. 
setnames(all_train, "stage_train", "stage")
setnames(all_test,  "stage_test", "stage")

# all_train will be the top 7352 rows and all_test will be the bottom 2947 rows.
all <- data.table(rbind(all_train, all_test))

# get rid of NA's (Are there any? NO! So comment out code since it's slow.)
#message(dim(all)[1], " ", dim(all)[2], " ", class(all))
#all <- all[complete.cases(all),]
#message(dim(all)[1], " ", dim(all)[2], " ", class(all))

levels(all$id_activity)[1:6] <- activity_labels		# for data table
## put the activity names in the column id_activity instead of using code 1:6.. For data frame
#message(dim(all)[1], " ", dim(all)[2], " ", class(all))
#for (i in 1:6) {			# for use with data tables. Does not work
#   all[,id_activity]  <- gsub(i, activity_labels[i], all[,id_activity])
#}
## for loop below works for data frames
##for (i in 1:6) {
##   all[,"id_activity"]  <- gsub(i, activity_labels[i], all[,"id_activity"])
##}
#message(dim(all)[1], " ", dim(all)[2], " ", class(all))

# Now we only want columns with "mean" or "std" in the "features" column names using grepl.
col_names <- names(all)
# log_names returns T/F for wanted/unwanted columns
log_names <- ((col_names == "id_activity") | 
			(col_names == "id_subject") |
			grepl("mean", col_names) | grepl("std", col_names)) 
# returns column numbers of unwanted columns.
unwanted_cols <- which(!log_names) 
unwanted_names <- col_names[unwanted_cols] 
#remove unwanted columns
all_skinny <- all[,(unwanted_names) := NULL]  # For data.table.
#all_skinny <- all[,-unwanted_cols]  # works for read.table/ dataframe but not data.table.
message(dim(all_skinny)[1], " ", dim(all_skinny)[2], " ", class(all_skinny))


#len_activity <- length(activity_labels)
#len_subject <- max(all_skinny$id_subject)
#ncols_skinny <-  dim(all_skinny)[2]
#unwanted_names <- col_names[1:2]
#
#feature_log <- (grepl("mean", col_names) | grepl("std", col_names))   # T/F
#feature_names <- col_names[feature_log]

# Calculate means in one fell swoop, with mean calculated for 180 subsets
# determined by id_activity and id_subject.
temp_by <- all_skinny[, lapply(.SD, mean), by=list(id_activity, id_subject)]

# sort so looks nicer. Note: sorting $id_activity by number 1,2,3,4,5,6.
temp_ordered <- temp_by[order(temp_by$id_activity, temp_by$id_subject), ]   

# Ineligant way of converting "123456" to "walking", etc. for variable $id_activity
#  Note:  convert AFTER sort so that we don't sort alphbetically. 
for (i in 1:6) {
   log_i <- (temp_ordered$id_activity == i)
   #message(i, " ", log_i)
   temp_ordered$id_activity[log_i] <- activity_labels[i]
   #message(i, " ", temp_ordered$id_activity)
}

#Write to 
write.table(temp_ordered, "means.txt")


#double_check <- read.table(file = "means.txt")
