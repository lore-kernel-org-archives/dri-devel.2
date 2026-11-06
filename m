Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E87606A31B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=TCrjGDzV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1C710E99F;
	Fri,  6 Nov 2026 01:14:03 +0000 (UTC)
Received: from sonic310-25.consmr.mail.ne1.yahoo.com
 (sonic310-25.consmr.mail.ne1.yahoo.com [66.163.186.206])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490E410E73D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 01:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1793927635; bh=BsO+qH80UBP80w9FAgGCTZElzsE+DcVDPsTQCxrZsqM=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=TCrjGDzVsioGqZpITB8Z4ox0h6FYcHzvRgVZFaAuEjtgZsMcq+V8R/49L5/esj1DMpjPbWnRvkXMGaOtcADoLaJs6ySGfGsRtyEzDsNLXngS3h3dt9O/aMkdgRML0MNw6nAXY2bX8nizeOBAhffOXfRF+1lQlVS1Z3XGCkUH+9ke1ksYvH7gO9COhDwHJfD5NAFGX/ivPMJdKjLvdvfqD++dREOuEMDWNiKWMH5X79QRHeBb6rba7ox0vVXpTfKDILZFezF96tTgEwO+jgy7Vz6Lq0mNSSK8YmYwMRUvs93pPwkclEKk4u4oYdEZT1hGPYx55kYimsy/wPs+HVoDKA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1793927635; bh=x0Vwk/Rti+IVIRNj5hrD9vedZhd7KychqYCHd+sPOB2=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=Cvnc3zLUT/X5piBi3IVRUghD6E/I6559XcOAf/OaxbgCmggqlq2z1RSl1m3W+jMcV5DRH1MN4SZn/sHVyTZLFOtxjKizNMhZv76KFs/zLi/dPC/jIqN50IJviEm8MJXoKkF5j/QeFwfEzt5uIFuDiN8AL/9ik/5EOrY9y7SSSWvCFqEUToH1wPR5EgkrZLePyFfCvYWV8/qD0u0ThnJcLhTg1ajbYcL3OC24Cj5iOf84tJA8p9BoDtF6JvgG4PYrWKO5O/zlt9DH67ZlVDSSLaXI/8X6S/oPgQLG+y61Er04IcViU3RRoEqAJM264ROyD3TYR0Uo4B7GN+rohP1sGQ==
X-YMail-OSG: wti1Lk0VM1mUjthgmCj95Wt_zZXw6frDz7xr880JjuJk3KXIFeNGRItEktDuh7v
 _zsm3yg8RE17Ege1z35cGUROoUoHC7EZZOJAdLa7yHXjpIw6UVYakz5wpTRhtvfrw.PD51OnSVLQ
 Mf31hlnIPuxuTGHO.25j77ewgl3_4ZfCXrCaTa4Ch4mu_gUyEBjUvvPaw6X2xRSckgDedNgD.osX
 7gJq9TbR0.vFZQtqEPme8qnfrTqDJEVvyw18vi4Zlm5rIX1lPLT48GtVPrkK8u_88RGH.Vxd6sKa
 ll7Jbkw0HmLUClkCeDkT94Jp8RTlrQc8uDPHnJtrDDysdg2jJYBgq44JyKET1Ky66tKZsJ1eIEyu
 aIy9gn12rZlxizwMAM2se138dqbFtu4EyDP0_UofR_z8GWu7uF2B.fkXW4zZxfJx5xM.KnVw6kVa
 4cnj_MphvE.K5qApjCImdzEzCqXGNjxJLjeklue1QaT1jVXVfGIMRv.OPg9JFZvPpe4TEmEFkqwq
 8eb4qQeSQTxb6rPJ6LwbUJCCwtLfTuhLpgJA__kobOY6ZXjowKIbTDY9SJURV8.PYwSRiS6OtkvS
 snfPY0v6.HVh0CPVoT_Bi3KKBpqlY9LWK25uiPwxcOgDyfuSRM6fj7kjxSCeMfCqSvCLYc_6lEhy
 Rzt5IT80VdIPFm3_GHYAOjn5MprY4ZpxR82WiGBojt5.24LIHXmxFNh6L9.c2C4b3JvSy59NKNUf
 bg2LybpabMB6kkRSCiYCm.EA64no6Azz9nZoSFGODrCZ8Y7FAzsLhEVxNStuvFN0617wswcQAHen
 AXARu9SLk6v_iwrkRW7sSVKQtIrQE1z0TieUJVQjT81pkDobc0XxROqsrhR31h4b4RhGNxWOIaf4
 nc.BCSS7x7yp8Nci5t1d8IouAn5uWMBExWo_7cX8PhSeXpxbGhx6VcfnZK0kVsVyVZJtDgsFlozW
 zlWJVEV5Q8SkE9NAqIjIqN9FWeuCf8yWtRMcOIaRCLGkXczZ_YGzTxQWfAI5FfS_ZiRWIOVgVM64
 zM0ybjgK_Tw9Sww02sl5mSYTeHCiXQVngURWyu2zdWXS7duslILXWJk1kFnEFoZrAUDlQAs34LQy
 Ek3j_WSMBZKA2DbxU44LCWD9tB.eEPGOIoHqVm5NrLJKTlBL26JaCSKgkz0M_D4jmr8esdjpmXPN
 U5K5Ywd8fO99F65XokPwZ6z3f8JICC.GJuh6FXED2BIB7yfGIMI2AeAwuue2m4ZnyclCRrv0X21m
 G9U81.KM2NJH9hSfsPlmktqO2.HIDkIANWBX_GV3M5hNrEoWTE4hWFpEQrBwDb144zmC9dTfCryX
 mmCRrQfvS_9Uf6rcXGv1sbXQchcTWQIcv5b3e4uxXObbc.522BG2KcVBs_7xd6AwPTcO_.bAkc9w
 _TEk6H3PyUAT2TjXpUpLyDoXEthcp67OuNN_7oBs6D7qezU82SqSbRntWZqRdauZZL.5OWkhihiy
 FXFLBb0xosga_V9yDt8NjVFnYo0nqwdO_B8oHzFna9sW8FPaacLFQ7u9_YLBFttSeDGireonwwar
 wgQVbv5GEehj0VY.rpQQfO_SORwW2XOjPkbv3t8KLcnpu_.u9QLo.WBgWdFvkUNrzt3Yyim_2_Ay
 6S_lhxQbQTkbKJqexEc0Fb_MuDcGNNiHCYfZMIjmN7WR0G1ktPd3qhn9ALg957jUezj2LAEDKe9M
 VLJeGpIJNqQPG2lhEg1I5sCR03iWKJbmJ302ic4gLtytpLfUHKKx51fwr3RWlqUMMBrinVBBuevz
 IPbgr8uGV1cTrY2R37B5NmSW1bmVjyUxwocajRWWUNVtkA9qzbKxTopJOZdagrYukmtBbXEGYO5r
 ZVAmmTwjhANJIz96CL2mhA5UGmHZD3uEDFQYedhh0Bb2efHHTdez65bYXIR1VBkwui_nEDcPDmSb
 GxRhVycCzOp36218pJPLqKv.wd64FWjlhAdgnCw2tLPsuFlb3vC.jyxpkG4c7BQKM3iksEU1.74w
 c6pQKJpi26iYOpT8sLAHq_f3FVi2KCFujVZjAesPA5OQ5Q2SW0LXdrtDPxISKlMcZeg0851i3okG
 39q2Ldb4ynkI0zS506NcziC4ApjFDo60zba3nETTYaNeiBI8aLe_70nt40eL5yWfIfj_19l4mGT2
 UFNzGbZa9c7.qM15rnq2jxr.Nqq88XZ.baipK_cs_omvAfmtKMRcFhp4U68awhvxfCzp_.SxaN3k
 c8L8Igaq3gwSZowGFJb4NaVEt.B9cRqLFdhYfgrULG9hRiYPUSmdJA2vt3S_AAG2auIDRow--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 12d0e401-db15-40b9-8ffd-e7b431ae00d6
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Nov 2026 01:13:55 +0000
Received: by hermes--production-ir2-5dd9bf4598-98szj (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 453e9013f37e4c5133eeadd7c4fdf44e; 
 Fri, 06 Nov 2026 01:13:51 +0000 (UTC)
Message-ID: <2018f3736c6fa8ea78f9d1b640061bcc9dcf2342.camel@aol.com>
Subject: Re: [PATCH RESEND 13/83] drm/gud: Switch to
 drm_mode_config_create_initial_state
From: Ruben Wauters <rubenru09@aol.com>
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter
 <simona@ffwll.ch>, Thomas Zimmermann	 <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Date: Fri, 06 Nov 2026 01:13:39 +0000
In-Reply-To: <20261105-drm-no-more-config-reset-v1-13-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-13-1f58d1e33380@kernel.org>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 SWKQ8KA==
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-C29MEZrUalOPg7SmPEW5"
User-Agent: Evolution 3.60.2 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.26943
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-C29MEZrUalOPg7SmPEW5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-11-05 at 16:29 +0100, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>=20
> Since the two roles need different behaviors (notably for objects
> like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>=20
> Switch to drm_mode_config_create_initial_state().
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Ruben Wauters <rubenru09@aol.com>
> ---
> Cc: Ruben Wauters <rubenru09@aol.com>
> ---
> =C2=A0drivers/gpu/drm/gud/gud_drv.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/gud/gud_drv.c
> b/drivers/gpu/drm/gud/gud_drv.c
> index 680447f426f3..9ba6d8b94023 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
> @@ -641,5 +641,7 @@ static int gud_probe(struct usb_interface *intf,
> const struct usb_device_id *id)
> =C2=A0	}
> =C2=A0
> -	drm_mode_config_reset(drm);
> +	ret =3D drm_mode_config_create_initial_state(drm);
> +	if (ret)
> +		return ret;
> =C2=A0	drm_kms_helper_poll_init(drm);
> =C2=A0

--=-C29MEZrUalOPg7SmPEW5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQLCBAABCgCsFiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmrtKcMbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRERTg2Q0QzNUQzRDBGNTVFNDI0MjJE
OThEMjdFNTBDMDUwQUUwQ0UxEhxydWJlbnJ1MDlAYW9sLmNvbQAKCRDSflDAUK4M
4XLZEACW1W1uXb3jckEynNLw/9mmxs+aKE7U81Om0WyPRnN2qg6O03+lDQNqEOnc
wi2Re8/BMOlmeqz7YR0GvhaSwr75/9jCYS3HW4bZmEzljBz9ZcdasrPhJxW4RhRo
BIL36wecJS8uwvGRpE4h7uXiMM8AI+BHI2hFTHK/lD1jhL2eqBEqG8QKAkYV3YPL
v+xt9WwlyDf2CBPzZ6nieIh4qHD6qCqoNFP4zOXr6aXJ67XYP1a1crzsShPngMYC
S5FvETOc8s4xpM1IKfksJ/+0huhTNG/U+Zmr+4WzUw1v9BWzFocDQG9kbsT+3NZD
uce+BpFQm/UMrEw7HV5fCYhT5h9iaCR7k9LGCX0ihP6enIB6M4lhi0I5Ih31U3Ty
pMfminfEXjkhYlc/KV47e+8Sk6cePhU477idK0H92A0hcItZa+GCyKO2OSIbFhua
ZcHXbPDEMqBX1og9InqD8QJAfTk3aW7/cXXkUcbeMwjN5MWgReLCHSTm0PJbKWkN
hIlxGQ9+4TP+0M6pjmDmM/rPepwdunjET7ql0z8H4gBeHtuzUMD1Jk13zQQec36J
NYS4WBnTgpm0ExDKrajedj8hu5H4s2B/MEOgyXbNDkKvF0oaMDpBGibXBopCW+IC
a+QYYLgJKRTFQ1kf54+qui0s4Gf3c0mROjm4UVq45IDG+HUnTg==
=dzM5
-----END PGP SIGNATURE-----

--=-C29MEZrUalOPg7SmPEW5--
