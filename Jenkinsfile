node {

    stage 'Checkout'
    checkout scm

    stage 'Update fastlane'
    sh 'fastlane update'

    stage 'Test'
    sh 'fastlane test'

    stage 'Build'
    sh 'fastlane build'

    if (env.BRANCH_NAME == 'master') {
      stage 'Increase Version'
      sh 'fastlane increase'

    }
}
