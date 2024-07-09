//
//  QuotesData.swift
//  QueenOfPears
//
//  Created by Vina Melody on 7/7/24.
//

import Foundation

struct Quote: Hashable, Identifiable {
    var id: String {
        line
    }

    let line: String
    let source: String
}

func makeQuotes() -> Set<Quote> {
    [
        Quote(line: "It’s kind of fun to do the impossible.", source: "Walt Disney"),
        Quote(line: "Ideas come from curiosity.", source: "Walt Disney"),
        Quote(line: "When you’re curious, you find lots of interesting things to do.", source: "Walt Disney"),
        Quote(line: "Just keep swimming. Just keep swimming, swimming, swimming. What do we do? We swim, swim.", source: "Finding Nemo"),
        Quote(line: "I don’t care what they’re going to say. Let the storm rage on. The cold never bothered me anyway.", source: "Frozen"),
        Quote(line: "You and I are a team. Nothing is more important than our friendship.", source: "Monsters, Inc"),
        Quote(line: "Supercalifragilisticexpialidocious", source: "Mart Poppins"),
        Quote(line: "The only thing predictable about life is its unpredictability", source: "Ratatouille"),
        Quote(line: "Venture outside your comfort zone. The rewards are worth it.", source: "Tangled"),
        Quote(line: "Hakuna Matata…it means no worries.", source: "The Lion King"),
        Quote(line: "Life’s full of tough choices, isn’t it?", source: "The Little Mermaid"),
        Quote(line: "That might sound boring, but I think the boring stuff is the stuff I remember the most.", source: "Up"),
        Quote(line: "Sometimes the smallest things take up the most room in your heart.", source: "Winnie th Pooh"),
        Quote(line: "The flower that blooms in adversity is the most rare and beautiful of all.", source: "Mulan"),
        Quote(line: "You've got a friend in me.", source: "Toy Story"),
        Quote(line: "I don't want to survive. I want to live!", source: "Wall-E"),
        Quote(line: "Life is full of possibilities You just need to know where to look.", source: "Soul"),
        Quote(line: "Don't fear failure. Be afraid of not having the chance.", source: "Cars 3")
    ]
}
