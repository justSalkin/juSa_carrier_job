Config = {}
Config.taskbar = 3000 --Interaction takes 3sec

------------------- Change this -----------------

Config.Chance = 90 -- lower number = more chance to get money insted of an item
Config.disallow_sprint_and_jump = true --if true, players are not allowed to run or jump while carrying a package
Config.show_disallow_tip = true --if true, players trying to jump or run will get an info about disallow

Config.moneyrewardmin = 1 -- min amount of rewarded money
Config.moneyrewardmax = 4 -- max amount money
-- The money reward value is divided by 10, so that amounts under $1 are also possible.

Config.applyJobSpecifications = false --set true if u want to permit or restrict players with/without jobs
Config.jobRestriction = { --states that players with these jobs are not allowed to work | leave blank if you do not want any restrictions
    { name = "police", grade = 2 }, --player with police job with grade 3 or higher are still allowed to work
}
Config.jobPermission = { --specifies which job players need to have in order to be allowed to work | leave blank if you do not want any restrictions
    { name = "sheriff", grade = 2 }, --players need one of these jobs, for example sheriff and at least grade 2
}

Config.reward = {
    { item = "coal", name = "coal", rewardmin = 1, rewardmax = 3},
    { item = "iron", name = "iron", rewardmin = 1, rewardmax = 3}
}

------------------- NPCs ------------------------
Config.NPCs = {
    --No Interaction
    { npc_name = "Guard", blip = 0, npcmodel = "u_m_m_sdbankguard_01", coords = vector3(2656.13, -1525.01, 47.38), heading = 145.08, radius = 0, type = "nointeraction"},
    --Job NPC
    { npc_name = "Docker Job", -- NPC/blip name
    blip = -426139257, --set to 0 to not display a blip for this NPC
    npcmodel = "mp_u_m_m_fos_dockworker_01", 
    coords = vector3(2663.62, -1541.88, 44.98), 
    heading = -122.82, 
    radius = 3.0, --interaction radius
    type = "jobinteraction", -- if "jobinteraction" you are able to clock in at this npc
    },
}
------------------- TRANSLATE HERE --------------
Config.Language = {
    jobname = "Carrier Job",
    talk = "talk to npc",
    press = "press ",
    picking_package = "picking up a package",
    deliv_package = "putting package down",
    bring_package = "Bring the cargo to the ship.",
    get_package = "Go pick up a package and bring it to the ship.",
    task_clocking_in = "... clocking in ...",
    clocked_in = "you have been clocked in",
    task_clocking_out = "... clocking out ...",
    clocked_out = "you have been clocked out",
    notify_clocked_in = "you have been clocked in",
    notify_clocked_out = "you have been clocked out",
    reward = "You got",
    notallowed = "Your job does not allow you to work here.",
    dontJump = "Mit schweren Paketen solltest du nicht springen, sonst fällst du hin.",
    dontRun = "Mit schweren Paketen solltest du nicht schnell laufen, sonst fällst du hin.",
}
------------------- Interaction -----------------
Config.keys = {
    G = 0x760A9C6F, -- talk/interact
}
------------------- Marker -----------------------
-- DONT TOUCH THIS
Config.Marker_1_coords = vector3(2667.77, -1502.82, 44.97) --pickup location
Config.Marker_2_coords = vector3(2671.64, -1504.82, 44.97)
Config.Marker_3_coords = vector3(2673.83, -1521.78, 44.97)
Config.Marker_4_coords = vector3(2667.96, -1533.68, 45.97)
Config.Marker_5_coords = vector3(2667.56, -1523.19, 45.97)
Config.Marker_6_coords = vector3(2678.93, -1496.94, 45.97)

Config.Marker_9_coords = vector3(2654.10, -1527.25, 47.36) --storage position
