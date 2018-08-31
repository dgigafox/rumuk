defmodule UserSearchTest do
    use Bhaduli.Case
    alias Bhaduli.User
    alias Bhaduli.User.{EducationalDetails, BasicInfo}
    alias Bhaduli.{Helper, UserRepository}

    test "should be able to search user based on gender" do
       id =  Helper.random_key
       basic_info = %BasicInfo{name: "test_user_1", age: 28, gender: "female"}
        {:ok, _} = User.start_link(id)
        User.update(id, basic_info)
        id
        |> User.get
        |> UserRepository.save
        id =  Helper.random_key
        basic_info = %BasicInfo{name: "test_user_2", age: 28, gender: "female"}
        {:ok, _} = User.start_link(id)
        User.update(id, basic_info)
        id
        |> User.get
        |> UserRepository.save
        query = %{gender: "female"}
        :timer.sleep(2000)
       result = UserRepository.search(query)
       {:ok, {:search_results, users,rank, count}}  = result
        assert count != 0
    end

   test "should be able to search user based on age range" do
       id = Helper.random_key
       basic_info = %BasicInfo{name: "osaka", age: 58, gender: "female"}
       educational_details = %EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
        {:ok, _} = User.start_link(id)
        User.update(id, basic_info)
        User.update(id, educational_details)
        id
        |> User.get
        |> UserRepository.save

        id = Helper.random_key
        basic_info = %BasicInfo{name: "erin", age: 28, gender: "female"}
        educational_details = %EducationalDetails{graduation: "G.B Pant", senior_secondary: "DIS", intermediate: "DIS"}
        {:ok, _} = User.start_link(id)
        User.update(id, basic_info)
        User.update(id, educational_details)
        User.get(id) |>  UserRepository.save

        query = %{gender: "female", min_age: 20, max_age: 50}

        :timer.sleep(2000)
       result = UserRepository.search(query)

       {:ok, {:search_results,users,rank, count}}  = result

        assert count != 0
    end


 end

