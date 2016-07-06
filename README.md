# domain\_extractor

Gem that handles domain extraction from website.

## How to run it

In your code:

```ruby
DomainExtractor::Extractor.instance.extract("http://www.righthello.com/team") #=> "righthello.com"
```
