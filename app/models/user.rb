# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  nombre                 :string(255)
#  ap1                    :string(255)
#  ap2                    :string(255)
#  fechaNac               :date
#  padre_id               :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :contacts, :dependent => :destroy

  belongs_to :padre, :class_name => "User" # asi le digo q un User tiene un padre q es un User
  has_many :hijos, :class_name => "User" , :foreign_key => "padre_id" # asi le digo q un User puede tener varios hijos q son users
  # y así puedo hacer querys tipo: @user = User.includes(:padre, :hijos, :contacts).find(params[:id])
  attr_accessible :ap1, :ap2, :fechaNac, :nombre, :padre_id

  validates :nombre, :ap1, :ap2, :fechaNac, presence: true
  validates :nombre, :ap1, :ap2, length: { maximum: 20 }
  validates_uniqueness_of :nombre, scope: [:ap1, :ap2] # xa q no tengan mismo nombre y apellidos !(:nombre + :ap1 + :ap2)

  ################# para validar mediante una función y q t permita hacer cualquier tipo de validación ##################
  #
  # validate :custom_validation
  #
  # def custom_validation
  #   if !nombre.start_with?('J')
  #	 	errors.add(:nombre, 'El nombre no empieza por J')
  #	  end
  # end
  #
  #######################################################################################################################
end
