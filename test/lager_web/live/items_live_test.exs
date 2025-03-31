defmodule LagerWeb.ItemsLiveTest do
  use LagerWeb.ConnCase

  import Phoenix.LiveViewTest
  import Lager.StorageFixtures

  @create_attrs %{name: "some name", amount: 42, cost: 42, best_before: "some best_before"}
  @update_attrs %{name: "some updated name", amount: 43, cost: 43, best_before: "some updated best_before"}
  @invalid_attrs %{name: nil, amount: nil, cost: nil, best_before: nil}

  defp create_items(_) do
    items = items_fixture()
    %{items: items}
  end

  describe "Index" do
    setup [:create_items]

    test "lists all item_id", %{conn: conn, items: items} do
      {:ok, _index_live, html} = live(conn, ~p"/item_id")

      assert html =~ "Listing Item"
      assert html =~ items.name
    end

    test "saves new items", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/item_id")

      assert index_live |> element("a", "New Items") |> render_click() =~
               "New Items"

      assert_patch(index_live, ~p"/item_id/new")

      assert index_live
             |> form("#items-form", items: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#items-form", items: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/item_id")

      html = render(index_live)
      assert html =~ "Items created successfully"
      assert html =~ "some name"
    end

    test "updates items in listing", %{conn: conn, items: items} do
      {:ok, index_live, _html} = live(conn, ~p"/item_id")

      assert index_live |> element("#item_id-#{items.id} a", "Edit") |> render_click() =~
               "Edit Items"

      assert_patch(index_live, ~p"/item_id/#{items}/edit")

      assert index_live
             |> form("#items-form", items: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#items-form", items: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/item_id")

      html = render(index_live)
      assert html =~ "Items updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes items in listing", %{conn: conn, items: items} do
      {:ok, index_live, _html} = live(conn, ~p"/item_id")

      assert index_live |> element("#item_id-#{items.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#item_id-#{items.id}")
    end
  end

  describe "Show" do
    setup [:create_items]

    test "displays items", %{conn: conn, items: items} do
      {:ok, _show_live, html} = live(conn, ~p"/item_id/#{items}")

      assert html =~ "Show Items"
      assert html =~ items.name
    end

    test "updates items within modal", %{conn: conn, items: items} do
      {:ok, show_live, _html} = live(conn, ~p"/item_id/#{items}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Items"

      assert_patch(show_live, ~p"/item_id/#{items}/show/edit")

      assert show_live
             |> form("#items-form", items: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#items-form", items: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/item_id/#{items}")

      html = render(show_live)
      assert html =~ "Items updated successfully"
      assert html =~ "some updated name"
    end
  end
end
