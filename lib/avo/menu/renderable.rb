class Avo::Menu::Renderable < Avo::Menu::BaseItem
  attr_reader :renderable
  attr_reader :kwargs

  def initialize(renderable:, **kwargs)
    super(renderable:, **kwargs)

    @renderable = renderable
    @kwargs = kwargs
  end
end
