defmodule LiveBlog.Feed do
  use Agent
  alias LiveBlog.Post

  def start_link(_) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def all() do
    Agent.get(__MODULE__, & &1)
  end

  def seed() do
    content1 = """
    The companies with the most powerful AI models, such as GPT-4 and Gemini, will face more onerous requirements, such as having to perform model evaluations and risk-assessments and mitigations, ensure cybersecurity protection, and report any incidents where the AI system failed. Companies that fail to comply will face huge fines or their products could be banned from the EU. 
    It’s also worth noting that free open-source AI models that share every detail of how the model was built, including the model’s architecture, parameters, and weights, are exempt from many of the obligations of the AI Act.
    """

    content2 = """
    A recent survey of 600 IT leaders by Salesforce reveals a new mandate from their bosses: incorporate generative artificial intelligence (AI) into the technology stack -- and fast. 
    But the response from IT professionals is "not so fast," highlighting concerns about resources, data security, and data quality. Nearly three in five IT professionals say business stakeholders hold unreasonable expectations on the speed and agility of new technology implementations.
    """

    content3 = """
    This involves ensuring the safe storage, transit, and administration of medications, which is critical to improving patient safety. For example, investing in the capabilities to safely store and hold critical medicines in your healthcare facility prevents patients in your community from having to travel to a hospital further away. When patients get treated as quickly as possible, their probability of recovery increases.
    Creating a safer environment for both patients and healthcare providers is the key to avoiding preventable harm. In this article, I'll look at a few technologies and processes that can support healthcare providers and organizational leaders in improving health outcomes, especially regarding supporting proper handling and monitoring of critical medication inventory.
    """

    Agent.update(__MODULE__, fn _ ->
      [
        %Post{id: 1, title: "MIT Technology Review", content: content1},
        %Post{
          id: 2,
          title: "Generative AI is the technology that IT feels most pressure to exploit",
          content: content2
        },
        %Post{id: 3, title: "Technology’s Role In Prioritizing Patient Safety", content: content3}
      ]
    end)
  end
end
