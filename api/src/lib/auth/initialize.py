from starlette.middleware.sessions import SessionMiddleware
from authlib.integrations.starlette_client import OAuth
from starlette.config import Config


def init_google_oauth():
    oauth = OAuth()
    conf = {
        "client_id": "",
        "client_secret": "",
        "authorize_url": "https://accounts.google.com/o/oauth2/auth",
        "authorize_params": None,
        "access_token_url": "https://accounts.google.com/o/oauth2/token",
        "access_token_params": None,
        "refresh_token_url": None,
        "redirect_uri": "http://localhost:8000/auth/google",
        "client_kwargs": {"scope": "openid email profile"},
    }
    oauth.register(
        name="google",
        server_metadata_url="https://accounts.google.com/.well-known/openid-configuration",
        **conf,
    )

    return oauth
