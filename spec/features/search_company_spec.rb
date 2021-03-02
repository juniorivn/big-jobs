require 'rails_helper'

feature 'Search company' do
  scenario 'successfully' do
    collaborator = Collaborator.create!(email: 'ivan@sebastianainformaticaltda.com.br', password: '123456', 
                                        cpf: '26701421687', name: 'Ivan de Oliveira Junior')
                                        
    company =  Company.find_by(id: collaborator.company_id)
    login_as collaborator, scope: :collaborator
    visit root_path
    click_on "Acesso empresa"
    click_on company.domain
    
    fill_in 'Nome da empresa', with: 'Sebastiana Informática Ltda'
    
    fill_in 'CNPJ', with: '87966983000101'
    fill_in 'Endereço', with: 'Alameda dos Pintassilgos, 818'
    fill_in 'Bairro', with: 'Jardim Estrela Dalva'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '02364740'
    
    click_on 'Atualizar Empresa'
    click_on 'Sair'
    visit root_path
    click_on 'Empresas Cadastradas'
    fill_in 'Buscar', with: 'Sebastiana'
    click_on 'Pesquisar'    
    expect(current_path).to eq search_company_path
    expect(page).to have_content ('sebastianainformaticaltda.com.br')
    expect(page).to have_content ('Sebastiana Informática Ltda')
    expect(page).to have_content ('Alameda dos Pintassilgos, 818')
    expect(page).to have_content ('São Paulo')
    expect(page).to have_content ('SP')
  end

  scenario 'search for nonexistent company' do
    collaborator = Collaborator.create!(email: 'ivan@sebastianainformaticaltda.com.br', password: '123456', 
                                        cpf: '26701421687', name: 'Ivan de Oliveira Junior')
            
    company =  Company.find_by(id: collaborator.company_id)
    login_as collaborator, scope: :collaborator
    visit root_path
    click_on "Acesso empresa"
    click_on company.domain
      
    fill_in 'Nome da empresa', with: 'Sebastiana Informática Ltda'
      
    fill_in 'CNPJ', with: '87966983000101'
    fill_in 'Endereço', with: 'Alameda dos Pintassilgos, 818'
    fill_in 'Bairro', with: 'Jardim Estrela Dalva'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '02364740'
      
    click_on 'Atualizar Empresa'
    click_on 'Sair'
    visit root_path
    click_on 'Empresas Cadastradas'
    fill_in 'Buscar', with: 'Joaquim'
    click_on 'Pesquisar'    
    expect(current_path).to eq search_company_path

    expect(page).to have_content('Nenhuma empresa encontrada')
    expect(page).not_to have_content('Joaquim')
              
  end
end