require 'rails_helper'

feature 'view jobs' do
  scenario 'successfully' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')

    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)
  

    visit root_path
    click_on 'Vagas de emprego'
    expect(page).to have_content ('Analista Ruby')
    expect(page).to have_content ('Trabalhará com desenolvimento de projeto em Ruby')
    expect(page).to have_content ('R$ 2.500,00')
    expect(page).to have_content ('Junior')
    expect(page).to have_content ('Certificação em Ruby')

  end
  scenario 'has no jobs' do

    visit root_path
    click_on 'Vagas de emprego'
    expect(page).not_to have_content ('Analista Ruby')
    expect(page).to have_content ('Não há vagas de emprego disponível')

  end

  scenario 'expired job' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')

    job = Job.create!(title: 'Analista Ruby', description: 'Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2020', total: '5', company_id: collaborator.company_id)
  

    visit root_path
    click_on 'Vagas de emprego'
    expect(page).not_to have_content ('Analista Ruby')
    expect(page).to have_content ('Não há vagas de emprego disponível')
  end

  scenario 'no job position  ' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')

    job = Job.create!(title: 'Analista Ruby', description: 'Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2025', total: '0', company_id: collaborator.company_id)
  

    visit root_path
    click_on 'Vagas de emprego'
    expect(page).not_to have_content ('Analista Ruby')
    expect(page).to have_content ('Não há vagas de emprego disponível')
  end

  scenario 'job disabled' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')

    job = Job.create!(title: 'Analista Ruby', description: 'Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2025', total: '0', status: 5, company_id: collaborator.company_id)
  

    visit root_path
    click_on 'Vagas de emprego'
    expect(page).not_to have_content ('Analista Ruby')
    expect(page).to have_content ('Não há vagas de emprego disponível')
  end


end
