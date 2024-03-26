FROM node

ENV PORT=8431
ENV DATA_DIR=/automerge-sync-server-data-dir/

RUN npm install --global @automerge/automerge-repo-sync-server@0.2.7

ENTRYPOINT [ "/usr/local/bin/npx", "@automerge/automerge-repo-sync-server" ]