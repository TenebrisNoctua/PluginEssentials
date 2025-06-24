-- Strips the given properties in the <code>exclude</code> table from the <code>props</code> table.
return function(props: {[any]: any}, exclude: {any})
    local export = table.clone(props)

    for _, k in ipairs(exclude) do
        export[k] = nil
    end

    return export
end
