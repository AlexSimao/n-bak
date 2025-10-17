#!/bin/bash

# Crie o atalho do combine-sink.desktop
# Adicione o atalho do arquivo combine-sink.desktop em ~/.config/autostart/
pactl load-module module-combine-sink sink_name=combined
