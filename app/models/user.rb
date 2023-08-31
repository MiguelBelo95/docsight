class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :qualifications
  has_many :procedures
  has_many :doctors_locations, dependent: :destroy
  has_many :locations, through: :doctors_locations
  has_many :appointments_as_patient, class_name: "Appointment", foreign_key: :patient_id
  has_many :appointments_as_doctor, class_name: "Appointment", foreign_key: :doctor_id
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :date_of_birth, presence: true, if: :user_is_patient?
  validates :gender, presence: true, if: :user_is_patient?
  validates :role, presence: true
  validates :past_interventions, presence: true, if: :user_is_patient?

  private

  def user_is_patient?
    role == "patient"
  end

  def user_is_doctor?
    role == "doctor"
  end
end
