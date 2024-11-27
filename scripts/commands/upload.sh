#!/bin/bash
# The content to upload (unknown type at this point)
CONTENT=$1

# Check if the content is empty
if [ -z $CONTENT ]; then
    # Content is empty
    zenity --error --text="No content specified. Please specify a file or text to upload."
    exit 1
fi

# Check if the content is a file
if [ -f $CONTENT ]; then
    # Contents is a file
    echo "Uploading file..."

    # Get info
    FILENAME=$(basename $CONTENT) # Get the filename

    UploadInfo="$( zenity --forms --title="Upload file" --text="Please fill in the following info"    --add-entry="Upload Path (/)"    --add-entry="File name ($FILENAME)" )"

    # Get the upload path and filename
    UploadRoot=~/Documents/Code/HTML/Media/public
    UploadPath=$(echo $UploadInfo | cut -d "|" -f 1)
    UploadFilename=$(echo $UploadInfo | cut -d "|" -f 2)

    if [ -z $UploadPath ]; then
        # No path specified
        UploadPath=$UploadRoot/
    else
        # Path specified
        if [[ $UploadPath == /* ]]; then
            # Path is relative
            UploadPath=$UploadRoot$UploadPath/
        else
            if [[ $UploadPath == "/" ]]; then
                # Path is relative
                UploadPath=$UploadRoot/
            else
                # Path is invalid
                zenity --error --text="Invalid path specified. Please specify a valid path. (e.g. /upload/)"
            fi
        fi
    fi

    if [ -z $UploadFilename ]; then
        # No filename specified
        UploadFilename=$FILENAME
    fi

    echo "Uploading $CONTENT to $UploadPath$UploadFilename..."

    # Check if the target directory exists
    if [ ! -d $UploadPath ]; then
        # Directory does not exist
        mkdir -p $UploadPath

        if [ $? -ne 0 ]; then
            # Directory creation failed
            zenity --error --text="Failed to create directory. Please check the path and try again."
            exit 1
        fi
    fi

    # Copy the file to the target directory
    cp $CONTENT $UploadPath$UploadFilename
    
    if [ $? -ne 0 ]; then
        # File copy failed
        zenity --error --text="Failed to upload file. Please check the file and try again."
        exit 1
    fi

    echo "Copied $CONTENT to $UploadPath$UploadFilename"

    # Deploy the project
    echo "Deploying files..."
    cd $UploadRoot && cd ..

    firebase deploy

    if [ $? -ne 0 ]; then
        # Deployment failed
        zenity --error --text="Failed to deploy files. Please check the files and try again."
        exit 1
    else 
        # Deployment successful
        zenity --info --text="File uploaded successfully!"
    fi
else
    # Contents is not a file
    echo "Uploading content as text..."

    echo "$CONTENT" | netcat termbin.com 9999
fi