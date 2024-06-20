#!/bin/bash

LOG_FILE="/root/InstaGen/debug.log"
echo "Starting condor_run.sh script" > $LOG_FILE

# Activate the InstaGen environment
source /opt/conda/bin/activate instagen
if [ $? -ne 0 ]; then
    echo "Failed to activate conda environment" >> $LOG_FILE
    exit 1
fi

# Print conda environment
conda env list >> $LOG_FILE
which python >> $LOG_FILE

# List files in the instagen_scripts directory to verify its existence
echo "Listing files in instagen_scripts directory" >> $LOG_FILE
ls -la /root/InstaGen/instagen_scripts >> $LOG_FILE

# Fine-tune SDM
if [ -f /root/InstaGen/instagen_scripts/finetune_sdm.sh ]; then
    sh /root/InstaGen/instagen_scripts/finetune_sdm.sh
else
    echo "File not found: finetune_sdm.sh" >> $LOG_FILE
fi

# Generate images
if [ -f /root/InstaGen/instagen_scripts/generate_image.sh ]; then
    sh /root/InstaGen/instagen_scripts/generate_image.sh
else
    echo "File not found: generate_image.sh" >> $LOG_FILE
fi

# Generate annotation files
if [ -f /root/InstaGen/instagen_scripts/generate_base_ann.sh ]; then
    sh /root/InstaGen/instagen_scripts/generate_base_ann.sh
else
    echo "File not found: generate_base_ann.sh" >> $LOG_FILE
fi

# Generate class embeddings
if [ -f /root/InstaGen/instagen_scripts/generate_class_embedding.sh ]; then
    sh /root/InstaGen/instagen_scripts/generate_class_embedding.sh
else
    echo "File not found: generate_class_embedding.sh" >> $LOG_FILE
fi

# Train InstaGen
if [ -f /root/InstaGen/instagen_scripts/train_instagen.sh ]; then
    sh /root/InstaGen/instagen_scripts/train_instagen.sh
else
    echo "File not found: train_instagen.sh" >> $LOG_FILE
fi

echo "Finished condor_run.sh script" >> $LOG_FILE