defmodule DicksWeb.DrawChannel do
  use DicksWeb, :channel

  @impl true
  def join("draw:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_in("draw:stroke", payload, socket) do
    broadcast_from(socket, "draw:stroke", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
