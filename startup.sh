#!/bin/bash
# https://ryan.himmelwright.net/post/scripting-tmux-workspaces/

SESSION="GraphQL_Services"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

# Only create tmux session if it doesn't already exist
if [ "$SESSIONEXISTS" = "" ]
then
    # Start New Session
    tmux new-session -d -s $SESSION

    # Start services in panes
    tmux rename-window -t 0 'Accounts'
    tmux send-keys -t 'Accounts' 'cd services/accounts' C-m './startup.sh' C-m

    tmux new-window -t $SESSION:1 -n 'Inventory'
    tmux send-keys -t 'Inventory' 'cd services/inventory' C-m './startup.sh' C-m

    tmux new-window -t $SESSION:2 -n 'Products'
    tmux send-keys -t 'Products' 'cd services/products' C-m './startup.sh' C-m

    tmux new-window -t $SESSION:3 -n 'Reviews'
    tmux send-keys -t 'Reviews' 'cd services/reviews' C-m './startup.sh' C-m

    tmux new-window -t $SESSION:4 -n 'Apollo Gateway'
    tmux send-keys -t 'Apollo Gateway' 'npm run start-gateway' C-m
fi

# Attach Session, on the Main window
tmux attach-session -t $SESSION:0
