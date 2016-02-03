class MoviesController < ApplicationController

  def index

    @movies = Movie.order(:title).page params[:page]
    @movies = Movie.search(params[:query]).order(:title).page params[:page] if params[:query]
    if params[:runtime_in_minutes]
      case params[:runtime_in_minutes]
      when 'under90'
        @movies = @movies.under_90_minutes.order(:title).page params[:page]
      when '91to120'
        @movies = @movies.between_90_and_120_minutes.order(:title).page params[:page]
      when 'over120'
        @movies = @movies.over_120_minutes.order(:title).page params[:page]
      else
        puts "This should not happen. Fix it!"
      end
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :image, :description
    )
  end

end