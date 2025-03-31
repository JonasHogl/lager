defmodule LagerWeb.ItemsLive.Index do
  use LagerWeb, :live_view

  alias Lager.Storage
  alias Lager.Storage.Items

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :item_id, Storage.list_item_id())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Items")
    |> assign(:items, Storage.get_items!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Items")
    |> assign(:items, %Items{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Item")
    |> assign(:items, nil)
  end

  @impl true
  def handle_info({LagerWeb.ItemsLive.FormComponent, {:saved, items}}, socket) do
    {:noreply, stream_insert(socket, :item_id, items)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    items = Storage.get_items!(id)
    {:ok, _} = Storage.delete_items(items)

    {:noreply, stream_delete(socket, :item_id, items)}
  end
end
