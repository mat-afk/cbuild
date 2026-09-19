#!/usr/bin/env bash

SCOPE="info"

bold=$(tput bold)
normal=$(tput sgr0)

find_c_files() {
    find "$PROJECT_ROOT" -type f -name "*.c" | wc -l;
}

find_h_files() {
    find "$PROJECT_ROOT" -type f -name "*.h" | wc -l;
}

size() {
    du -sh "$PROJECT_ROOT" | cut -f1;
}

path() {
    echo "$SRC_DIR"
}

compiler() {
    COMPILER="$(${cc:-cc} --version | head -n 1)"
    echo "$COMPILER"
}

kernel() {
    echo "$(uname -r)"
}

lines() {
    find "$PROJECT_ROOT" -type f \( -name "*.c" -o -name "*.h" \) -exec cat {} + \
        | grep -cv '^[[:space:]]*$'
}

last_entry() {
    local pattern="$1"
    local entry

    entry="$(grep -m 1 -E "$pattern" "$LOG_FILE" 2>/dev/null)"

    if [[ -z "$entry" ]]; then
        echo "never"
    else
        sed -E 's/^\[([^]]*)\].*/\1/' <<< "$entry"
    fi
}

default(){
    local last_run last_build

    last_run="$(last_entry '\[run\] \[INFO\]')"
    last_build="$(last_entry '\[(build|rebuild)\] \[INFO\]')"

    echo "${bold} System: ${normal}"
    echo "     Kernel:          $(kernel)"
    echo "     Compiler:        $(compiler)"

    echo ""

    echo "${bold} Quantities: ${normal}"
    echo "     Project size:    $(size)"
    echo "     C files:         $(find_c_files)"
    echo "     Header files:    $(find_h_files)"
    echo "     Lines:           $(lines)"

    echo "${bold} Runs: ${normal}"
    echo "     Last run:         ${last_run}"
    echo "     Last build:         ${last_build}"

}

visual() {

    local last_run last_build

    last_run="$(last_entry '\[run\] \[INFO\]')"
    last_build="$(last_entry '\[(build|rebuild)\] \[INFO\]')"

    cat > "$DOCS_DIR/info.html" <<EOF
        <!DOCTYPE html>
        <html lang="en">

        <script src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>

        <head>
            <meta charset="UTF-8">
            <title>cbuild: project info</title>

            <style>
                body {
                    font-family: monospace;
                    padding: 40px;
                }

                main {
                    max-width: 900px;
                    margin: auto;
                }

                h1 {
                    border-bottom: 1px solid #00ff66;
                    padding-bottom: 10px;
                }

                h2 {
                    margin-top: 35px;
                }

                .grid {
                    display: grid;
                    grid-template-columns: repeat(2, 1fr);
                    gap: 15px;
                }

                .box {
                    border: 1px solid #00ff66;
                    padding: 20px;
                    border-radius: 7px;
                    display:flex;
                    aling-itens:center;
                    justify-content:center;
                    flex-direction:column;
                }

                .label {
                    opacity: 0.6;
                }

                .value {
                    font-size: 22px;
                    margin-top: 8px;
                }

                footer {
                    margin-top: 40px;
                    opacity: 0.5;
                }
            </style>
        </head>

        <body>

        <main>

            <h1>cbuild: project statistics</h1>

            <h2>System</h2>

            <div class="grid">

                <div class="box">
                    <div class="label">KERNEL</div>
                    <div class="value">$(kernel)</div>
                </div>

                <div class="box">
                    <div class="label">COMPILER</div>
                    <div class="value">$(compiler)</div>
                </div>

            </div>

            <h2>Project</h2>

            <div class="grid">

                <div class="box">
                    <div class="label">SIZE</div>
                    <div class="value">$(size)</div>
                </div>

                <div class="box">
                    <div class="label">LINES</div>
                    <div class="value">$(lines)</div>
                </div>

                <div class="box">
                    <div class="label">C FILES</div>
                    <div class="value">$(find_c_files)</div>
                </div>

                <div class="box">
                    <div class="label">HEADER FILES</div>
                    <div class="value">$(find_h_files)</div>
                </div>

            </div>

            <h2>Runs</h2>

            <div class="grid">

                <div class="box">
                    <div class="label">LAST RUN</div>
                    <div class="value">$last_run</div>
                </div>

                <div class="box">
                    <div class="label">LAST BUILD</div>
                    <div class="value">$last_build</div>
                </div>

            </div>

            <h2>Charts</h2>

            <div class="box">
                <div class="label">C and Header File Count</div>
                <div id="cEh"></div>
            </div>

            <footer>

            </footer>

        </main>

        </body>

        <script>
            const data = [{
                labels: ["C", "Header"],
                values: [$(find_c_files), $(find_h_files)],
                type: "pie"
            }];

            const layout = {
                height: 400,
                width: 500
            };

            Plotly.newPlot("cEh", data, layout);
        </script>

    </html>
EOF

    verbose "Files generated:"
    verbose "+ docs/info.html"
}

case "$flag" in
    --html|--visual)
        visual
        log_info "Info visual created."
        ;;
    *)
        default
        log_info "Info created."
        ;;
esac
