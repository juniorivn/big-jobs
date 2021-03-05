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

    expect(page).to have_content ('Analista Ruby')
    expect(page).to have_content('disabled')

  end
  scenario 'visitor accesses page with job disabled' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
  
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior', requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id,
                      status:'disabled')

    visit job_path(1)

    expect(page).to have_content ('Analista Ruby')
    expect(page).to have_content('Essa vaga de emprego foi desativada pela empresa')

  end
  scenario 'candidate accesses page with job disabled' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
  
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior', requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id,
                      status:'disabled')

    candidate = Candidate.create!(email: 'ivan@email.com', name:'Ivan de Oliveira Junior', cpf:'37355900803',
                      cell_phone:'987199837', short_biography: 'Formado em Sistemas de Informação',
                      academic_training: 'Superior Completo', password: '123456')

    login_as candidate, scope: :candidate
    
    visit job_path(1)

    expect(page).to have_content ('Analista Ruby')
    expect(page).to have_content('Essa vaga de emprego foi desativada pela empresa')

  end
end