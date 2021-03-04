require 'rails_helper'

feature 'Search job' do
  scenario 'successfully' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')

    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)
  

    visit root_path
    click_on 'Vagas de emprego'
    fill_in 'Buscar', with: 'Analista Ruby'
    click_on 'Pesquisar'    
    expect(current_path).to eq search_job_path
    expect(page).to have_content ('Analista Ruby')
    expect(page).to have_content ('Trabalhará com desenolvimento de projeto em Ruby')
    expect(page).to have_content ('R$ 2.500,00')
    expect(page).to have_content ('Junior')
    expect(page).to have_content ('Certificação em Ruby')

  end

  scenario 'search for nonexistent job' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)

    visit root_path
    click_on 'Vagas de emprego'
    fill_in 'Buscar', with: 'Analista Java'
    click_on 'Pesquisar'    
    expect(current_path).to eq search_job_path
    
    expect(page).to have_content('Nenhuma vaga de emprego encontrada')
    expect(page).not_to have_content('Analista Java')
              
  end
end