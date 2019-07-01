#standardSQL
WITH
  subreddits AS (
  SELECT
    subreddit,
    COUNT(*) as num_posts
  FROM
    `fh-bigquery.reddit_posts.*`
  WHERE
    _TABLE_SUFFIX BETWEEN '2017_01' AND '2019_02'
    AND score >= 5
    AND LENGTH(title) >= 8
    AND subreddit NOT IN ("me_irl",
      "2meirl4meirl",
      "anime_irl",
      "furry_irl",
      "cursedimages",
      "meirl",
      "hmmm")
  GROUP BY
    subreddit
   HAVING num_posts >= 2000
  ORDER BY
    APPROX_COUNT_DISTINCT(author) DESC
  LIMIT
    2500 )
    

SELECT
  subreddit,
  REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(title, '&amp;', '&'), '&lt;', '<'), '&gt;', '>'), '�', '') as title
FROM (
  SELECT
    subreddit,
    title,
    ROW_NUMBER() OVER (PARTITION BY subreddit ORDER BY score DESC) AS score_rank
  FROM
    `fh-bigquery.reddit_posts.*`
  WHERE
    _TABLE_SUFFIX BETWEEN '2017_01' AND '2019_02'
    AND LENGTH(title) >= 8
    AND subreddit IN (SELECT subreddit FROM subreddits) )
    
WHERE
  score_rank <= 2000
ORDER BY subreddit