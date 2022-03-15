class GeneralException {
  final String? message;
  final String? stackTrace;

  GeneralException(this.message, {this.stackTrace});
}

class UserNotFoundException {}

class InvalidCredentialException {}

class UserAlreadyRegistered {}
