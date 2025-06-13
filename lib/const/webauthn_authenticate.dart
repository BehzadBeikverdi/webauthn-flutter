const String webauthnAuthenticateJsCode = '''
const isMobile = () => /Android|iPhone|iPad/i.test(navigator.userAgent);

const generateChallenge = () => {
  const challenge = new Uint8Array(32);
  window.crypto.getRandomValues(challenge);
  return challenge;
};

const createCredential = async (options) => {
  const cred = await navigator.credentials.create({ publicKey: options });
  return cred;
};

// ✅ Expose authenticate to Dart or global window
window.authenticate = async () => {
  try {
    const challenge = generateChallenge();

    const options = {
      challenge,
      rp: { name: 'Demo App' },
      user: {
        id: new Uint8Array(16),
        name: 'user@example.com',
        displayName: 'Demo User',
      },
      pubKeyCredParams: [{ alg: -7, type: 'public-key' }],
      authenticatorSelection: {
        authenticatorAttachment: isMobile() ? 'platform' : 'cross-platform',
        userVerification: 'required',
        residentKey: 'discouraged',
      },
      timeout: 60000,
      attestation: 'none',
    };

    const credential = await createCredential(options);
    if (!credential) throw new Error('Fingerprint failed or cancelled');

    return JSON.stringify({
      success: true,
      message: '✅ Fingerprint authentication successful!',
    });
  } catch (err) {
    return JSON.stringify({
      success: false,
      message: `❌ Fingerprint failed: \${err?.message || 'Unknown error'}`,
    });
  }
};
''';
