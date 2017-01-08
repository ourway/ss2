use Amnesia



defmodule Ss2.Validation do
  def validate_uri(str) do
    uri = URI.parse(str)
    case uri do
      %URI{scheme: nil} -> {:error, uri}
      %URI{host: nil} -> {:error, uri}
      %URI{path: nil} -> {:error, uri}
      uri -> {:ok, uri}
    end
  end
end


defmodule Ss2.Utils do
  def gethash(address) do
    :crypto.hash(:sha256, address) |> Base.encode16
  end
end



# needed to get defdatabase and other macros

# defines a database called Database, it's basically a defmodule with
# some additional magic
defdatabase Database do
  # this is just a forward declaration of the table, otherwise you'd have
  # to fully scope User.read in Message functions

  # this defines a table with an user_id key and a content attribute, and
  # makes the table a bag; tables are basically records with a bunch of helpers
    deftable Link, [:key, :original, :short, :code,  :datetime, :description], type: :bag do
      @type t :: %Link{key: String.t, original: String.t, short: String.t,
                        code: String.t, datetime: Integer, description: String.t}
      # this defines a helper function to fetch the user from a Message record
      def short(self) do
        Link.read(self.short)
      end

      # this does the same, but uses dirty operations
      def short!(self) do
        Link.read!(self.short)
      end

      @doc"""
        Checks for available key, generate if not exsisted.
      """
      def save(link) do

          utcnow = DateTime.utc_now |> DateTime.to_unix
          key = link |> Ss2.Utils.gethash
          Amnesia.transaction do
              result = case Database.Link.read!(key) do
                nil ->
                  ncode = findNewUrl()
                  short =  "https://ss2.ir/#{ncode}"
                  new_link = %Link{key: key, original: link,
                                  datetime: utcnow, short: short, code: ncode}
                  new_link |> Link.write
                  short

                data ->
                  data
               end
            result
          end
      end


      def remove(link) do
        key = link |> Ss2.Utils.gethash
        Amnesia.transaction do
          Link.delete(key)
        end
      end


      def get(link) do
        Amnesia.transaction do
          case Link.match!(original: link)  do
            nil ->
              save(link)
            data ->
              case %Amnesia.Table.Match{coerce: Link, values: [{Link, _key,
              _original, short, _code, _datetime, _description }]} = data do
                _ ->
                  short
              end
            end

        end
    end


      def from(short) do
        Amnesia.transaction do
          case Link.match!(short: short)  do
            nil ->
              :not_found
            data ->
              case %Amnesia.Table.Match{coerce: Link, values: [{Link, _key,
              original, _short, _code, _datetime, _description }]} = data do
                _ ->
                  original
              end
            end

        end
    end




      def findNewUrl(n\\4) do
          nu = :crypto.strong_rand_bytes(n) |> Base.url_encode64 |> binary_part(0, n)
          result = case Database.Link.match!(code:  nu) do
            nil ->
              nu
            _ ->
              findNewUrl(n+1)
          end
          result
      end




    end

end
