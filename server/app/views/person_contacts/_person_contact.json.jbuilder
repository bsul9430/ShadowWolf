json.id person_contact.id
json.extract! person_contact, :created_at, :updated_at, :personal_email, :personal_phone
json.social do
  json.partial! "app/views/socials/social.json.jbuilder", social: person_contact.social
end if person_contact.social
