
Scene = Class{
    init = function(self, image, story, question, conversion1, afterstory1, conversion2, afterstory2, getNextScene1, getNextScene2, sound1, sound2, entrySound, onEntry)
        self.image = image
        self.story = story
        self.question = question
        self.afterstory1 = afterstory1
        self.afterstory2 = afterstory2 or afterstory1

        self.conversion1 = conversion1
        self.conversion2 = conversion2

        self.getNextScene1 = getNextScene1
        self.getNextScene2 = getNextScene2 or getNextScene1

        self.sound1 = sound1
        self.sound2 = sound2

        self.entrySound = entrySound
        self.onEntry = onEntry or (function() end)
    end,
}


