using Pkg
function installifnotinstalled(name)
	installed_packages = keys(Pkg.installed())
	if name ∉ installed_packages
		Pkg.add(name)
	end
end
installifnotinstalled("EntityComponentSystem")
installifnotinstalled("Gtk")

using EntityComponentSystem, Gtk, Graphics

world = World()
function includedir(dir)
	for (root, dirs, files) in walkdir(dir)
		for f in files
			include(root*"/"*f)
		end
	end
end
includedir("components")

canvas = GtkCanvas()
win = GtkWindow(canvas, "Pong")
@guarded draw(canvas) do widget
    ctx = getgc(canvas)
    h = height(canvas)
    w = width(canvas)
    # Paint red rectangle
    rectangle(ctx, 0, 0, w, h/2)
    set_source_rgb(ctx, 1, 0, 0)
    fill(ctx)
    # Paint blue rectangle
    rectangle(ctx, 0, 3h/4, w, h/4)
    set_source_rgb(ctx, 0, 0, 1)
    fill(ctx)
end
show(canvas)

exit_condition = Condition()
signal_connect(win, :destroy) do widget
	notify(exit_condition)
end
wait(exit_condition)
