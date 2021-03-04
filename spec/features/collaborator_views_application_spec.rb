require 'rails_helper'

feature 'apply for a job' do
  scenario 'approved candidate' do
    collaborator = Collaborator.create!(email: 'ivan@big-jobs.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5', company_id: collaborator.company_id)

    candidate = Candidate.create!(email: 'ivan@email.com', name:'Ivan de Oliveira Junior', cpf:'37355900803',
    cell_phone:'987199837', short_biography: 'Formado em Sistemas de Informação',
    academic_training: 'Superior Completo', password: '123456')
    visit root_path
    click_on 'Acesso candidato'
    within('form') do 
      fill_in 'E-mail', with: candidate.email
      fill_in 'Senha', with: '123456'

      click_on 'Entrar'
    end

    click_on 'Vagas de emprego'
    click_on 'Analista Ruby'
    click_on 'Candidatar-se'
    click_on 'Sair'

    click_on 'Acesso empresa'
    within('form') do 
      fill_in 'E-mail', with: collaborator.email
      fill_in 'Senha', with: '123456'

      click_on 'Entrar'
    end

    click_on 'Vagas de emprego cadastradas'
    click_on job.title
    click_on candidate.email
    click_on 'Aprovar candidato'

    fill_in 'Feedback', with: 'Você foi aprovado para a vaga de Analista Ruby'
    click_on 'Atualizar'
    
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
    visit root_path
    click_on 'Acesso candidato'
    within('form') do 
      fill_in 'E-mail', with: candidate.email
      fill_in 'Senha', with: '123456'

      click_on 'Entrar'
    end

    click_on 'Vagas de emprego'
    click_on 'Analista Ruby'
    click_on 'Candidatar-se'
    click_on 'Sair'

    click_on 'Acesso empresa'
    within('form') do 
      fill_in 'E-mail', with: collaborator.email
      fill_in 'Senha', with: '123456'

      click_on 'Entrar'
    end

    click_on 'Vagas de emprego cadastradas'
    click_on job.title
    click_on candidate.email
    click_on 'Recusar candidato'

    fill_in 'Feedback', with: 'Você foi não aprovado para a vaga de Analista Ruby'
    click_on 'Atualizar'
    
  end
end