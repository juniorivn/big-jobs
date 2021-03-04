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
    visit root_path
    click_on 'Acesso candidato'
    click_on 'Minhas vagas'
    click_on job.title

    expect(page).to have_content 'Analista Ruby'
    expect(page).to have_content ('R$ 2.500,00')
    expect(page).to have_content ('Junior')
    expect(page).to have_content ('Certificação em Ruby')

  end
end