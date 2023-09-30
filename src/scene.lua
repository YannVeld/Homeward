
Scene = Class{
    init = function(self, story, question, conversion1, afterstory1, conversion2, afterstory2, getNextScene1, getNextScene2)
        self.story = story
        self.question = question
        self.afterstory1 = afterstory1
        self.afterstory2 = afterstory2

        self.conversion1 = conversion1
        self.conversion2 = conversion2

        self.getNextScene1 = getNextScene1
        self.getNextScene2 = getNextScene2 or getNextScene1
    end,
}


