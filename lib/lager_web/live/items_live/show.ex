defmodule LagerWeb.ItemsLive.Show do
  use LagerWeb, :live_view

  alias Lager.Storage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:items, Storage.get_items!(id))}
  end

  defp page_title(:show), do: "Show Items"
  defp page_title(:edit), do: "Edit Items"
end
