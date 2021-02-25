require 'rails_helper'

feature 'Admin updates jobs' do
  scenario 'access page edit job' do
    job = Job.create!(title: 'Título da vaga', description: 'Analista Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5')
    
    visit root_path
    click_on "Empresa"
    click_on job.title
    expect(page).to have_link('Editar vaga de emprego')

  end

  scenario 'update a promotion' do
    job = Job.create!(title: 'Título da vaga', description: 'Analista Ruby',
                      salary: '2500', level: 'Junior',
                      requirements: 'Certificação em Ruby', 
                      deadline: '22/12/2033', total: '5')
    
    visit root_path
    click_on "Empresa"
    click_on job.title
    click_on "Editar vaga de emprego"

    fill_in 'Título da vaga', with: 'Analista Java'
    fill_in 'Descrição', with: 'Trabalhará com desenolvimento de projeto em Java'
    fill_in 'Faixa salarial', with: '4500.00'
    select 'Pleno'
    fill_in 'Requisitos', with: 'Certificação em Java'
    fill_in 'Data limite', with: '22/12/2025'
    fill_in 'Total de vagas', with: '3'
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