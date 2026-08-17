Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661DAC5DF77
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B861310E87E;
	Mon, 17 Aug 2026 15:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aol.com header.i=@aol.com header.b="pNGMx6dC";
	dkim-atps=neutral
Received: from sonic308-55.consmr.mail.gq1.yahoo.com
 (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93CB10E878
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1786981024; bh=vgqwtluDq41AFyQgE+b0AbGmQxw48Si+m5EDQuG/ifE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=pNGMx6dCcSO+oFFBcD7oW0fAH8hRpH01EAnUt13vNl3BVZgE2kwBUFA+zyEZgoic1OBtZNy8cXG4zpswNPsA+rE0umlM3QnAg6guliVn9WGUaigUQlGwSKkjGqO6UNWScpgvO0WMW6U9E4iCySWfvPPbBAl8Yv5q559H6R1oFI+f5wdTDjITONlbrpNJFBJQQ4CWb9o7T6te0cVruyAPx1NswsnpUDOrX+toT1DnTsso/8yN2+pgLfXJHFSTTuZNz5gpzbmzk3tuK2Y8z3MYVGD/5LyFgFCb/psTo1Ta6zhdpOgCuQATcytg1QKtK5S6OlXNKOAHN6eGBV5wOa6CVw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786981024; bh=4HBopUbh70TaSN7rjBNfNMMBvCNEwY29+Cr+FAWt7w8=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=H4BOUYfHz6kZwW+f1w7lHvvm+lYP/UpNCnM/KnuRGrPz+ztFgrOW6033XWT0l7CDA90l4WPes1nle05UpDV/udjs5zlETKn8lG3PydDUYiinluJJWAC4dBE2QteMUDRj6fEd++PwuWXgwk1JvtnPgjRn/UfvixwFAdfVA8DS8t0/Ep5Uyxx/h80kX9584MTx9CBO1yyVpJwd4cfw6k9XmJ/rOFwhBAOXRHZtD1DAnzBi3lSFAeL3ochqGzq4/jlKvx9xtehjCVKh5WMH9FdXbVNSsWoOKf0xTexqsVlBtFSY1yZl+eYETf9JqifLpt65vR/YfCLqW9+j/BVniTbr7w==
X-YMail-OSG: PrqawoMVM1lixqjvgxKChByi2.aYC6MAgjbX7qVt7TwV8ns1NLQxTEr8bPt5Pqa
 gaNCK2fz6eJwmrb0QvzQTpOmRr3U9RCgIgeE.c_9IMpcLCmUwjPUE5uahDa2rrZ7v8hLbf55dzaj
 3dp_tzr7VWJzSHNov9wy_ZMdkdzK9H9v.5udBZ54ZghXtBR_p7wwIWpFsjhzmIzgaM0I5GhZOR3U
 0vjFebc3__sz_YuZ7M6toDrvgcHMQg3BMR47s9yH1U42LJOPj5qo.hJ01PBX.EDkxS5YjZ5uQakT
 EoshCnyhobVxSLXUHkjfSxDE2ofdU.H3Z5qpigdyZe8Pl6UV8Ni_oJG9rKqC.afp8unIDQywCig6
 uOlllbV0N4x4epe1RZJgZX8M0uouRr60Dz7HvGmg451w2H2L5IrnzhHIutHyMqKjAysifZJpJX95
 r5Kogc1jmFe99MTVGxNRFSuo0YQcIkndoYK4k8vrf5L2Il1f_2iMNJlFQr57f2x0SeZDrautzp2C
 qd9dGIbanvxEIoS0x962PnIUQrZ4SOQ0eulZ.X8_WzqGQ6zxEtHipMSd6ai9zVAwaZ8psbjxaAII
 WsTABH1A3CnxI0m_YIGgBE6BgxC3pkeedzbi8jgu8RSmAv3QkBgarBEPxQ_zuUdnHkmbXGvwHG42
 FumcpUCbumMNoQhseiOojGebiQ8rcbChAbFo1yiHIpRpk.cQ4pRxS7vBSrdTPUiXsKM0yelmb0x6
 u2Gj4W15UjEELXrHXLj4buQOe._IEkAgQnvyP6lZ0l2mLZU6sZsYKAD4Z_XIuZfJO6IoOy40PX.3
 d0s0JIEv6x4HNkLPDpVV1Z4FnYXBMFij.SEOZVIpAXtXewOJgV4Yc35SE_1BbDK_gxgVgoB07zFf
 79_mKNZvqjdgRcA.tQoSNz7ZBNsT9soNMpWvMtJWlb8OqqlPUEQo3yrtvDYtKEBfieG5KDzfiJ9_
 l8s9tU8t.rAfRqT4NsNMhbLKKOp_wOPQRpQawRHLrgGDhCdFpe9XTuYcB1PORPKEaYynM8wVgfAY
 ki0ymI_fEuPrrabHIhwdNM1PSRvHsFV9knyY9uMlYsb.Akk.Q6lbZR8ws2yvqQ13dip3FFAfmXtX
 OjxFGI5gkcggpVxuUHIu1Z9fbyJrLG6ZZhyXEO2uLl92NUWUkhRE2grR9z6zqZn6nAqO83fzPre7
 VdSUOCjEnpO3oB1GPt01vyb5lY6kPFUfW1umAXES6TwGre91adz3tw3Y7HGs17hu4OXG9H2RRq6i
 ABcfm8goCV73DF0wakBI99rJoS7J0jyJwE56FUibA5lUHZF1y0ou9saa4Ox5CcmVeP8v0FQrYFKt
 _F798yhbU6lfB1tqgFF3ps22W4dPdALvbjLN4EUX3OpLAp3BVkHilRaSTm5tkaKwM7sDRA5sa3Tp
 NNijcIFTGja5HOvZmNxuzg6yVEW3hz8GRDiUHw9gtO51gZoJiFtX.elIc_HnFs71m5Bw4z69kt3n
 5ZbHejedL4xPfRRy6c.B2t.Fc3X7jGGBUpzcaxB3PEehzE5EJZiKDWsjbwfXkekd6ykzmOXW3_Ba
 ru.eN2GpN.3n8zwgKNmJR1isrT9UDCokgaj9SWh7Qtj.RBjytlXp8D5SP62KUmmrt5TYgm3qTvmw
 Hy8Ls0O58REHsNZy8sJhXLGxYoUSbr9UkPMzHYrkXD.Kdu3hjJwT.2UUcFamzMFt3FA7mlWJh7Vh
 W6XfNIKI1K2T2n5RNMGAmW5YAfWxczNuaV9J5mFhaJXbthuINOhz3iItj3lKmr09bLMdhKRANKaw
 UxSIMH7pKJpWYsPJfBDq0unxLzkUl0ych6j5vu_48y2b5QwwPoVfNtNRS9mLrhbfbJTvwzokeSGg
 4UjwveY20RzkHhEiYb8aXCQAsdwDiAco0bU72_L0PBTt8q9YSvC9mnidn55zg2rZ6cU4_mn5PP8Z
 nlcEU2ac2JD6ir57mRIadV5_U2FdwAY3YjIMWbW_PjnbYAmLOEWBpM6MF6QBfAe5YoFyBoRqTv5O
 6nzxENrVJE1465H6DkJhN62oy59nB0cjL0_GG729nTzAcbKITcgm4VwHcUHaibhHEqE5vCt.3rP.
 W0e9R8u_biO7M7jdAxWtN5mPafi73XaM0v.dwZvWK1ih8PCxdqoYEnc8sbumbWVtbJVMjtykXweT
 clga58tBhzOvVp36iES7BBtRJrCKii0EZRiGpKUk9pMXclJMdM8iTYMr_LhF4Zc6G5khPlUmlpXQ
 4rl7ww31G.QRHwZQGKwxKFaGDn6BdcPKfBKHSvwXvWF37OgyIv9FLCQiJaVC1dcpcvUA7E_HUlpK
 G
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: be5ad03c-4213-43c7-8b3e-eb279ce628d5
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 17 Aug 2026 15:37:04 +0000
Received: by hermes--production-ir2-cddf86dcf-rfhhn (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 64174b622188428ce99ab7f2e3a1c064; 
 Mon, 17 Aug 2026 15:36:59 +0000 (UTC)
Message-ID: <2973ae0d1d7ca4c39ef2cb07236ace25d400fdd0.camel@aol.com>
Subject: Re: [PATCH] drm/gud: NUL-terminate TV mode names read from the device
From: Ruben Wauters <rubenru09@aol.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: peter@stuge.se, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
Date: Mon, 17 Aug 2026 16:36:57 +0100
In-Reply-To: <20260816085234.22053-1-kartikey406@gmail.com>
References: <20260816085234.22053-1-kartikey406@gmail.com>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-+p5LyX1SSm9/WwkMj3eQ"
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


--=-+p5LyX1SSm9/WwkMj3eQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-08-16 at 14:22 +0530, Deepanshu Kartikey wrote:
> gud_connector_add_tv_mode() reads a buffer of fixed-size mode names from
> the USB device and passes pointers into it to
> drm_mode_create_tv_properties_legacy(), which calls strlen() on each one.
> Nothing guarantees the device NUL-terminates a name, so strlen() can run
> past the end of a slot and, for the last mode, past the end of the
> allocation.
>=20
> Terminate each name at the end of its slot before use.
>=20
> Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> Reported-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D916c888ba5f1a54c9526
> Tested-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Acked-by: Ruben Wauters <rubenru09@aol.com>
> ---
>  drivers/gpu/drm/gud/gud_connector.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gu=
d_connector.c
> index ea0cca58b7c8..5c0065c876a7 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -396,8 +396,13 @@ static int gud_connector_add_tv_mode(struct gud_devi=
ce *gdrm, struct drm_connect
>  	}
> =20
>  	num_modes =3D ret / GUD_CONNECTOR_TV_MODE_NAME_LEN;
> -	for (i =3D 0; i < num_modes; i++)
> -		modes[i] =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
> +	for (i =3D 0; i < num_modes; i++) {
> +		char *mode =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
> +
> +		/* The device is not trusted to NUL-terminate the name */
> +		mode[GUD_CONNECTOR_TV_MODE_NAME_LEN - 1] =3D '\0';
> +		modes[i] =3D mode;
> +	}
> =20
>  	ret =3D drm_mode_create_tv_properties_legacy(connector->dev, num_modes,=
 modes);
>  free:

--=-+p5LyX1SSm9/WwkMj3eQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmqDKpkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJENJ+UMBQrgzhE3AP/1Om9r+dmc3DfoqZpu9r
h8BqYFZbWu42Q+YeIZLJfBjenpIh2PZcv0bL0ztByc3X9H+yVee7CjLYgAOkLbNb
sXrnhEAYRk+S6c57l74gjb1p7YZzOIaDhaUCnpIvBnllwOf0iUPax5g989Khpihu
vAX7UvbC9SxRPLUJQOrVA5yOe/iLiOBHDLMzvndLiQyL2FfEj+c8ImH9cCnqU3c0
Br3A9f0CUNl3yh+6PJiGSfqgD1utJkvr+XJHLiMUYHbAKQrGKnsy/JDa61lFzh17
J57I6dmriSfvjqh34j+jmogwGAnT5sUwYTaRJhIjRDlT9eIuriYcTjGM+UCNO3q5
I7SFvPWEGzK5sdhjhBC8wW4i1M6iLUDBDWnpPL7rczxrWrzedT2rkKO+gWPfPgSA
nMjQsB9EY1c2/+7fghF3jNnDp7CjnlwJzhPTXp8MRamnfH2ch+qz1qhhEB1zKgS6
rJrh6vd9OS6B3NHpG+FU6QXg3VYkN+YLDTpTuTUQdneJbxfwriCC2eXWNSjKLqRs
XOGWx6TQh2qaPhwNuH/Vapv9gQa4lrL7PGOaignCZYg61aeN58SMl7zjLdRHymxt
YPp0S+lEW4HH+9S8ptvUIC81NrCLy83TKKSafzDdyge20wDciHgSLdiYDUFkJxDH
QcFwvHbpiON+cnsEHmoN4lEo
=FbGl
-----END PGP SIGNATURE-----

--=-+p5LyX1SSm9/WwkMj3eQ--
