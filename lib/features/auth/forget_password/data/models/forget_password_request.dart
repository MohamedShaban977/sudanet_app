class ForgetPasswordRequest {
  ForgetPasswordRequest({

    required this.email,

  });


  String email;


  Map<String, dynamic> toJson() => {

        "email": email,

      };
}
