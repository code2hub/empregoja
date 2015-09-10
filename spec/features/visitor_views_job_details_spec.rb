require 'rails_helper'

feature 'Visitor visits job details' do
  scenario 'successfully' do
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
    click_on 'Ver mais'
    expect(page).to have_content 'Vaga de Dev'
    expect(page).to have_content 'Desenvolvedor'
    expect(page).to have_content 'Campus Code'
    expect(page).to have_content 'Dev Junior Rails com ao menos um projeto'
    expect(page).to have_content 'São Paulo'
  end
end
