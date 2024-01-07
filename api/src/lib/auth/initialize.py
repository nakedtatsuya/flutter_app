from authlib.integrations.starlette_client import OAuth

from dotenv import load_dotenv
import os

load_dotenv()

client_id = os.getenv("AUTH_CLIENT_ID")
client_secret = os.getenv("AUTH_CLIENT_SECRET")


def init_google_oauth() -> OAuth:
    oauth = OAuth()
    oauth.register(
        name="google",
        server_metadata_url="https://accounts.google.com/.well-known/openid-configuration",
        client_kwargs={"scope": "openid email profile"},
        client_id=client_id,
        client_secret=client_secret,
        # **conf,
    )

    return oauth
