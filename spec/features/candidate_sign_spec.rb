require 'rails_helper'

feature 'Candidate sign in' do
  scenario 'successfuly' do 
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

    expect(page).to have_content candidate.email
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'

  end

  scenario 'and logout' do
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

    click_on 'Sair'

    within('nav') do
      expect(page).not_to have_link 'Sair'
      expect(page).not_to have_content candidate.email
    end
  end

end