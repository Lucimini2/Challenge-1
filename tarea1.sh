#!/bin/bash
stress-ng --cpu 4 --cpu-method fft --cpu-load 90 --vm 1 --vm-bytes 1000M --timeout 60s