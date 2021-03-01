require 'rails_helper'

feature 'Visitor visit home page' do
  scenario 'successfully' do
    
    visit root_path

    expect(page).to have_content('Big Jobs')
    expect(page).to have_content('Um jeito diferente de procurar seu novo emprego')
    expect(page).to have_content('Visualizar vagas de emprego')
    expect(page).to have_content('Empresas Cadastradas')
    expect(page).to have_content('Acesso empresa')
    expect(page).to have_content('Acesso candidato')

  end
end
