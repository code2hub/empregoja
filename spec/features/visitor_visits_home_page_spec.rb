require 'rails_helper'

feature 'Visitor visits Emprego Ja home page' do
  scenario 'successfully' do
    visit root_path
    expect(page).to have_content('Emprego Já')
  end

  scenario 'and see jobs' do
    company = Company.create(name:     'Campus Code',
                             location: 'São Paulo',
                             mail:     'contato@campuscode.com.br',
                             phone:    '2369-3476')

    Job.create(title: 'Vaga de Dev',
               category: 'Desenvolvedor',
               description: 'Dev Junior Rails com ao menos um projeto',
               location: 'São Paulo',
               company_id: company.id)
    visit root_path
    expect(page).to have_content('Vaga de Dev')
    expect(page).to have_content('Campus Code')
    expect(page).to have_content('São Paulo')
  end

  scenario 'and does not see jobs after expiration date' do
    company = Company.create(name:     'Campus Code',
                             location: 'São Paulo',
                             mail:     'contato@campuscode.com.br',
                             phone:    '2369-3476')

    Job.create(title: 'Vaga de Dev',
               category: 'Desenvolvedor',
               description: 'Dev Junior Rails com ao menos um projeto',
               location: 'São Paulo',
               expiration_date: Date.yesterday,
               company_id: company.id)

    visit root_path
    expect(page).not_to have_content('Vaga de Dev')
    expect(page).not_to have_content('Campus Code')
    expect(page).not_to have_content('São Paulo')
  end
end
