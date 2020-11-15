defmodule DealSignal.Repo.Migrations.CreateMappingTable do
  use Ecto.Migration

  def change do
    create table(:deals) do
      add(:provider, :string)
      add(:manufacturer, :string)
      add(:name, :string)
      add(:image_url, :string)
      add(:deal_end, :naive_datetime)
      add(:deal_id, :integer)
      add(:deal_url, :string)

      timestamps()
    end
  end
end
