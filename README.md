# IT420 Customer Data

To fix duplicates, I had to use the sort object. However this didnt work correctly the first time. Instead it had imported them as strings and sorted them that way. To fix this I forced the Flat File Source to treat them as integers. The next issue I encountered was the missing email values not being replaced properly. My first thought was that they were just empty string. I added a second derived column to replace empty strings, but that did not work. In the end, I had to go into the flat file source and set it to import nulls.

