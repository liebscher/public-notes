---
description: Three short steps to setting up a local LLM on your MacBook
created: 2026-05-10T20:30:00
tags:
author:
  - Alex Liebscher
---
I occasionally go to Claude for learning, discovery, and interactive note taking. For example, I used it to give me music recommendations based on a very specific and detailed review I dictated to it of Kacey Musgraves' new album, *Middle Of Nowhere* (which led me to Natalia Lafourcade). But I’m increasingly concerned about the environmental footprint of AI use, as well as the complete lack of privacy of what can sometimes feel like Google searches but personalized on steroids. Even though my thoughts on Kacey's music aren't exactly my most private thoughts, they really do reveal something quite personal about who I am and what I like. And one thing I don’t like: corporations having this level of detail about me.

This is core tension I think a lot of people are feeling today: we want to use these tools, but there's unknown and nebulous fears and impacts we want to avoid.

Truthfully, I had a preconceived fear of trying to set up an LLM locally. I vaguely worried about space, memory, and complexity of getting set up. I came across [an article](https://jola.dev/posts/running-local-models-on-m4) though that laid out their process of getting Qwen (another open-source LLM) set up. The brevity of that article gave me a bit of hope that maybe it *could* be simple.

The reality is that the process for a non-technical individual (or technical, see later) to get an LLM set up looks like this:
1. Install LM Studio
2. Download gemma-4 (about 6gb, took about 5 minutes over my wifi)
3. Start using an LLM locally

Overall, the process felt less like "tech setup" and more like installing a typical piece of software.

For those who are reading this and thinking, "Yeah, but is it *really* good?" The answer is yes. I especially wanted a nice UI with projects—I was frustrated that Claude limited free plans to a maximum of 5. That said, the projects in LM Studio are really just folders, so there isn't shared context between chats. I also like how conversations are stored locally as JSON and LM Studio let's you export chats easily.

***

If you are comfortable digging into technical details, LM Studio feels really robust. I haven't explored this much yet but it seems like LM Studio has some fairly advanced options and customizations. The interface seems pretty transparent with how the models are being served locally.

It's also exciting that (I think) you can also connect LM Studio to e.g. Claude Code, so you can use CC with a local model. That feels very attractive because one reason I don't like using CC is the insane pace through which it goes through tokens (and thus data center inference) and how quickly that adds up.