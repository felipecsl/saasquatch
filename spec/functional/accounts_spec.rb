require 'spec_helper'
require 'rubygems'
require 'watir-webdriver'

describe Account do
  before(:all) do
    Plan.create(name: "Basic", price: 10)
    @b = Watir::Browser.new :firefox
  end

  it 'should create and log in to a new account' do
    @b.goto 'http://localhost:3000/'
    @b.link(text: "Basic - R$ 10.0").click
    @b.text_field(name: 'account[name]').set 'International Business Machines'
    @b.text_field(name: 'account[domain]').set 'ibm'
    @b.text_field(name: 'account[users_attributes][0][name]').set 'Felipe Lima'
    @b.text_field(name: 'account[users_attributes][0][email]').set 'felipe.lima@gmail.com'
    @b.text_field(name: 'account[users_attributes][0][password]').set '123456'
    @b.text_field(name: 'account[users_attributes][0][password_confirmation]').set '123456'
    @b.button(value: "Criar minha conta").click
    @b.p(class: "notice").text.should == "Sua conta foi criada com sucesso!"
    @b.link(text: "Entrar").click
    @b.text_field(name: 'user[email]').set 'felipe.lima@gmail.com'
    @b.text_field(name: 'user[password]').set '123456'
    @b.button(text: "Entrar").click
    @b.p(class: "notice").text.should == "Login efetuado com sucesso."
    @b.h2.text.should == "Bem vindo, Felipe Lima"
    @b.h1.text.should == "International Business Machines"
  end

  after(:all) { @b.quit }
end
