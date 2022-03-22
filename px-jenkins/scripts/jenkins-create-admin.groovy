#!groovy

import hudson.security.*
import jenkins.model.*


def instance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
def users = hudsonRealm.getAllUsers()

users_s = users.collect { it.toString() }

// Create the admin user account if it doesn't already exist.

if ("{{ jenkins_admin_username }}" in users_s) {
    println "Admin user already exists - updating password"
    def user = hudson.model.User.get('admin');
    def password = hudson.security.HudsonPrivateSecurityRealm.Details.fromPlainPassword('password')
    user.addProperty(password)
    user.save()
}

else {
    println "--> creating local admin user"

    hudsonRealm.createAccount('admin', 'password')
    instance.setSecurityRealm(hudsonRealm)
     }
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(strategy)
instance.save()

