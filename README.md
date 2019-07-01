# reddit-gpt-2-cloud-run

Code for running a Reddit title generator API using [gpt-2-cloud-run](https://github.com/minimaxir/gpt-2-cloud-run).

The Reddit data was retrieved using the [BigQuery](https://cloud.google.com/bigquery/) in `query.sql`, which retrieves the Top 2000 posts on each of the Top 2500 subreddits from January 2017 to February 2019 (w/ miscellaneous quality filters).

The resulting CSV was encoded using [gpt-2-keyword-generation](https://github.com/minimaxir/gpt-2-keyword-generation) (w/ a 32 vCPU cloud machine as it's a lot of data!), and GPT-2 117M was finetuned on the resulting dataset using [gpt-2-simple](https://github.com/minimaxir/gpt-2-simple).

## Maintainer/Creator

Max Woolf ([@minimaxir](https://minimaxir.com))

*Max's open-source projects are supported by his [Patreon](https://www.patreon.com/minimaxir). If you found this project helpful, any monetary contributions to the Patreon are appreciated and will be put to good creative use.*

## License

MIT

## Disclaimer

This repo has no affiliation or relationship with OpenAI.