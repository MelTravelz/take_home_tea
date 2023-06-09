<!-- ReadMe -->
<a id="readme-top"></a>

<!-- Opening -->
<br />
<div align="center">
  <img src="https://user-images.githubusercontent.com/116964982/244501735-3bec97cb-c930-4020-b2f4-b82042cb8929.png" alt="take_home_tea" width="50%">

  <p align="center">
    This is a practice take home test to prepare soon-to-be-graduates from the <a href="https://turing.edu/">Turing School for Software & Design</a> for the interview process. Students are asked to spend 8 hours building out an MVP (minimum viable product) based off a short <a href="https://mod4.turing.edu/projects/take_home/take_home_be">prompt</a>. Nearly all choices are left open to interpretation.
  </p>
</div>
<br>

<!-- TABLE OF CONTENTS -->
<h2>Table of Contents</h2>

  <ol>
    <li><a href="#inspiration">Inspiration & Decisions Made</a></li>
    <li><a href="#planning">Planning Process</a></li>
    <li><a href="#schema">Schema Diagram</a></li>
    <li><a href="#testing">Testing</a></li>
    <li><a href="#endpoints">Endpoints</a></li>
    <li><a href="#contact">Who Dat?</a></li>
  </ol>

<!-- INSPIRATION -->
<h2 id="inspiration">Inspiration & Decisions Made</h2>

<h3><strong>Inspiration</strong></h3>

When first considering this project, I immediatly thought of the company [Universal Yums](https://www.universalyums.com/). They package snacks from around the world and send them to subscribers on a monthly basis. Each month, a goodies from a random new country arrives! 

<h3><strong>Descisions</strong></h3>
 
Certain decisions had to be made before moving forward in the project:
- It was determined that only the company would have the ability to create a subscription
- Only the company would choose which teas are designated to which subscription, similar to how Universal Yums organizes their [subscriptions](https://www.universalyums.com/gift). The teas could also be random selected each month or offered as set packages such as only-herbals or wake-me-up-caffeine. 
- Users will be able to select the `frequency` of tea delivery: *monthly*, *bi-monthly*, and *quartery*. They will also be able to change the `status` of their specific subscription: *active* or *cancelled*. This choice led to these two attributes living in the `user_subscriptions` join table, while the `title` and `price` of the subscriptions stayed in the `subscriptions` table.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- PLANNING -->
<h2 id="planning">Planning Process</h2>

<details>
  <summary>Planning MVP Endpoints</summary>
  Important points that came up when planning the MVP endpoints was considering:
    <ul>
      <li> Which controller(s) the different actions would be written in
      <li> Whether cancelling a subscription meant deleting a record or just updating a status 
      <li> Brainstorming other useful endpoints that could be created if time allowed
    </ul>
  <div align="center"><img src="https://user-images.githubusercontent.com/116964982/244543525-e1737687-e37e-48e5-b50d-006d0bc42c3d.png" alt="planning_MVP_notion" width="90%"></div>
</details>

<details>
  <summary>GitHub Project Tickets</summary>
    Next, a GitHub Project Board was created and tickets written for each major step of the process.
  <div align="center"><img src="https://user-images.githubusercontent.com/116964982/244550970-c413d6dd-c61f-4284-84b9-6120efb3c2f0.png" alt="planning_github_project_tickets" width="70%"></div>
</details>
  
<details>
  <summary>JSON Contract</summary>
  In each endpoint ticket, a JSON Contract was written for both happy and sath path testing.
  <div align="center"><img src="https://user-images.githubusercontent.com/116964982/244561949-8fe949ab-a259-4f3f-adc7-8b17154ae8d4.png" alt="json_contract" width="100%"></div>
  <div align="center"><img src="https://user-images.githubusercontent.com/116964982/244562008-79b01aa4-2cdd-47e3-85d1-59f0da3547f2.png" alt="json_contract" width="100%"></div>
</details>

<details>
  <summary>Pull Request Template</summary>
    A simple PR tempate was designed to expediate solo work.
  <div align="center"><img src="https://user-images.githubusercontent.com/116964982/244543639-7d79b9f3-dd4b-4ca8-908f-f3f4146505d7.png" alt="planning_PR_template">
  </details>

  <details>
    <summary>Pull Request Consistancy</summary>
    Consistency in style was emphasized when creating PRs.
  <div align="center"><img src="https://user-images.githubusercontent.com/116964982/244543689-4c7978be-8766-44fb-be71-8b20affd888a.png" alt="planning_PR_style" width="80%">
  </details>
</div>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SCHEMA -->
<h2 id="schema">Schema Diagram</h2>

- Due to the previous described design choices, join tables between users & subscriptions and subscriptions & teas was required. Since a user's subscriptions are recorded as join table records, the status and frequency of purchases was relocated to that table. 
- Also worth noting is how the address is saved as individual attributes rather than as a full address. This was the preferred choice because it would prevent future reorganization of data. 

<div align="center">
  <img src="https://user-images.githubusercontent.com/116964982/244532100-97396fa9-f89c-400f-bc66-cd5c1eefef6e.png" alt="take_home_tea_schema"></div>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- TESTING -->
<h2 id="testing">Testing</h2>

- Happy path, sad path, and edge case testing were considered and tested. When a request cannot be completed, an error object is returned.

<div>
    <pre>
    <code>
{
  "errors": [
    {
      "status": "404"
      "title": "Invalid Request",
      "detail": "Couldn't find User with 'id'=< id >"
     }
   ]
}
    </code></pre>
</div>

<br>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ENDPOINTS -->
<h2 id="testing">Endpoints</h2>

- Based on a previous work with Frontend teams, only the record's *`id`* for the `POST` and `PATCH` endpoints are returned. 
- It was decided that the imaginary Fronted team would be using functional programming and Typescript; thus, they would hit a different endpoint to gather the needed information after a record was created or updated. All they might need is the *`id`*, which allows for more flexibility in changing where a user is directed after one of these actions.

<details>
  <summary><code>POST "/api/v1/users/:id/subscriptions"</code></summary>
  Request:
  <pre>
    <code>
{ 
  "subscription_id": 3, 
  "frequency": "quarterly" 
}
  </code></pre> 
  <br>

  Response:

  | Code | Description |
  | :--- | :--- |
  | 201 | CREATED |

  <pre>
    <code>
{
  "data": {
    "id": "11",
    "type": "user_subscription"
  }
}
  </code></pre> 
</details>

<details>
  <summary><code>PATCH "/api/v1/users/:id/subscriptions"</code></summary>
  Request:
  <pre>
    <code>
{ 
  "user_subscription_id": 11, 
  "status": "active",
  "frequency": "monthly" 
}
  </code></pre> 
  <br>

  Response:

  | Code | Description |
  | :--- | :--- |
  | 200 | OK |

  <pre>
    <code>
{
  "data": {
    "id": "11",
    "type": "user_subscription"
  }
}
  </code></pre> 
</details>

<details>
  <summary><code>GET "/api/v1/users/:id/subscriptions"</code></summary>
  Response:

  | Code | Description |
  | :--- | :--- |
  | 200 | OK |

  <pre>
    <code>
{
  "data": {
    "id": null,
    "type": "user_subscriptions",
    "attributes": {
      "all_sub_info": [
        {
          "user_subscription_id": 10,
          "status": "cancelled",
          "frequency": "bi-monthly",
          "title": "Andromeda",
          "price_usd": 17.81
        }, { ...etc... }
      ]    
    }
  }
}
  </code></pre> 
</details>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTOR -->
<h2 id="contact">Who Dat?</h2>


<p align="right">(<a href="#readme-top">back to top</a>)</p>