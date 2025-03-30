defmodule LagerWeb.ItemsLive.FormComponent do
  use LagerWeb, :live_component

  alias Lager.Storage

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage items records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="items-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:amount]} type="number" label="Amount" />
        <.input field={@form[:cost]} type="number" label="Cost" />
        <.input field={@form[:best_before]} type="text" label="Best before" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Items</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{items: items} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Storage.change_items(items))
     end)}
  end

  @impl true
  def handle_event("validate", %{"items" => items_params}, socket) do
    changeset = Storage.change_items(socket.assigns.items, items_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"items" => items_params}, socket) do
    save_items(socket, socket.assigns.action, items_params)
  end

  defp save_items(socket, :edit, items_params) do
    case Storage.update_items(socket.assigns.items, items_params) do
      {:ok, items} ->
        notify_parent({:saved, items})

        {:noreply,
         socket
         |> put_flash(:info, "Items updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_items(socket, :new, items_params) do
    case Storage.create_items(items_params) do
      {:ok, items} ->
        notify_parent({:saved, items})

        {:noreply,
         socket
         |> put_flash(:info, "Items created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
