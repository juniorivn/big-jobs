require 'rails_helper'

feature 'apply for a job' do
  scenario 'view button apply for jobs' do
    collaborator = Collaborator.create!(email: 'ivan@big-jobs.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)

    candidate = Candidate.create!(email: 'ivan@email.com', name:'Ivan de Oliveira Junior', cpf:'37355900803',
                                  cell_phone:'987199837', short_biography: 'Formado em Sistemas de Informação',
                                  academic_training: 'Superior Completo', password: '123456')
    login_as candidate, scope: :candidate
    
    visit root_path
    click_on 'Vagas de emprego'
    click_on job.title
    
    expect(page).to have_content 'Analista Ruby'
    expect(page).to have_content 'Junior'
    expect(page).to have_content 'Trabalhará com desenolvimento de projeto em Ruby'
    expect(page).to have_content 'Certificação em Ruby'
    expect(page).to have_content '22/12/2033'
    expect(page).to have_content 'Candidatar-se'
  
  
  end

  scenario 'view button apply for companies' do
    collaborator = Collaborator.create!(email: 'ivan@big-jobs.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    
    job = Job.create!(title: 'Analista Ruby', description: 'Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)

    candidate = Candidate.create!(email: 'ivan@email.com', name:'Ivan de Oliveira Junior', cpf:'37355900803',
                                  cell_phone:'987199837', short_biography: 'Formado em Sistemas de Informação',
                                  academic_training: 'Superior Completo', password: '123456')
    login_as candidate, scope: :candidate

    visit root_path
    click_on 'Empresas Cadastradas'
    click_on 'big-jobs.com'
    click_on 'Analista Ruby'

    expect(page).to have_content 'Analista Ruby'
    expect(page).to have_content 'Junior'
    expect(page).to have_content 'Trabalhará com desenolvimento de projeto em Ruby'
    expect(page).to have_content 'Certificação em Ruby'
    expect(page).to have_content '22/12/2033'
    expect(page).to have_content 'Candidatar-se'
  
  end
  
  scenario 'success' do
    collaborator = Collaborator.create!(email: 'ivan@big-jobs.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)

    candidate = Candidate.create!(email: 'ivan@email.com', name:'Ivan de Oliveira Junior', cpf:'37355900803',
                                  cell_phone:'987199837', short_biography: 'Formado em Sistemas de Informação',
                                  academic_training: 'Superior Completo', password: '123456')
    login_as candidate, scope: :candidate
    
    visit root_path
    click_on 'Vagas de emprego'
    click_on job.title
    click_on 'Candidatar-se'
    
    expect(page).to have_content 'Analista Ruby'
    expect(page).to have_content 'Junior'
    expect(page).to have_content 'Trabalhará com desenolvimento de projeto em Ruby'
    expect(page).to have_content 'Certificação em Ruby'
    expect(page).to have_content '22/12/2033'
    expect(page).to have_content 'pending'
  end

  scenario 'duplicate application' do
    collaborator = Collaborator.create!(email: 'ivan@big-jobs.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)

    candidate = Candidate.create!(email: 'ivan@email.com', name:'Ivan de Oliveira Junior', cpf:'37355900803',
                                  cell_phone:'987199837', short_biography: 'Formado em Sistemas de Informação',
                                  academic_training: 'Superior Completo', password: '123456')
    login_as candidate, scope: :candidate

    candidate_job = CandidateJob.create!(candidate_id: candidate.id, job_id: job.id)
    
    visit root_path
    click_on 'Vagas de emprego'
    click_on job.title
    
    expect(page).to have_content 'Analista Ruby'
    expect(page).to have_content 'Junior'
    expect(page).to have_content 'Trabalhará com desenolvimento de projeto em Ruby'
    expect(page).to have_content 'Certificação em Ruby'
    expect(page).to have_content '22/12/2033'
    expect(page).to have_content 'pending'
    expect(page).to_not have_content 'Candidatar-se'
  end

end