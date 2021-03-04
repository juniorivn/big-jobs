require 'rails_helper'

feature 'Admin edit company' do
  scenario 'acess page edit job' do
    collaborator = Collaborator.create!(email: 'ivan@email.com', password: '123456', cpf: '26701421687',
                                        name: 'Ivan de Oliveira Junior')
    login_as collaborator, scope: :collaborator
    company =  Company.find_by(id: collaborator.company_id)
    
    visit root_path
    click_on "Acesso empresa"
    click_on company.domain
    
  end

  scenario 'update a company' do
    collaborator = Collaborator.create!(email: 'ivan@sebastianainformaticaltda.com.br', password: '123456', 
                                        cpf: '26701421687', name: 'Ivan de Oliveira Junior')
                                        
    company =  Company.find_by(id: collaborator.company_id)
    login_as collaborator, scope: :collaborator
    
    visit root_path
    click_on "Acesso empresa"
    click_on company.domain
    
    fill_in 'Nome da empresa', with: 'Sebastiana Informática Ltda'
    attach_file 'Logotipo', Rails.root.join('spec', 'support', 'jobs.jpg')
    fill_in 'CNPJ', with: '87966983000101'
    fill_in 'Endereço', with: 'Alameda dos Pintassilgos, 818'
    fill_in 'Bairro', with: 'Jardim Estrela Dalva'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '02364740'
    fill_in 'Facebook', with: 'ironmaiden'
    fill_in 'Instagram', with: 'osbaroesdapisadinhaoficial'
    
    click_on 'Atualizar Empresa'
    
    expect(current_path).to eq(company_path(Company.last))
    expect(page).to have_content ('sebastianainformaticaltda.com.br')
    expect(page).to have_content ('Sebastiana Informática Ltda')
    expect(page).to have_content ('87966983000101')
    expect(page).to have_content ('Alameda dos Pintassilgos, 818')
    expect(page).to have_content ('Jardim Estrela Dalva')
    expect(page).to have_content ('São Paulo')
    expect(page).to have_content ('SP')
    expect(page).to have_content ('02364740')
    expect(page).to have_content ('https://www.facebook.com/ironmaiden')
    expect(page).to have_content ('https://www.instagram.com/osbaroesdapisadinhaoficial')
    expect(page).to have_css('img[src*="jobs.jpg"]')
    
  end

  scenario 'update attributes cannot be blank' do
    collaborator = Collaborator.create!(email: 'ivan@sebastianainformaticaltda.com.br', password: '123456', 
                                        cpf: '26701421687', name: 'Ivan de Oliveira Junior')
                                        
    company =  Company.find_by(id: collaborator.company_id)
    login_as collaborator, scope: :collaborator
    
    visit root_path
    click_on "Acesso empresa"
    click_on company.domain
    
    fill_in 'Nome da empresa', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Bairro', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Facebook', with: ''
    fill_in 'Instagram', with: ''

    click_on 'Atualizar Empresa'

    expect(company.valid?).to eq false
    expect(company.errors.count).to eq 9

  end
end