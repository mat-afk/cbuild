#!/usr/bin/env bash

bold=$(tput bold)
normal=$(tput sgr0)

files_c(){
    find . -name "*.c" | wc -l
}

files_h(){
    find . -name "*.h" | wc -l
}

path(){
    echo "$SRC_DIR"
}

compiler(){
    COMPILER="$(${cc:-cc} --version | head -n 1)"
    echo "$COMPILER"
}

kernel(){
    echo "$(uname -r)"
}

size(){
    du -sh . | cut -f1
}

lines(){
    grep '' -IR . | wc -l
}

default(){
    echo "${bold} System: ${normal}"
    echo "     Kernel:          $(kernel)"
    echo "     Compiler:        $(compiler)"

    echo ""

    echo "${bold} Quantities: ${normal}"
    echo "     Project size:    $(size)"
    echo "     C files:         $(files_c)"
    echo "     Header files:    $(files_h)"
    echo "     Lines:           $(lines)"
    echo "$LAST_RUN"

    echo -e "\n  Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>"
}

visual(){

    cat > info.html <<EOF
        <!DOCTYPE html>
        <html lang="en">

        <script src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>

        <head>
            <meta charset="UTF-8">
            <title>CBUILD - Project Info</title>

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

            <h1>CBUILD : Visual Information</h1>

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
                    <div class="value">$(files_c)</div>
                </div>

                <div class="box">
                    <div class="label">HEADER FILES</div>
                    <div class="value">$(files_h)</div>
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
                values: [$(files_c), $(files_h)],
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

    echo "File generated: info.html"
}

flag=$2

case "$flag" in
    -v)
        visual
        ;;
    *)
        default
        ;;
esac
