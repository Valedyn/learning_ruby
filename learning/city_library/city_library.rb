# frozen_string_literal: true
class Book
  attr_reader :id, :title, :author_name
  def initialize(id, title, author_name)
    @id = id
    @title = title
    @author_name = author_name
  end
end

class Author
  attr_reader :id, :first_name, :last_name, :age
  def initialize(id, first_name, last_name, age)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @age = age
  end

end

class BookAuthorPairs
  attr_reader :hash
  def initialize
    @hash = {}
  end
  def add(author_id, book_id)
    if @hash.key?(author_id)
      array_at_key = @hash[author_id]
      array_at_key.push(book_id)
      @hash.store(author_id, array_at_key)
    else
      @hash.store(author_id, [book_id])
    end
  end

  def get_books_by_author(author_id)
    @hash[author_id]
  end

  def get_author_id_of_book(book_id)
    @hash.each_pair{|author_id, books|
      books.each{
        |value| return author_id if value == book_id
      }
    }
    -1
  end

end

class Library
  attr_reader :book_author_pairs

  def initialize
    @book_author_pairs = BookAuthorPairs.new
    @authors = []
    @books = []
  end
  def add(author, book)
    @authors << author
    @books << book
    @book_author_pairs.add(author.id, book.id)
  end

  def get_books
    @books
  end

  def get_authors
    @authors
  end

  def get_books_by_author_name(first_name, last_name)
    author_id = -1
    @authors.each do |author|

      if author.first_name.to_s.downcase == first_name.to_s.downcase && author.last_name.downcase == last_name.downcase
        author_id = author.id
        break
      end
    end
    book_ids = @book_author_pairs.get_books_by_author(author_id)
    books = []
    @books.each do |book|
      book_ids.each do |book_id_to_search_for|
        if book_id_to_search_for == book.id
          books.push(book)
        end
      end
    end
    books
  end
end

author_1 = Author.new(1, 'David', 'Adrian', 18)
author_2 = Author.new(2, 'Scott Francis', 'Charles', 25)
author_3 = Author.new(3, 'Leonardo', 'Daniel', 36)

book_1 = Book.new(1, "Wizard Of Oz", "Leonardo Daniel")
book_2 = Book.new(5, "Sherlock Holmes of Oz", "Scott Francis Charles")
library = Library.new

library.add(author_3, book_1)
library.add(author_2, book_2)

library.get_books.each { |book| puts book.title }

library.get_books_by_author_name("Leonardo", "Daniel").each{|book| puts book.title }





