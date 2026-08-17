Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF555C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 407B310E861;
	Mon, 17 Aug 2026 15:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aol.com header.i=@aol.com header.b="MI4u0l5e";
	dkim-atps=neutral
Received: from sonic311-24.consmr.mail.gq1.yahoo.com
 (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B7F10E861
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1786980981; bh=bJys1aGQPMgWHV3MKBItpjusUbxXaRTmedSIYMIIMac=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=MI4u0l5ezF6kZqnU8jLw/Bw40JPK8V2HlHDK1u7Ui7cU/aKZ7/mBOcpD5B+AU5PUYzPL0e/xiKGL4d66daSZWS1hQ+YChyi9kZzmD+1EOqV8wbLpUApqzTVIo9Bmv5Zj+EdjUdkz51SYg4k7gQc9ZOAFcPaAoTDn3nSl18+qsDy+BvAY5MtV1s3bO+CV1YuzsNhCfDws9rRuYdy6s4lVEtxkAG9scbzWFVa187qLBPFblBvt7lysOXxNeZ1/9FwsY5EiqShx55gcNhvoV3zMFU4gt4ROTKYHSmr4aA4aGEdTLGc/VJfA3CBR1scAXtckp6d6mxQ7Ey7HX/Aegyvy/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786980981; bh=KVRNAotI6kCCXq6O7zA8Ez7ZytlBKwvpT1p5Q2S90vh=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=bSmKcnd6QiQuJKtNe5XTuu1oGSFbgABhrAmyBf7UsTJTp/FGlO4npA02CVfuwDIp0TydNxIsq8bAtldUIAMuj5KEufTlsTtgTxYFN/eUNoepEtLXPhDexsu3to86CXce3m2taXvS55/kg1elSaRh+gf6MxHfG8syydPtLYPE2VDo4ZO4wI7rMkP5+p9D5PpuW6Gy2S8mQqeXhRG8pRVaaCMePShsGOC+iBrhguDpQmdy3cPv4XoIuPQ080cStDQtT2kGbsllwG/GOFWqJnnx6RdKF/O6aeV3zuXaw1Pu/cd+rUcVSJT4EMRs54kGmrQCiqskUA0m48a2mTuolPoO1Q==
X-YMail-OSG: 5E8ZIakVM1mb_8O9cX7wtvf1OVj3G6.aG_itUG63hPOBgml.4B0BVWIr2wDpW1j
 VTmoxnDri_7yhOHPtX7qkQ5eUr44eJGJLPjU7YVLPUQ6cOQRAHPlsKiK.hUABkWqko_srAZVUuFH
 xRF2smODdwdvXn96suSJ81gFShH8BCO15iK01I4M6B7CewKDzS96pVMOLjKonwwXea89hneLOwmP
 jlUcYK8vlagNfrz4Tc3IMYYcobGnO9JXJM0jzzeL61RQQ0Piz5a2LqO1pMrMprs2PV92DFE9HJax
 55zauxUovuU0eYgXu3WDvfp3lVK.F_5sD0Ppjez_mGXfgMsGOW2CtEwRU15wuKKMdhUpPSsELsrK
 YfbUTDJ2qfWOgMnfYzl7rSlby7Lelg29veJStPkaBUyVbMFxFDF5Eov4k6gxpyb9ww9eoRDVruHy
 WYJZU7Zn0f.euu45Xt8OCrXDvE_piP_CK37ouAvfDRlCCCn6S2nUrRv0uU7ouVwM2blu_Lf_ZwnV
 eT59SM2EDPlh8qmx_GE.YVFifLuCaaB.4H.zSH5AxJ6TKTMHnQfnb8878or800gxMTp0850uxeQ7
 wWnwocshZNp.e9eEDFQu8E47dXLbRP3LvcjsdUjR3hLQbadNlKep5GdR3NWV.kVIvtE_p48e3Ima
 IXSIRbb3ySv9Eplpxs5zM9FwKjDpt_6IhUW02uY95r0mzouf1RQvBOCkqnFwFDGv5EQlFXROhAIL
 leykZ7USuT6gVjabiNfPPjcxZlYyS2t4joGZDjm4tIe9YCjt1LyxYnbOvKsI7fFy9JGXOzSacJDr
 HBgDgjmvv60DuY54WwTtOVK2qHRoE40iUfvwsZBaMXHtE.MYPyux4fZztl_A.Gi6d2G6AR56Q2F2
 cWzDdy0Yb2nTrV5iZtZv1gXrD.vv9.yQb2McElCmKMkFnHmcaTGeaxTim4BGH4Q6eQms34tlGPRz
 LMzgNai.pWhd9qULeo_GPJxszqseXzbC79kGFMfSSIcxAqMwpiK0icStNvDHMP5iWMEfAhMr5.Eg
 kC32w3BYkpJaTl5h3qKW8PvEkoVIHsH6cajzZ8mVC32JU80zn8oVEQc_8yFhdwZWXHT8RNJRCwK5
 5lHoAr1q2xAgdiFg.f9PXiU5WoztUP6V0H7hPCaVgBGREFTlLXvIp5zMDTDe7on4ScA5j4IWk.NN
 M0DfSmPZQ.dx1utc5MKj.GLZU4bi6ws46IVN2VmZedHOR8JGVufVD3iHoETuBeyiwMsKG_JjTw3Y
 MgjPg45tB26._qWale5R.gdFAnIZ94kjIkopLAek4eRovw_g5fa.G3HOlM5vkXEYxf74kA3_hF.K
 aj81vG51u.JwoJeqNQeY73LLoTEvdyxJ_hX_7Zkb1g_cN_htDomFKjPVMB5gjUU8juT3teWuYBEt
 viEkFGe9UUsbROyRRCs5asIVplWor9UUst3b.25IwXjUMdk3P3e1uOfk5_k8KP4bR2K2o_Z630DF
 oetEOLubz2y3afIIjjz2d5EHhGeWpe4DmgOeal1p5o7rr0jsylBetX01xxHVvzZkkHvwsef4dZM6
 lPrSy93hBJELJ_Ah.wA3W.BUSO3J6nfLTkxddIw1OyUnXu2DHdxy60ZG0elsUI6yHX2JIYzi.qWa
 SzG9L.vJ1a8Moi_FyZfmHvK222hO_mea7IKqh0jI4WryA9VqH6YnGSdk6MRLa__5TG42EJlLPa_s
 oxfi1cy1c4CVXqQ.w2sWHo1pAIcHv9KtXe9sbznXVu9Ea179b7dGx4KWTCDBqdgm9d98ITZpB9wE
 LvTf79pW4Nr1IJacNz0fUMOf9guseGLaINyeO16trQ6vid8A1fLcLkZeIT.r.D1DXL1svQbzBP5_
 v0fgz1hd_xkmdBLQsb1xMBrg4MbMOuGGBAhkZJJQy9BTyZ0r_j6scjwZQGCuLbTQLqdunGjCcLi0
 7g9PScGLWJgXKXyZjbPMtwPbfFUjEF.i2jEvSI0y4MHxmQOnHxVGaq..UQS1h4qH_X8rzi1FVh.P
 s8_HYKIGp_qLXAB2HvI0plll6glur.piDJWpHYRjfzOO2E0gnW256_Vt0.F.vurMrF3Dp2OjaaJS
 n7vcAro3wLyIr6RMKsNGQ24nsCgTtel.dyKtgxf_IgS7059Fhq76XRpLNsWX5imYXdedlcQD6Iko
 8Jt1Yqnko469zY7N3QgBy3ohwtRyhYKvyNWRct.u23Al5hfrRz4Vh7KyyWFPO6E1FnFhiS09DuUF
 iWr776QNVFhk9i6wehJk71JZmou8.0pThBBEYcjsaXzr9zix5x7CFFvuqNHzz5pE-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 98d46879-23d4-428d-a047-059edf85f148
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 17 Aug 2026 15:36:21 +0000
Received: by hermes--production-ir2-cddf86dcf-8g22t (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID c894d37d1cf016843d41759a37b023ac; 
 Mon, 17 Aug 2026 15:36:15 +0000 (UTC)
Message-ID: <e5c8fc07de22470d27cf25b3169f2dd85804698f.camel@aol.com>
Subject: Re: [PATCH] drm/gud: NUL-terminate TV mode names read from the device
From: Ruben Wauters <rubenru09@aol.com>
To: sashiko-reviews@lists.linux.dev, Deepanshu Kartikey <kartikey406@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Aug 2026 16:36:09 +0100
In-Reply-To: <20260816090040.68D5B1F000E9@smtp.kernel.org>
References: <20260816085234.22053-1-kartikey406@gmail.com>
 <20260816090040.68D5B1F000E9@smtp.kernel.org>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=mQINBGQqWbcBEADD5YXfvC27D1wjh1hOmjTjSwAFjQDGynLtrhBBZpJ+NBsfu++ffR7HF
 d/AaSJ+hqJni6HBNr/DMxWYMC8fOAr6zCSAX6fD2Rvy6rq6emuLaGOFkAIWDyuFWw40anlSCPZN+f
 fXTKJvARo45ZpC9PcfNu9/iRl/CpzSdiB5U4O2YtggXPWyOm9ev+bysmn6sjS1d+IZ7iTs9Ef0O4v
 I+1VFXvZMaY0YzG7EoYnKfeeUD7IGLpI4EEkNqLaU4onLN/qkXUwjT+YTw/VtTxNCmtTVFf57RAg2
 toscC85JjcrOeGSXdpP3J9CPdcIDMpOlnE//KuJIA3QMkckPQgnYtRw3ZhbiVxLNNJSUYm7PuRd9L
 LyObX7dpi0YfsUhxmD2+grw+Yvh2YlPWFybBDBgzRIcSMMSw0ertL64hBof06aVIlT8+TBf1Sq7O+
 obGYoXUi2q6qAuz+0y11spGk0YOffx4ChGPMQGGGaXGaCcjRMuJ050MF4dtwep/mSWH/p8EJtIKY8
 LfP/2c6G8leikMddtb+wKSNUuGYE6ctgcUtlltssRt74ls/ajYE00K52dlhCiaKxd2y0KpYEfWXPE
 pfiQ8yd/P/6fZCaOleY4k8Y2/JmlVUfwfVcVmb3mKWxKQXaHhT3cEvv8yuFDZgkTvZInINKtxxzly
 1i3TlY/nn5mwwARAQABtCFSdWJlbiBXYXV0ZXJzIDxydWJlbnJ1MDlAYW9sLmNvbT6JAlQEEwEIAD
 4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTehs0109D1XkJCLZjSflDAUK4M4QUCaPU
 lLgIZAQAKCRDSflDAUK4M4bK/D/wOugk+nS1PVpk5XkoSB3BXpW0yEuu55EjxXuFfN7mGdtRDq6kn
 WIunzqN9vb7qBFcfz1uG9OxEQpiEhGTW7aIkgCCDbyCk//bb2uRKRy7nVHA9E8p6Zya+974iY0+LV
 LkzIN/CgDavmljWIKQvyPL280KU9PjH2blbH5g6skwAc6MU9pCp6H5W00DYFjMW1j5NCBk5d6UDQ9
 OLukHTU5lHURNB4y0EMZg1eHRjqPk/bxXQA7dAz6BtMKhY+ZY8qDd8XC0sA6Zjsr5r8Os4/mDIn8I
 mzcpVNBKiLU0wpZ58TOUuB0s8wUwXZgwyAkG0sMDqasrQAHx5aVZUfb62p3DosMALacVjHrnW4Kwp
 rwfV9lKxfxPyDoGxtcwCAEdA58fG1FsqFqDxB/qkhyvF/4fzEtcOAHcgEAXR9W5G4PU6KInEidNX1
 1B9IuXRV+5NX6pQ0JAYN10WP7TI5SVzx1ebu6+bdLM0etdLU/0urUJjrnIgfQlRItq091/Qb5k4x5
 WTTeD0Y5Ko5/LSUX95R9z06ZffKWKqrl3QpZbAJrOI9PmDwbV8E5PNsIFE84+O2iqfF01j2rXaj+I
 dRhLIkp2jnabmNTFJtCy/N0Yrx16Gd8FnbOxZkbAER8F49MAm1JBQWoIPRbjRrXKJdkAtJr43RCkS
 VabceKfcvFR7bPf9z7QdcmVkMDMxMDAwIDxydWJlbnJ1MDlAYW9sLmNvbT6JAlEEEwEIADsCGwMFC
 wkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTehs0109D1XkJCLZjSflDAUK4M4QUCaPUlJwAKCR
 DSflDAUK4M4YOiD/0au/ik0WOM0fwVYY6+PQbU9QeHAJ5kuVesCNA57Zwhe2eAeLvAkmh67hmUzTK
 XD46kqeu81cRYG4WlECv2pYUaEkPni9vmpSMTPpmXvpkekaVNrX1qgBVSd2vfP1xG3QmuQXcGiWZw
 gzPDbN/rCjs4iUqwjDrUpnb1c5va2bTfsqATAUfz4MKobkt+NGlJ7wpTY/TE2noeT2Q8v4NWcNkbM
 MMDkACUut0kyzrgeLxu5u8AS2d5TnWHaZwi5hy8egbGTe2FW/fz8GT4ZgOEExshNt2vs2Ay7CGyhm
 v8SJfsvoUQFoIjAKfQ+KLrjCL3nT27Cl1g0Xj6c16f6qH0/ns9uym6SisNr6FzxN4RauMCQsHBeRZ
 qFhJ5WYXaBBziPfa46Jrdnd385KvsQ7V5cGitM6mBx4tDo3cN0jzYqosuBVrwyiOewklRLYrf0go0
 wh31YtoJXeJ0ObH65oHINmT2gqyaii5ZHe+avPwnKE03W5pHwenGCbgSnOndy5eGeamSD7AgwKw4V
 j5r2FeK8K7tU8rpONWu0pkDqq3tMVOcDguTPufXIBFgLDQy4OoC7dHoJRplg8ull5wMjI9ERR0oaP
 8IVIXxGcFRph02eKbZfqK51lMtns3kTe5DgHao5vrE+2GseLnEWE37cWnBQDhYgjwxIWtjGVp6KG7
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-ntfMb4Va7jjgS/pTxUQk"
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


--=-ntfMb4Va7jjgS/pTxUQk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-08-16 at 09:00 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] A malicious or misconfigured USB device can cause a NULL pointer=
 dereference and kernel panic in `drm_object_attach_property` by returning =
`GUD_PROPERTY_TV_MODE` after any other non-margin TV property (such as `GUD=
_PROPERTY_TV_BRIGHTNESS` or `GUD_PROPERTY_TV_HUE`).
> --
>=20
> --- Patch [1]: [PATCH] drm/gud: NUL-terminate TV mode names read from the=
 device ---
> commit 789868bcbf6cc6ddf0d3b74feab3a22914863ec8
> Author: Deepanshu Kartikey <kartikey406@gmail.com>
>=20
> drm/gud: NUL-terminate TV mode names read from the device
>=20
> This commit fixes a potential out-of-bounds read by explicitly NUL-termin=
ating
> TV mode names read from the USB device. This ensures strlen() won't run p=
ast
> the end of the allocation when passed to drm_mode_create_tv_properties_le=
gacy().
>=20
> Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> Reported-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D916c888ba5f1a54c9526
> Tested-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>=20
> > diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/=
gud_connector.c
> > index ea0cca58b7c89..5c0065c876a77 100644
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
>=20
> [Severity: High]
> This is a pre-existing issue, but could a malicious or misconfigured USB =
device
> cause a NULL pointer dereference and kernel panic by returning
> GUD_PROPERTY_TV_MODE after another non-margin TV property?
>=20
> In gud_connector_add_properties(), properties from the USB device are pro=
cessed
> sequentially. If a property like GUD_PROPERTY_TV_BRIGHTNESS is processed =
first,
> drm_mode_create_tv_properties_legacy() creates the baseline TV properties=
 but
> leaves legacy_tv_mode_property as NULL since num_modes is 0.
>=20
> If GUD_PROPERTY_TV_MODE is processed next, it calls gud_connector_add_tv_=
mode()
> which then calls drm_mode_create_tv_properties_legacy() here:
>=20
> drivers/gpu/drm/drm_connector.c:drm_mode_create_tv_properties_legacy() {
>     ...
> 	if (dev->mode_config.tv_select_subconnector_property)
> 		return 0;
>     ...
> }
>=20
> This early return prevents dev->mode_config.legacy_tv_mode_property from
> being created.
>=20

Hello
> Then in gud_connector_add_properties(), gud_connector_property_lookup()
> will return NULL for legacy_tv_mode_property:
>=20
> drivers/gpu/drm/gud/gud_connector.c:gud_connector_add_properties() {
>     ...
> 		property =3D gud_connector_property_lookup(connector, prop);
> 		if (drm_WARN_ON(drm, IS_ERR(property)))
> 			continue;
>     ...
> }
>=20
It might be an idea to add a null check here, however, I am inclined to
accept this patch without it, as it does fix an issue with the current
code, and while this issue is related, it is somewhat separate. It
would be a good idea to have this as a separate patch instead.

Ruben Wauters

> Since IS_ERR() ignores NULL, the NULL property pointer bypasses this chec=
k and
> is passed to drm_object_attach_property(), which unconditionally derefere=
nces
> it:
>=20
> drivers/gpu/drm/drm_mode_object.c:drm_object_attach_property() {
>     ...
> 	struct drm_device *dev =3D property->dev;
>     ...
> }
>=20
> Could this lead to a local denial of service?
>=20
> >  free:
> >  	kfree(buf);
> >  	if (ret < 0)

--=-ntfMb4Va7jjgS/pTxUQk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmqDKmkbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJENJ+UMBQrgzh/HUP/3TDTvQJrfxYQfNkATfc
cL0umHNxLECQ53GiQ3oCjTMB9FL405N82bJKLKrZQ8T0zpcsafJ5Y9jKIqwyMi5d
yXJtV5ED8dR201yi49WR8Wv+x9Kj7EPgmgHJ5NpOPBZ2waLrj3eu0rnSOxtT1W0t
CVp390raZHS9Qq14l7oPH/VhNS0jqY/vKPpiea75/yrNICKWDn57hQfHkoMCAF+n
CnW4jb6PLgB/hVgUKNIk/h/r1WeMIbwAGfStmSRyQPG6EbBS/MKtmMpdU3+32wo4
XTCf969F+KMGQisH1XGRlk2WzagbnBzySu3twvJG4zLbT694VxZmomBnRU+K9gCn
7o/vi9YQn1HxBeQcyZ5cn3juApUyVyePK/5w5/t1VmrXmCMGAh2IdMuOfrg/lN+P
syoDEdQzvYvrY12RfSpXI5MkhxXaZBgCoByebEyRv1hJ9biUnPw28K4gauw5zGgF
jrd1WBa7L4Hx+uXaovqkKnKKx0h3FlWDnNScFRPCyORu2MCdaZSRMThHIeBhFoMN
4Kfcv1R2b5jCFdG4Pf8bnDF8+fsfrAp5Q9e0alZ97xl8HgIUD/glPhlYNItmbyX9
h9kwtbd+fMj7xu4L4Wcu5RJ6KLP5uzCpGcyKMxRfQR0GKHj7W+Awjf221toAqjoH
qj766qYMhTA7heluFbpaE9Af
=AK1u
-----END PGP SIGNATURE-----

--=-ntfMb4Va7jjgS/pTxUQk--
