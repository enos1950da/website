class BooksController < ApplicationController
  before_action :set_book, only: %i[show extras]

  BOOK_SLUGS = %w[
    no-wall-they-can-build
    from-democracy-to-freedom
    contradictionary
    work
    expect-resistance
    recipes-for-disaster
    days-of-war-nights-of-love
    off-the-map
    no-habra-muro-que-nos-pare
    da-democracia-a-liberdade
    trabalho-edicao-resumida-de-emergencia
    espere-resistencia
    receitas-para-o-desastre
    dias-de-guerra-noites-de-amor
  ].map(&:freeze).freeze

  def index
    @html_id = 'page'
    @body_id = 'tools'
    @type    = 'books'
    @title   = PageTitle.new title_for(:books)

    @bullet_books = BOOK_SLUGS.map { |slug| Book.find_by(slug: slug) }

    render "#{Theme.name}/books/index"
  end

  def show
    @html_id  = 'page'
    @body_id  = 'tools'
    @type     = 'books'
    @editable = @book
    @title    = PageTitle.new title_for(:books, @book.slug.underscore)
    @tool     = @book

    render "#{Theme.name}/books/show"
  end

  def extras
    @html_id = 'page'
    @body_id = 'tools'
    @title   = PageTitle.new title_for(:books, @book.slug.underscore, :extras)

    render "#{Theme.name}/books/extras"
  end

  def lit_kit
    @html_id = 'page'
    @body_id = 'tools'
    @title   = PageTitle.new title_for(:books, :lit_kit)

    render "#{Theme.name}/books/lit_kit"
  end

  def into_libraries
    @html_id = 'page'
    @body_id = 'tools'
    @title   = PageTitle.new title_for(:books, :into_libraries)

    render "#{Theme.name}/books/into_libraries"
  end

  private

  def set_book
    @book = Book.find_by(slug: params[:slug])
    return redirect_to [:books] if @book.blank? || !BOOK_SLUGS.include?(@book.slug)
  end
end
