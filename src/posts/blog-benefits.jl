
content = string(
    GenDoc.generate_front_matter(;
        title = "'The benefits of writing blog posts'",
        date = "2020-01-16",
        tags = "['blog', 'writing', 'reasons']"
    ),
raw"""

<link href='http://fonts.googleapis.com/css?family=PT+Mono' rel='stylesheet' type='text/css'>

The first step into creating good habits is figuring out why exactly you want the habit.
To me writing blog posts seems like a good habit, but I'm unsure why.
This post will attempt to convince the reader and myself of the benefits.
I have combined my own ideas with the ideas by Terry Tao [[1]](#1) and Gregory Gunderson [[2]](#2), and grouped them.

### Pedagogic benefits

- Writing detailed expository notes is a way to practise research.
  This allows you to break free from the methods you are used to [[2]](#2).
- One can practise writing [[1]](#1).
- Allows one to test understanding of an idea [[1]](#1).
  It forces you to explain it clearly without hand waving.
  When aiming your text at colleagues or future employers, you cannot use jargon to hide your lack of knowledge [[2]](#2).
- Writing allows figuring out what exactly you do not understand, or what you need to learn first [[2]](#2).
- Writing aids in structuring knowledge [[2]](#2).

### Practical benefits

- Writing a post might not actually solve some difficult problem, but it is a concrete step towards a solution [[2]](#2).
  It will probably teach you a lot about the background of a problem.
- Good ideas do not randomly appear. They are formed after getting a deep understanding of the problem [[2]](#2).
- Information can be recalled easily [[1, 2]](#2).
- Writing frees up mental space [[1]](#1).

### Collaborative benefits

- Sharing information with friends and colleges is more easy.
  For example, I'm a fan of Git but find it hard to explain what is exactly so great about it.
  After writing a post on it, my thoughts are much more structured, and I can even refer people to the text.
- Much (scientific) knowledge, which someone in this world has, is not known to the public.
  Writing technical blogs can help to spread information [[2]](#2).
- Others can inform you of mistakes in your thoughts.
  See the post by [Swartz (2006)](#3) for more about better thinking.
- Compared to papers blogs are read by more people.

If you are aware of more benefits, then please let me know, so I can add them to the list.
By now, I hope to have convinced the reader.
I have, at least, convinced myself.

### References
<a id="1"></a>
[1] Terry Tao. (2009).
Write down what you've done.
Retrieved January 16, 2020, from <https://terrytao.wordpress.com/career-advice/write-down-what-youve-done>

<a id="2"></a>
[2] Gregory Gundersen. (2020).
Why I Keep a Research Blog.
Retrieved January 16, 2020, from <http://gregorygundersen.com/blog/2020/01/12/why-research-blog>

<a id="3"></a>
[3] Aaron Swartz. (2006).
Tips for Better Thinking.
Retrieved July 29, 2020, from <http://www.aaronsw.com/weblog/thinkbetter>

"""
)
