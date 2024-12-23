return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 14,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 23,
  properties = {
    ["border"] = "mainhub",
    ["music"] = "mainhub",
    ["name"] = "Floor One - Dess's House"
  },
  tilesets = {
    {
      name = "main_area",
      firstgid = 1,
      filename = "../tilesets/main_area.tsx",
      exportfilename = "../tilesets/main_area.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 14,
      id = 1,
      name = "tiles",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 53, 55, 66, 67, 67, 67, 67, 67, 67, 67, 53, 54, 54, 54, 54,
        0, 66, 68, 79, 80, 80, 80, 80, 80, 80, 80, 66, 67, 53, 54, 54,
        0, 79, 81, 79, 80, 80, 80, 80, 80, 80, 80, 79, 80, 66, 67, 67,
        0, 79, 81, 92, 93, 93, 93, 93, 93, 93, 93, 79, 80, 79, 80, 80,
        0, 92, 94, 4, 2, 2, 2, 2, 2, 2, 5, 92, 93, 79, 80, 80,
        0, 4, 2, 15, 15, 15, 15, 15, 15, 15, 15, 2, 5, 92, 93, 93,
        0, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 2, 2, 2,
        0, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,
        0, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 28, 28, 28,
        0, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 0, 0, 0,
        0, 27, 28, 15, 15, 15, 15, 15, 15, 15, 15, 28, 29, 0, 0, 0,
        0, 0, 0, 27, 28, 28, 28, 28, 28, 28, 29, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "collision",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 2,
          name = "",
          class = "",
          shape = "rectangle",
          x = 520,
          y = 200,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 160,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          class = "",
          shape = "rectangle",
          x = 40,
          y = 160,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 120,
          width = 320,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 200,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          class = "",
          shape = "rectangle",
          x = 40,
          y = 440,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 480,
          width = 320,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 440,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          class = "",
          shape = "rectangle",
          x = 520,
          y = 360,
          width = 120,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 640,
          y = 240,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "main_hub_south",
            ["marker"] = "east"
          }
        },
        {
          id = 22,
          name = "npc",
          class = "",
          shape = "point",
          x = 440,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "diamond_trash",
            ["cutscene"] = "hub.garbage"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "markers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 9,
          name = "entry",
          class = "",
          shape = "point",
          x = 600,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "spawn",
          class = "",
          shape = "point",
          x = 280,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
