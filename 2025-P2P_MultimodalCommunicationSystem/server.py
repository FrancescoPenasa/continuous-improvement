"""

Server that handle a connection with various clients.

    Server credentials are specified in the initial parameters.
    Condition are specified as constants at the beginning of the file.

    @author FrancescoPenasa

"""

# imports
import socket                            # For socket usage
import threading                         # To enable multi-connection
import sys                               # For error handling
import time                              # For sleep usage

# constants
SLEEP_INTERVAL = 1                       # INTERVAL BETWEEN RECEIVE AND SEND
CHUNK_SIZE = 1024                        # BYTES CHUNK OF TRANSMISSION
FORMAT = "utf-8"                         # ENCODING FORMAT

# connection parameters
host = socket.gethostname()              # To specify server name
port = 3000                              # To specify the connection port
sock = socket.socket()                   # Create a socket object

# connection initialization
sock.bind((host, port))                  # Bind the socket to server and port
sock.listen(5)                           # Max number of connections.


def processMessages(conn, addr):
    """
        The behaviour of the server with a connection
        Return void
    """
    while True:
        try:
            # --- receive request --- #
            data = conn.recv(CHUNK_SIZE)                 # Receive data
            if not data:
                conn.close()
            msg = data.decode(FORMAT)                    # Decode incoming data
            print("Received: ", msg)
            # ----------------------- #

            # --- send response --- #
            time.sleep(SLEEP_INTERVAL)                   # Intervals 
            print("sending response")
            conn.sendall(bytes('Server here.', FORMAT))  # Send data
            # --------------------- #

        except:
            conn.close()                                 # Close connection
            print("Connection closed by", addr)
            sys.exit()                                   # Quit the thread.


# server actions
while True:
    # Wait for connections
    print ("Waiting for connection")
    conn, addr = sock.accept()
    print("Connected to ", addr[0], '(', addr[1], ')')

    # Listen for messages on this connection
    listener = threading.Thread(target=processMessages, args=(conn, addr))
    listener.start()