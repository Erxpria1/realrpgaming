local migrations = {
    "alter table mdc_criminals modify details text default \"None.\";",
    [[
        CREATE TABLE IF NOT EXISTS `mdc_anpr` (
          `id` INT(11) NOT NULL AUTO_INCREMENT,
          `vehicle_plate` VARCHAR(32) NOT NULL,
          `description` TEXT NOT NULL,
          `doneby` INT(11) NOT NULL,
          `time` INT(11) NOT NULL,
          `organization` VARCHAR(10) NOT NULL DEFAULT 'LSPD',
          PRIMARY KEY (`id`)
        ) ENGINE=MyISAM DEFAULT CHARSET=latin1;
    ]],
}
addEventHandler('onResourceStart', resourceRoot,
    function ()
        exports.mysql:createMigrations(getResourceName(getThisResource()), migrations)
    end
)
