require 'rails_helper'

feature 'User creates a new job' do

  scenario 'successfully' do
    company = Company.create(name:     'Campus Code',
                          location: 'São Paulo',
                          mail:     'contato@campuscode.com.br',
                          phone:    '2369-3476')

    job = Job.new(title:    'Dev Master',
                  location: 'Rio de Janeiro',
                  category: 'Desenvolvedor',
                  description: 'Vaga para Dev Master para o Bootcamp Rails',
                  expiration_date: Date.tomorrow)

    visit new_job_path
    fill_in 'Title',       with: job.title
    fill_in 'Location',    with: job.location
    fill_in 'Category',    with: job.category
    select  'Campus Code'
    fill_in 'Description', with: job.description
    fill_in 'Expiration Date', with: job.expiration_date

    click_on 'Criar Vaga'

    expect(page).to have_content 'Dev Master'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content 'Desenvolvedor'
    expect(page).to have_content 'Campus Code'
    expect(page).to have_content 'Vaga para Dev Master para o Bootcamp Rails'
  end

  scenario 'featured job' do
    company = Company.create(name:     'Campus Code',
                            location: 'São Paulo',
                            mail:     'contato@campuscode.com.br',
                            phone:    '2369-3476')

    job = Job.new(title:    'Dev Master',
                  location: 'Rio de Janeiro',
                  category: 'Desenvolvedor',
                  description: 'Vaga para Dev Master para o Bootcamp Rails',
                  expiration_date: Date.tomorrow)

    visit new_job_path
    fill_in 'Title',       with: job.title
    fill_in 'Location',    with: job.location
    fill_in 'Category',    with: job.category
    select  'Campus Code'
    fill_in 'Description', with: job.description
    fill_in 'Expiration Date', with: job.expiration_date
    check   'Featured'

    click_on 'Criar Vaga'

    expect(page).to have_content 'Dev Master'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content 'Desenvolvedor'
    expect(page).to have_content 'Campus Code'
    expect(page).to have_content 'Vaga para Dev Master para o Bootcamp Rails'
    expect(page).to have_content 'Vaga em Destaque'
  end

  scenario 'invalid' do
    visit new_job_path

    click_on 'Criar Vaga'

    expect(page).to have_content 'Warning! All fields are mandatory.'

  end

  scenario 'expiration date' do
    company = Company.create(name:     'Campus Code',
                            location: 'São Paulo',
                            mail:     'contato@campuscode.com.br',
                            phone:    '2369-3476')

    job = Job.new(title:    'Dev Master',
                  location: 'Rio de Janeiro',
                  category: 'Desenvolvedor',
                  description: 'Vaga para Dev Master para o Bootcamp Rails',
                  expiration_date: Date.yesterday)

    visit new_job_path
    fill_in 'Title',       with: job.title
    fill_in 'Location',    with: job.location
    fill_in 'Category',    with: job.category
    select  'Campus Code'
    fill_in 'Description', with: job.description
    fill_in 'Expiration Date', with: job.expiration_date
    check   'Featured'

    click_on 'Criar Vaga'

    expect(page).to have_content 'Vaga expirada'
  end

end
