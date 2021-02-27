require 'rails_helper'

feature 'Admin updates jobs' do
  scenario 'access page edit job' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    login_as collaborator, scope: :collaborator
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5')
    
    visit root_path
    click_on "Acesso empresa"
    click_on "Vagas de emprego cadastradas"
    click_on job.title
    expect(page).to have_link('Editar vaga de emprego')

  end

  scenario 'update a promotion' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    login_as collaborator, scope: :collaborator
    job = Job.create!(title: 'Analista Ruby', description: ' Trabalhará com desenolvimento de projeto em Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5')

    
    visit root_path
    click_on "Acesso empresa"
    click_on "Vagas de emprego cadastradas"
    click_on job.title
    click_on "Editar vaga de emprego"

    fill_in 'Título da vaga', with: 'Analista Java'
    fill_in 'Descrição', with: 'Trabalhará com desenolvimento de projeto em Java'
    fill_in 'Faixa salarial', with: '4500.00'
    select 'Pleno'
    fill_in 'Requisitos', with: 'Certificação em Java'
    fill_in 'Data limite', with: '22/12/2025'
    fill_in 'Total de posições', with: '3'
    click_on 'Atualizar Vaga de Emprego'

    expect(current_path).to eq(job_path(Job.last))
    expect(page).to have_content ('Analista Java')
    expect(page).to have_content ('Trabalhará com desenolvimento de projeto em Java')
    expect(page).to have_content ('R$ 4.500,00')
    expect(page).to have_content ('Pleno')
    expect(page).to have_content ('Certificação em Java')
    expect(page).to have_content ('22/12/2025')
    expect(page).to have_content ('3')

  end

end