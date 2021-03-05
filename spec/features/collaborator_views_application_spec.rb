require 'rails_helper'

feature 'apply for a job' do
  scenario 'approved candidate' do
    collaborator = Collaborator.create!(email: 'ivan@big-jobs.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    login_as collaborator, scope: :collaborator
    
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)

    candidate = Candidate.create!(email: 'ivan@email.com', name:'Ivan de Oliveira Junior', cpf:'37355900803',
                                  cell_phone:'987199837', short_biography: 'Formado em Sistemas de Informação',
                                  academic_training: 'Superior Completo', password: '123456')

    
    candidate_job = CandidateJob.create!(candidate_id: candidate.id, job_id: job.id)
    
    visit  root_path
    click_on 'Acesso empresa'
    click_on 'Vagas de emprego cadastradas'
     
    click_on job.title
    click_on candidate.email
    click_on 'Aprovar candidato'

    fill_in 'Feedback', with: 'Você foi aprovado para a vaga de Analista Ruby'
    click_on 'Atualizar'

    expect(current_path).to eq(candidate_path(Candidate.last))
    expect(page).to have_content 'Ivan de Oliveira Junior'
    expect(page).to have_content '987199837'
    expect(page).to have_content 'Formado em Sistemas de Informação'
    expect(page).to have_content 'approved'
    expect(page).to have_content 'Você foi aprovado para a vaga de Analista Ruby'
    expect(page).not_to have_content 'Aceitar'
   
    
  end

  scenario 'failed candidate' do
    collaborator = Collaborator.create!(email: 'ivan@big-jobs.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    
    login_as collaborator, scope: :collaborator

    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)

    candidate = Candidate.create!(email: 'ivan@email.com', name:'Ivan de Oliveira Junior', cpf:'37355900803',
                                  cell_phone:'987199837', short_biography: 'Formado em Sistemas de Informação',
                                  academic_training: 'Formado em Sistemas de Informação', password: '123456')
    
    candidate_job = CandidateJob.create!(candidate_id: candidate.id, job_id: job.id)


    visit root_path
    click_on 'Acesso empresa'
    click_on 'Vagas de emprego cadastradas'
    click_on job.title
    click_on candidate.email
    click_on 'Recusar candidato'

    fill_in 'Feedback', with: 'Você foi não aprovado para a vaga de Analista Ruby'
    click_on 'Atualizar'

    expect(current_path).to eq(candidate_path(Candidate.last))
    expect(page).to have_content 'Ivan de Oliveira Junior'
    expect(page).to have_content '987199837'
    expect(page).to have_content 'Formado em Sistemas de Informação'
    expect(page).to have_content 'disapproved'
    expect(page).to have_content 'Você foi não aprovado para a vaga de Analista Ruby'
    expect(page).not_to have_content 'Recusar'
    
  end
end