local song = {
    metadatas = {
        audiofile = "sample.mp3",
        title = "Sample Song",
        artist = "Artist",
        mapcreator = "Map Creator",
        creationdate = "2019/05/08",
        version = "1.0"
    },

    extras = {
        customskin = nil,
        customhitsounds = nil
    },

    map = {
        bpm = 120,
        
        { 
            phase = "defense",
            time = 0,
            notes = {
                { time = 1, duration = 0, direction = "up" },
                { time = 2, duration = 0, direction = "down" },
                { time = 3, duration = 0, direction = "left" },
                { time = 4, duration = 0, direction = "right" },
                { time = 4, duration = 0, direction = "left" }
            }
        },

        {
            phase = "attack",
            time = 20,
            curves = { 
                { time = 25, points = { "0;0", "200;200", "300;300" } }
            },

            notes = {
                { time = "6", duration = 0 }
            }
        }
    }
}

return song