require 'rails_helper'

feature 'Collaborator updates jobs' do
  scenario 'access page edit job' do
    candidate = Candidate.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                  name: 'Ivan de Oliveira Junior', cell_phone: '98199837',
                                  short_biography: ' Histórico Profisional', academic_training: 'Formado em SI')
    login_as candidate, scope: :candidate

    visit root_path
    click_on "Acesso candidato"
    expect(page).to have_link('Editar perfil')

  end

  scenario 'update a candidate' do
    candidate = Candidate.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                  name: 'Ivan de Oliveira Junior', cell_phone: '98199837',
                                  short_biography: 'Histórico Profisional', academic_training: 'Formado em SI')
    login_as candidate, scope: :candidate
  
    visit root_path
    click_on "Acesso candidato"
    click_on "Editar perfil"

    fill_in 'E-mail', with: 'ivan@gmail.com'
    fill_in 'Nome', with: 'Ivan Barbosa Andreazzi'
    fill_in 'CPF', with: '37355900803'
    fill_in 'Celular', with: '98199847'
    fill_in 'Biografia resumida', with: 'Histórico Profisional 2'
    fill_in 'Formação academica', with: 'Formado em CC'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Atualizar'

    expect(current_path).to eq(candidate_path(Candidate.last))
    expect(page).to have_content ('Ivan Barbosa Andreazzi')
    expect(page).to have_content ('ivan@gmail.com')
    expect(page).to have_content ('37355900803')
    expect(page).to have_content ('98199847')
    expect(page).to have_content ('Histórico Profisional 2')
    expect(page).to have_content ('Formado em CC')

  end

  scenario 'update attributes cannot be blank' do
    candidate = Candidate.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                  name: 'Ivan de Oliveira Junior', cell_phone: '98199837',
                                  short_biography: 'Histórico Profisional', academic_training: 'Formado em SI')
    login_as candidate, scope: :candidate
  
    visit root_path
    click_on "Acesso candidato"
    click_on "Editar perfil"

    fill_in 'E-mail', with: ''
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Celular', with: ''
    fill_in 'Biografia resumida', with: ''
    fill_in 'Formação academica', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''
    
    click_on 'Atualizar'

    expect(page).to have_content('Não foi possível editar vaga de emprego')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Celular não pode ficar em branco')
    expect(page).to have_content('Biografia resumida não pode ficar em branco')
    expect(page).to have_content('Formação academica não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')

  end
end