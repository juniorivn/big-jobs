require 'rails_helper'

feature 'Collaborator sign in' do
  scenario 'successfuly' do 
    collaborator = Collaborator.create!(email: 'ivan@email.com', name:'Ivan de Oliveira Junior',
                                        cpf:'37355900803', password: '123456')

    visit root_path
    click_on 'Acesso empresa'
    within('form') do 
      fill_in 'E-mail', with: collaborator.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    expect(page).to have_content collaborator.email
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'

  end

  scenario 'and logout' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', name:'Ivan de Oliveira Junior',
                                        cpf:'37355900803', password: '123456')
    
    visit root_path
    click_on 'Acesso empresa'
    within('form') do
      fill_in 'E-mail', with: collaborator.email
      fill_in 'Senha', with: '123456'
      
      click_on 'Entrar'
    end

    click_on 'Sair'

    within('nav') do
      expect(page).not_to have_link 'Sair'
      expect(page).not_to have_content collaborator.email
    end
  end

end