using Pkg

function install(name)
    installed_packages = keys(Pkg.installed())
    if name ∉ installed_packages
        Pkg.add(name)
    end
end

function includedir(dir)
	for (root, dirs, files) in walkdir(dir)
		for f in files
			include(root*"/"*f)
		end
	end
end