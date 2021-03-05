require 'rails_helper'

feature 'view company jobs' do
  scenario 'view company jobs' do
    collaborator = Collaborator.create!(email: 'ivan@big-jobs.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    
    login_as collaborator, scope: :collaborator
    
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)

    job2 = Job.create!(title: 'Analista Java', description: ' Trabalhará com desenolvimento de projeto em Java',
                      salary: '3500', level: 'Pleno',
                      requirements: 'Certificação em Java', 
                      deadline: '22/12/2025', total: '3', company_id: collaborator.company_id)

    visit root_path
    click_on 'Acesso empresa'
    click_on 'Vagas de emprego cadastradas'

    expect(page).to have_content ('Analista Ruby')
    expect(page).to have_content ('Trabalhará com desenolvimento de projeto em Ruby')
    expect(page).to have_content ('R$ 2.500,00')
    expect(page).to have_content ('Junior')
    expect(page).to have_content ('Certificação em Ruby')
    expect(page).to have_content ('5')

    expect(page).to have_content ('Analista Java')
    expect(page).to have_content ('Trabalhará com desenolvimento de projeto em Java')
    expect(page).to have_content ('R$ 3.500,00')
    expect(page).to have_content ('Pleno')
    expect(page).to have_content ('Certificação em Ruby')
   
   end
   scenario 'another company employee sees jobs' do
    collaborator = Collaborator.create!(email: 'ivan@big-jobs.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)
    
    collaborator2 = Collaborator.create!(email: 'carolina@big-jobs.com', password: '123456', cpf: '26701421687',
                      name: 'Carolina Oliveira')

    login_as collaborator2, scope: :collaborator

    visit root_path
    click_on 'Acesso empresa'
    click_on 'Vagas de emprego cadastradas'
    
    expect(page).to have_content ('Analista Ruby')
    expect(page).to have_content ('Trabalhará com desenolvimento de projeto em Ruby')
    expect(page).to have_content ('R$ 2.500,00')
    expect(page).to have_content ('Junior')
    expect(page).to have_content ('Certificação em Ruby')
    expect(page).to have_content ('5')
   end

   scenario 'another company employee accesses jobs' do
    collaborator = Collaborator.create!(email: 'ivan@big-jobs.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)
    
    collaborator2 = Collaborator.create!(email: 'carolina@jobs.com', password: '123456', cpf: '26701421687',
                      name: 'Carolina Oliveira')

    login_as collaborator2, scope: :collaborator

    visit root_path
    click_on 'Acesso empresa'
    click_on 'Vagas de emprego cadastradas'
    
    expect(page).to have_content ('Não há vagas de emprego disponível')
    expect(page).not_to have_content ('Analista Ruby')
    expect(page).not_to have_content ('Trabalhará com desenolvimento de projeto em Ruby')
    expect(page).not_to have_content ('R$ 2.500,00')
    expect(page).not_to have_content ('Junior')
    expect(page).not_to have_content ('Certificação em Ruby')
   end

end