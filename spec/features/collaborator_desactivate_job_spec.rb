require 'rails_helper'

feature 'Collaborator desactivate job' do
  scenario 'successfully' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    login_as collaborator, scope: :collaborator
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)
    
    visit root_path
    click_on "Acesso empresa"
    click_on "Vagas de emprego cadastradas"
    click_on job.title
    click_on 'Desativar vaga de empego'

    expect(page).to have_content('disabled')

  end
end