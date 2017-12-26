class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # confirmable - Requires a user to confirm their email address by clicking
         # a link in a confirmation email before they can sign in.
         # lockable - Provides extra security by automatically locking accounts after a
         # given number of failed sign-in attempts.
         # timeoutable —Provides extra security by automatically logging out users who
         # haven’t been active for a given amount of time.
         # omniauthable —Adds support for OmniAuth (https://github.com/intridea/
         # omniauth), which will allow users to authenticate with your app via an external
         # service, such as Facebook or Twitter.
end
