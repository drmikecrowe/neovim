local possession_status_ok, possession = pcall(require, "possession")
if not possession_status_ok then
	return
end

possession.setup {
    autosave = {
        current = true,  -- or fun(name): boolean
    },
    commands = {
        save = 'SSave',
        load = 'SLoad',
        delete = 'SDelete',
        list = 'SList',
    }
}
