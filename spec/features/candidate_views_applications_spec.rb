require 'rails_helper'

feature 'view application' do
  scenario 'candidate accepts job' do
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

    candidate_job = CandidateJob.create!(candidate_id: candidate.id, job_id: job.id, status_candidate: 'approved')

    visit root_path
    click_on 'Vagas de emprego'
    click_on 'Analista Ruby'
    click_on 'Aceitar'
    fill_in 'Feedback', with: 'Aceito a vaga para inicio em 01/04/2021'
    click_on 'Atualizar'

    expect(current_path).to eq(job_path(Job.last))
    expect(page).to have_content 'Analista Ruby'
    expect(page).to have_content 'R$ 2.500,00'
    expect(page).to have_content 'Certificação em Ruby'
    expect(page).to have_content '22/12/2033'
    expect(page).to have_content 'Você accepted a vaga'
    expect(page).not_to have_content 'Aceitar'
    
  end

  scenario 'failed candidate' do
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

    candidate_job = CandidateJob.create!(candidate_id: candidate.id, job_id: job.id, status_candidate: 'approved')

    visit root_path
    click_on 'Vagas de emprego'
    click_on 'Analista Ruby'
    click_on 'Recusar'
    fill_in 'Feedback', with: 'Terei que recusar, por conta de problemas famaliares'
    click_on 'Atualizar'

    expect(current_path).to eq(job_path(Job.last))
    expect(page).to have_content 'Analista Ruby'
    expect(page).to have_content 'R$ 2.500,00'
    expect(page).to have_content 'Certificação em Ruby'
    expect(page).to have_content '22/12/2033'
    expect(page).to have_content 'Você declined a vaga'
    expect(page).not_to have_content 'Recusar'
    
    
  end
end