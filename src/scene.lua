
Scene = Class{
    init = function(self, story, question, conversion1, conversion2, afterstory, getNextScene1, getNextScene2)
        self.story = story
        self.question = question
        self.afterstory = afterstory

        self.conversion1 = conversion1
        self.conversion2 = conversion2

        self.getNextScene1 = getNextScene1
        self.getNextScene2 = getNextScene2
    end,
}


