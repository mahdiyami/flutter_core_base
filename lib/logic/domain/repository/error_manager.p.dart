part of "repository.dart";


extension ErrorManager on AppException {
 FailureParams toFailureParams() {
    if(exception is Exception) {
      return FailureParams(
        message: exception.toString(),
      );
    }
    if(exception is FailureParams) {
      return exception;
    }
    return const FailureParams(
      message: "Unknown error",
    );
  }
}