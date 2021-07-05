module JuliaElectronPlayground

using Electron

import FilePaths


GUI_ENTRY_HTML = joinpath(FilePaths.@__PATH__, "..", "gui", "build", "index.html")

function launch_gui()
    app = Application()
    win = Window(
        app,
        GUI_ENTRY_HTML,
        options=Dict("title" => "JuliaElectronPlayground"),
    )
end

end # module
