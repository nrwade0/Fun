library(RSQLite)
library(tidyverse)

install.packages("dbplyr")
library(dplyr)

conn <- DBI::dbConnect(RSQLite::SQLite(), path = "chat.db")

# Write the mtcars dataset into a table names mtcars_data
dbWriteTable(conn, "dat", mtcars)

# List all the tables available in the database
dbListTables(conn)


dbGetQuery(conn, "SELECT * FROM dat")
