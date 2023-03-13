local Vertex = require('sprites.vertex')
local Arch = require('sprites.arch')

function Graph()
    local graph = {}
    graph.vv = {}
    graph.aa = {}

    function graph.alive()
        -- Scorri tutti gli archi
        for i, v in ipairs(graph.aa) do
            if not v.is_alive() then
                table.remove(graph.aa, i)
                graph.alive()
                return
            end
        end
    end

    function graph.print()
        for i, vertex in ipairs(graph.vv) do
            vertex.print()
        end
        for i, arch in ipairs(graph.aa) do
            arch.print()
        end
    end

    function graph.draw()
        for i, vertex in ipairs(graph.vv) do
            vertex.draw()
        end
        for i, arch in ipairs(graph.aa) do
            arch.draw()
        end
    end

    function graph.get_vertex(name)
        for i, v in ipairs(graph.vv) do
            if v.name == name then
                return v
            end
        end
    end

    function graph.add_arch(v1, v2)
        if (v1.name == v2.name) then
            print("DUPLICATE")
        end
        Arch(graph, v1, v2)
    end

    function graph.add_arch_name(n1, n2)
        i, v1 = graph.get_vertex_name(n1)
        i, v2 = graph.get_vertex_name(n2)
        graph.add_arch(v1, v2)
    end

    function graph.add_vertex(name)
        Vertex(graph, name)
    end

    function graph.add_vertexs(...)
        for i, name in ipairs({...}) do
            graph.add_vertex(name)
        end
    end

    function graph.get_vertex_name(name)
        for i, v in ipairs(graph.vv) do
            if v.name == name then
                return i, v
            end
        end
    end

    function graph.get_vertex_pos(x, y)
        for i, v in ipairs(graph.vv) do
            if v.isPos(x, y) then
                return i, v
            end
        end
    end

    function createUUID()
        local uuid = ""
        local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        for i = 1, 4 do
            local l = math.random(1, #chars)
            uuid = uuid .. string.sub(chars, l, l)
        end
        return uuid
    end

    function graph.new_vertex()
        graph.add_vertex(createUUID())
    end

    return graph
end

return Graph
