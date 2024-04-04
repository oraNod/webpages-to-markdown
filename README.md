# webpages-to-markdown
Ansible playbook and scripts used to convert webpages to markdown documents, among other things.

I used this Ansible playbook and other scripts to migrate `ansible.com` blog posts from where they were hosted on HubSpot to the source repository for the current site, which is built with a static site generator.
You might find this playbook and stuff useful for other things.
If so, great!

## Setting things up

```bash
python3 -m venv venv
source venv/bin/activate
python -m pip install ansible ansible-lint pandoc
```

## Converting webpages to markdown

1. Add the list of urls that you want to convert to the `webpage-urls.txt` file. I've included some blog post urls from `ansible.com` for demo purposes.
2. Run the playbook.

   ```bash
   ansible-playbook webpages-to-markdown.yaml
   ```

If the run was successful, you should see output similar to this:

```bash
PLAY RECAP ********************************************************************************************************************************************
localhost                  : ok=8    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

You can find the converted markdown files in the `markdown` directory.

Depending on the source of your webpage, the converted markdown files will probably contain a bunch of metadata and other text that you don't want to keep.
As a post-conversion task, you'll probably want to remove that stuff and make sure your markdown is "clean".
I used a combination of grep and sed expressions, along with manual effort, when migrating blog posts.
For example, to remove the footer text from the example files:

```
sed -i '/^::: {.content-slim .redhat-footer}/,$d' markdown/*.md
```

There are probably better ways to do all these things.
If you've got ideas on how to make improvements and feel like contributing, please create an issue or send a PR!

## Downloading images

One thing the playbook does not do is downloading images, or other resources, included in the webpages.
I used a simple Bash script to take care of that and wanted to include it.

```bash
./download-images.sh
```

Of course then you need to make sure image references in the converted markdown files are not broken.
For example, in the example `ansible-community-day-berlin-2023.md` file you can see this reference:

```markdown
![Ansible community day logo](../../images/posts/archive/community-day-berliin-20230824.png) 
```

To make that work after downloading images with the Bash script, you need to change the path so it matches the output directory, for example:

```markdown
![Ansible community day logo](images/community-day-berliin-20230824.png)
```

Once again, if you have lots of image references in your converted markdown files, use sed expressions or something similar to make fixing the image references less painful.
