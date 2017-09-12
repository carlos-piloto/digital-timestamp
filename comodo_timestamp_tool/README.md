# Tool requirements:

You need to download the following tools:
 - openssl from https://wiki.openssl.org/index.php/Binaries
 - curl from https://curl.haxx.se/download.html
 

# Main steps for timestamp:

Below are listed and explained the several steps involved in the timestamp process. you can check in the script [a relative link](comodo_timestamp_file.bat) all these steps with the required command line.
 - Generate with openssl the request content that needs to be sent to the timestamp server.
 - Send the previous request to the server with a tool like curl or similar and save the response.
 - This step is optional and the goal is to show its content in human readable format.
 - The last and not less important is to verify that that response is valid. This validation is made with the public certificates of COMODO.