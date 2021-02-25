require 'rails_helper'

feature 'Admin registers job vacancy' do
  scenario 'from index page' do
    visit root_path
    click_on 'Empresa'

    expect(page).to have_link('Cadastrar uma vaga de emprego',
                              href: new_job_path)
    
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Empresa'
    click_on 'Cadastrar uma vaga de emprego'
    
    fill_in 'Título da vaga', with: 'Analista Ruby'
    fill_in 'Descrição', with: 'Trabalhará com desenolvimento de projeto em Ruby'
    fill_in 'Faixa salarial', with: '2500.00'
    select 'Junior'
    fill_in 'Requisitos', with: 'Certificação em Ruby'
    fill_in 'Data limite', with: '22/12/2033'
    fill_in 'Total de vagas', with: '5'
    click_on 'Criar Vaga de Emprego'

    expect(current_path).to eq(job_path(Job.last))
    expect(page).to have_content ('Analista Ruby')
    expect(page).to have_content ('Trabalhará com desenolvimento de projeto em Ruby')
    expect(page).to have_content ('R$ 2.500,00')
    expect(page).to have_content ('Junior')
    expect(page).to have_content ('Certificação em Ruby')
    expect(page).to have_content ('22/12/2033')
    expect(page).to have_content ('5')

    expect(page).to have_link('Voltar')

  end

end