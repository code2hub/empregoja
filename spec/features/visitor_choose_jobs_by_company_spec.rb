require 'rails_helper'

feature 'Visitor choose jobs by company' do
  scenario 'successfully' do
    company = Company.create(name:     'Campus Code',
                             location: 'São Paulo',
                             mail:     'contato@campuscode.com.br',
                             phone:    '2369-3476')

    job = Job.create(title: 'Vaga de Dev',
               category: 'Desenvolvedor',
               description: 'Dev Junior Rails com ao menos um projeto',
               location: 'São Paulo',
               company_id: company.id)
    visit root_path

    click_on company.name

    expect(page).to have_content company.name, count: 2
    expect(page).to have_content job.title
    expect(page).to have_content job.category
    expect(page).to have_content job.description
    expect(page).to have_content job.location
  end
end
