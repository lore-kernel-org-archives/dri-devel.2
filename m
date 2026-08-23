Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4FFC5DF81
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 15:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED1810E04E;
	Sun, 23 Aug 2026 15:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aol.com header.i=@aol.com header.b="pb2h5Z+H";
	dkim-atps=neutral
Received: from sonic311-24.consmr.mail.gq1.yahoo.com
 (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B60010E04E
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1787499692; bh=hkHqaK71uX6tHYLybpK/G99ov1XVnwyVFlCQI16ykbw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=pb2h5Z+HQEw+5EBBnlnol/DerSeoKdJ9ZxqAcGG3bDSVEVpLn0O6VAkNASFaqL6DU1BaDSR6FXLV2PpkqSFd6BID+M2jAYE5GK3TH0PrVPzHR38jFgaC/wkvyGIcax3xUOa+bgKzPtQ6/Pu7C3Y4wYTJgetlRdiAqr4cVDv+1Fy9CSvSGX/y0uk0jnyVvQvkVDf2j5ouI5t4DY93BEkFw0FU+bp3FpxHwQKLABpCFZU6IFhxiunxd4MUw8i0qofXlSv+huoOUYmWcgC5a0ODXkO3ul8oIzdTMOj7DEcevKqibJBknInfrrZxO3iB9+EEzGNuyWvDXZyhrCbRXpfyzw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787499692; bh=U3SAQPbnjD+Hsb5j/7R1ORpBza6UkXqg8/vKYMTj/4y=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=tJaHgkutSe1MeBquVZtCFG0q7nG4r86U1MosBkjMCDhXCTgGVm5upPJGaEgcA9QAlV2DFvYz3QJiEceOt4u7zgns6jopA/p9101HOpCNNWJPKOBRDgcqL63HRYBK2ePJfb/FRourPfg7DfIfuMOuNRvbleEM7IYT1Z1rIiNJxbbLevkBp1cMh3MQmKZhsQOHJqgQpfPIgWNtf6wZbdfzDOjmxzkQTIEAwasgyIn+3onV442uCfPweu3Sw7ACf8Gchk8hIa3OWH0R/cR3QOpFd+AVGc3vl6uH43nmZdCcB4lIk892XzMPyB2LH62fpBv/Rj1XPLFVdymTqUIqSSJbnQ==
X-YMail-OSG: XqJzYv8VM1lvLTTWhj7Ky5imXwmmgsA6FC.UiwEipwQ54dmykDZJZyUVJQM1omg
 rbNKflr47cJsrz3kXDXaNEfZGA3lhSXFrF6Tq_kx_ceU1mk49rMUaTNTC4WzhTMEo_uI4DedN7mi
 v99deioHjSmuuZ6Ie0oKCl.pT.H_slxMdY_6DN_vKaKGyr1Rt3NHcoBhO_cqgHVe4B.h_kDqv35I
 KZgmAGhprXYSG8X7Uegk4l1L8QrUWzJ2BbP69SflSlAHkO4tgYFPhVJ02UDD1S.VByjoxbrgTFLm
 FjkZF0eRGCL07vxvfoWNX995b_trUAYKykJ.VX2g.qUkq0G4JnKWihUxFIO5bWsBNzZiAnXxWXt9
 8p8zIRgdhMiecC_0.tj.hne3_eQr30eIAzkRKViR_C9J2kg0r1slqmR_m2R5BQC.pFWZQrLn79RI
 2kcr5z4pbUV9rH8mdRzzmpvMDzPKC12Vk57Pw6maqB3C.SK9AzZHHs68eHA8AogGSyJUlk7_JupV
 nngefOWTK6HsWLOOOLx7_XDpi7Sdn0aQPmO4SYTpCoGyDlGnGuDaefRRwS8wyQOQr217WjHc9bAY
 4VYYyqQuSgWLdcZirTDFyUO4GLNtO7mphE54.xSaKVHFI5tlJ7AzJcZ.FP8cGTOsLRMZgw0jwMXG
 OiznYsjWnGGT30vJ5gYEhbzhp1ZlCZLo9ydV2cuABoQF.J7HP1TilxuEaiVbmZYTE4SHr5VK4aC0
 ScQNoIs9cm48ep180cfbuIByjpZM3qsc7PduS67fxAsDpAuCmnWE.B7IUibFmq2uk37K_E8m7DO8
 bCfsWKQpdbeyLXov66sAVTIbRdgC3YndRpVSQOunA9Bi_TYP.uYpn7bV8A7sVjEmBNRk5k7JqyLK
 WrWHBTMgl258N.2oTTrD3bzBZKbCuA_wyO2aAzdqBhhgA74rGMAzaqT91BftBUyYT39UwbZapOwj
 bYrg9hxryMuXoLsYrskqSQA1dh1EygATMNsj3LCZ3tkdYSZK1n0ak2N.DBh88LuDw0VXiLzDNgvK
 USCHRoLy8V5UlOTYsREQCgE_090ab2VJHC1yD3RYYVMKLs9UN0FiboNvalz5EdYsMAl1gSxpky.1
 k.vCCG7FiV4UPNAKRQM6Gv2L1PdhGHV6Vx3JELYPDeDrCmHa0LcR2pdMDZacRupqw5I0OFDSD0FE
 doXlgaMmZ0ys0vExP.XHnznJ.fJnE.bbNaRGzNdXY8bLb9g10WhBO9EFKwHZkUg26KepyqpaL_zw
 BDkEvQJLlf26R6LYonYsVLd4zXY_8De8ekNw8HHd4HdbcBren70sF4cJltxxLf5PWWb8kYa8HuM0
 ZmfJUIbHTpyLykhObl.vl5HTqZya_TlysB8.OJa_bKhvRti1x5qCMFpS9VuKsHCqnWKw1kVJF8Kg
 5zH1aSxC4O3NIZMKVHfou4.dUJfEWKSyDBqtTvAWoiI4otFVR1f.GS2avrpHDpEnRGO8TRrkdiXW
 Wysba0Q2ebMuePg3_zxTEq0EvXNNo4fWwqeuoYWQpyA1zb_5jqFHnYsyt112JbMAPicavZT3Ls3L
 DGGIkY9uPX96oiD_R6WgDyO972XPt9obKRV41vGW04npA1TZtEzbxqDVr0.BKxs155UXD9kOaiLA
 th5dTHKohU1qkMy2DPnHjYdshCsUH0fUPEjq_FesamS4D_Gr8gBlvhW3gpFBYuDNHcWpZ2qjzyS.
 ju9zbsQRIGsSc_4IRdVALjZ9X2fcta4XzDJaQciyOLTG2LrTz3i73O3sGAe4mLnYC8at2UA_jQvL
 Rqnqh4TKEWCl0Mu93Nu90_j.2IYs2Jb9M3heypog8A0hw76kswGTAaIqH8aXnV6a9i2VXc5qhx7X
 R6UtilVIKSknCeeUtwvgE0ABGSibUV1qEmueq1vTdJT6TqgzXe8j1QgqHvptjWow6WKamI8g19XX
 vjzz0Iz8a3yyiNT.ZnBjQ5xQNJc8UzCs8xabt3TnyFhiAKAgoSfbLvmRgdhahaWg01p3VMxZzf_J
 knBYy07CoJHc9GlXhhm4kq.dAmJTAUZOBnfpyZ0G8Mt7ThMuE8r2aHvwhwZ5YUcTK18yIkwmYhKD
 M6MYaQoIkFXR0NGeEDl13qroCn6hZwkDekdi5.OWjuZYZZUYLpr5KtLLlcoj.cFolLkrcU8_nPSJ
 m9RBp0AyTiNxE_zszPWCIf3lqZqyH38jV.tEHN0JhBCRJHF0qEft88BvtCURBbkJN40BUlTM_uoe
 _z.eCgjnI8_h6xQttMy7S3HYWTa2F7ZcwehgQZzedHyIuwlew7JXPcgTpm1zNndBX42pf57CjmBf
 N
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: f8a3aa53-00f4-4071-ac7d-fd0d74ac07d5
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sun, 23 Aug 2026 15:41:32 +0000
Received: by hermes--production-ir2-cddf86dcf-km5lv (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID a16891e943e3632344264cae4f4ff9db; 
 Sun, 23 Aug 2026 15:41:28 +0000 (UTC)
Message-ID: <6c3a749f8d377b122ba33fd06825d8faff345006.camel@aol.com>
Subject: Re: [PATCH] drm/gud: NUL-terminate TV mode names read from the device
From: Ruben Wauters <rubenru09@aol.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: peter@stuge.se, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
Date: Sun, 23 Aug 2026 16:41:26 +0100
In-Reply-To: <2973ae0d1d7ca4c39ef2cb07236ace25d400fdd0.camel@aol.com>
References: <20260816085234.22053-1-kartikey406@gmail.com>
 <2973ae0d1d7ca4c39ef2cb07236ace25d400fdd0.camel@aol.com>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-tCN8FlM/lj0M4uctGBks"
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
X-Mailer: WebService/1.1.26380
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


--=-tCN8FlM/lj0M4uctGBks
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-17 at 16:36 +0100, Ruben Wauters wrote:
> On Sun, 2026-08-16 at 14:22 +0530, Deepanshu Kartikey wrote:
> > gud_connector_add_tv_mode() reads a buffer of fixed-size mode names fro=
m
> > the USB device and passes pointers into it to
> > drm_mode_create_tv_properties_legacy(), which calls strlen() on each on=
e.
> > Nothing guarantees the device NUL-terminates a name, so strlen() can ru=
n
> > past the end of a slot and, for the last mode, past the end of the
> > allocation.
> >=20
> > Terminate each name at the end of its slot before use.
> >=20
> > Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> > Reported-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D916c888ba5f1a54c9526
> > Tested-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> Acked-by: Ruben Wauters <rubenru09@aol.com>

Thank you, applied to drm-misc-fixes, Cc'd stable

Ruben
> > ---
> >  drivers/gpu/drm/gud/gud_connector.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/=
gud_connector.c
> > index ea0cca58b7c8..5c0065c876a7 100644
> > --- a/drivers/gpu/drm/gud/gud_connector.c
> > +++ b/drivers/gpu/drm/gud/gud_connector.c
> > @@ -396,8 +396,13 @@ static int gud_connector_add_tv_mode(struct gud_de=
vice *gdrm, struct drm_connect
> >  	}
> > =20
> >  	num_modes =3D ret / GUD_CONNECTOR_TV_MODE_NAME_LEN;
> > -	for (i =3D 0; i < num_modes; i++)
> > -		modes[i] =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
> > +	for (i =3D 0; i < num_modes; i++) {
> > +		char *mode =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
> > +
> > +		/* The device is not trusted to NUL-terminate the name */
> > +		mode[GUD_CONNECTOR_TV_MODE_NAME_LEN - 1] =3D '\0';
> > +		modes[i] =3D mode;
> > +	}
> > =20
> >  	ret =3D drm_mode_create_tv_properties_legacy(connector->dev, num_mode=
s, modes);
> >  free:

--=-tCN8FlM/lj0M4uctGBks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmqLFKYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJENJ+UMBQrgzhR+sP/RIIZHGDZNC/YBrZ2kHQ
Y47mb666c8c9OgnXOQElwPhTilOPpM8IpasomfG76FOSRh/jT4gZoLxQcVWXlwDF
+2GUP92L6ZkHDgh0ELEKlUSgxERnP53VsucrsmpN5p9Tec0RKTXrD2mF+eL9h15A
BbJzKkc/aO9av2I348mNPumS/eRnWI8nMVJU0VMb3O/w7abNX7Gvh8Tlsoj5Aj/n
5WtRqZdlJd7pZNwhZfpi3HULNny5Rp/ZPckN+qUZAnGqMRmoUNLGhBLQoxBxJUdf
LGfYrSdCAhRFJiQDnfEDOpr8JIyzpAiI4NyBW9wqqJeKaCGk/791N/657sd6GJzW
+YQvjCPj5qenBzs/ISYCO4K5yYH2L1optibjBTcFGSLYG+M5lXLrKQdfmIun03au
zDrHa+iq6X22tPJWDUAZ1QsCJGo4GVnmkmC+/aE5xogAxYtZVk5lREvQU9Eey+CC
OspH4P3C3quTQWGo2UdzKgCegp9l/T47oX4YjP/UIA7qyfyTFwKbCt0WBaxAxB6r
XVt1+6fxBXTDM7uGvdvuqJMie8DzHee0oKIy+qiUN0qolcP2X819vBI3+LiKqT4+
Wz63sPv5+hZR8Dxq06ZcF0Vl0MHVMi6M/RUacuA3riXO2v/CUVigZky9CdBTCAI7
1SZl840i3619OtEXy2OCD3HQ
=DN5a
-----END PGP SIGNATURE-----

--=-tCN8FlM/lj0M4uctGBks--
