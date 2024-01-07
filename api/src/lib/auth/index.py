import firebase_admin
from firebase_admin import auth

# Initialize the Firebase Admin SDK
firebase_admin.initialize_app()

def login(email, password):
    try:
        # Sign in the user with email and password
        user = auth.get_user_by_email(email)
        return user.uid
    except auth.AuthError as e:
        # Handle authentication errors
        print(f"Login failed: {e}")
        return None
