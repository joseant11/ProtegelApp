class TExceptions {
  final String message;

  const TExceptions([this.message = 'An unknown error occurred']);

  factory TExceptions.code(String code) {
    switch (code) {
      case 'unknown':
        return TExceptions('Unknown error occurred. Please try again.');
      case 'weak-password':
        return TExceptions('Please enter a stronger password.');
      case 'invalid-email':
        return TExceptions('Email is not a valid or badly formatted.');
      case 'email-already-in-use':
        return TExceptions('An account already exists for that email.');
      case 'operation-not-allowed':
        return TExceptions('Operation is not allowed. Please contact support.');
      case 'user-disabled':
        return TExceptions(
            'This user has been disabled. Please contact support for help.');
      default:
        throw TExceptions();
    }
  }
}
