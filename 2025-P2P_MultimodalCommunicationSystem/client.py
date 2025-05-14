"""

Client that connect to a server.

    Server credentials are specified in the initial parameters.
    Condition are specified as constants at the beginning of the file.

    @author FrancescoPenasa

"""

# imports
import socket                               # For socket usage
import time									# For sleep usage

# constants
SLEEP_INTERVAL = 1                          # Seconds beetwen receive and send
CHUNK_SIZE = 1024                           # Bytes of chunk for transmission
FORMAT = "utf-8"                            # Encoding format

# connection parameters
host = socket.gethostname()              	# To specify server name
port = 3000                            	 	# To specify the connection port
conn = socket.socket()                   	# Create a socket object

# connection initialization
conn.connect((host, port))					# Connect socket to server and port
conn.sendall(b" Client connected.") 		    # Send a handshake message

# client actions
while True:
    # --- send request --- #
    time.sleep(SLEEP_INTERVAL)              # Intervals for the communication
    msg = "Client sending here."            # Message to send
    conn.sendall(msg.encode(FORMAT))        # Sending message encode in utf-8
    # -------------------- #

    # --- receive response --- #
    data = conn.recv(CHUNK_SIZE)            # Receive data
    response = data.decode(FORMAT)          # Decode incoming data
    print("Server response: " + response)
    # ------------------------ #

# connection ending
conn.close()                          		# Close the socket when done