Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ACFC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A40610E87F;
	Mon, 17 Aug 2026 15:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aol.com header.i=@aol.com header.b="W6L6Y2jc";
	dkim-atps=neutral
Received: from sonic311-24.consmr.mail.gq1.yahoo.com
 (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD7710E87F
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1786981171; bh=FnroDMq+TIWZaCevDkmSnaq5pcpRYrayMMGCj2OI1Sw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=W6L6Y2jciun7U4IEsYmeDepSazJYQtF1pTy6VUYv3pHK71+dpphbagS9F3ATgAh6xzEatinfb4XWYOOboDUcIDC2nh9a9B0tgU7ybBPCNid2oBUjtB84rrP38/aR9Ho+3Qpqr+2trYHds8xXKt3VlpV8bcje4CEtvxQF6/nsyvClXwQItf6yEzxInPok1yajKA7HujUgVG6Z3FPfh6+gigZL/hsnTnUrziDgdFFJYLfbLtYEkuNkt66mP9amm0OcL0qjCC+na1uyKwdPfER4G1UZ8VBVZ8/HtLW5E36OEfudd+nEtoD/UrEbQ9uzjalNnywyJ63m1KCfbcxYAJU8yA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786981171; bh=b8hSkb7Abub+KfSkAjmLl/AP4ziTG+o1aA8eBuxNM7W=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=XXvqzpLPgpkQIlOswtBRrDtZ1SnZwMtIIRxTqSMKLOt1f1wuu4Zq7kNYvjeYlJrnHOi9vZ7G9EEirXliWIYq/xixh662208bUwQFVaXe+O/ndXZNO6Wsf4f5n2ufw7TXtEKxDfgt+ab6Bwv+JnPECKl+AsP+g/eVEDVQTfFXUkmfq9J9+7CTF5FeWofpameLGBCcI333+6/wOZOQlY+OW6I1QUtnlvALcbzEINcFC3ESY943chTZz4tqL21ZquU/HgrOm6410Q/F6CqNAAWbJ6SyQSEduHB/g0KBdddA9iBng9PwgFprocbGeT8pWaTzS5qL+2NjMcUKbLtaCdc6pg==
X-YMail-OSG: emg6c_cVM1l0mUkWQfggLTFODrquXMJ_yILO7BsKLs16EXrRu53V4sfzgvWJ5T4
 I45TiXCWP2WQ7lY8udOfNg7HgGeQFKwC0AGVH1ude.AD.JNd3QGn91syiP07GAo.nIidU5Yg_xO8
 Ae04WmSAd822iWA9bZ8w7WejT3G3NOERdnMmpMBJBKMvdztabXPCVvoufIbkfXnbalGNHyDge_mx
 UZPmxvaG1AtlyTTsw5ESWl9KSnVCvCtqyzWdZeBY_42Cl_kTDWVVxwkZ.OjFYCaJ7NBX8AAtGOYh
 tvIGDkv48cvMAvAWruWBYSI1H5FDotwrXeBbNhuSYBv6mhLrgLuqhEHuRupoZ9YdcPJSzhGFkB2.
 ntkGOaJlUsUQ2cKdeACfu1.jaUuWcmTr36orX8NVI4toc.XJ5IsOf_zEiBPZUtdHL2mmCh9P2mj6
 HnrynKjRABwVGjTN8lNsIuZJUnfDXYK.hYBEZZfDcn8TOhiRHbIebEJncUor60rHjc6BUbV1jTLG
 k.hHvNsl1yySV.8BVTm4J.cctZAIosMM3LZ4YluLsVtGQNGcCCnGTakdsT1oGlqFbfRY.SkuaEbz
 p0gM9qdvfxYC_cT4ENstq_v5g2Xg8z8FpCQb3yqnhoYAoKK7G08TFGfPamGjfy2b0ZLzonLh5UZg
 EWrLKuj5U1IB8ZQEiOUK0YXq96P7YjNh6zWUzTqyByky4ZktCUSZIa_t7zcRBXfhm7J_i_XLJAak
 uX8UzMve8sRuDtSP2acGQrQgd0NbvBegnkKcvTud3IhX_3ixlKWdXJYBMz9Mr5Au45G1bjjk4_c_
 bCRY.T1BI5bAl5FW0c5EF3k5qZAmqvuZmpi6l83wm3GW5Rf65QvAxmxyBvSyj4e9SVhIvl3DvMSF
 kjxDDzHS1TwB5DvxKaAZ3HS2YhZGFJizx1GLxJl5tlB26KAQixnLGqcacovvdWuyBvw43lmzI44x
 F55wKcb0KdCbesmYlq.FytnpqSE0XziDDKR7t.a6zSvn.Ing2wSPLcAy5TlRmFR5mNhMfpcFPYMg
 U..imvreXfLxZtKahBLaJdF2iP8Dq.X8LFwDQxbgrASc9_QC8IE2vGBx30v_DzD2DPzuz0f2r3Ep
 wFojma0ddqIrLdbGtNkLu0oXgaj6kQDD6iEyaVqKh9QhA22VXa9.Jaq8cylVCjAXXw_uOeT_LWZm
 4v2wYVelDwyJtOCk_uFDfJV2DDeidEnvprXdNoVQuQd.l8MRCWa2DlC2Nqbd_WTt3WFfEjCm4Zp_
 CcUMZWUtediaN5AZXmhQkSj1x75Gv77v3DnyVdxxHPVWf5bnqXLC05mYCGmURyo0gcSn09AeDr4E
 2TIbKri5ovBkDG_DDVmJ.kogkjdg_aNbSso2s9hqkWZmdkviDx2GQBm2D9TjlX69SYfhpMgWlfCT
 3gbYSnI6KIdvUiwnlPLpcxJaMuq7fKst2_RPtD5EoGLFEpMy1yCLqpNOOcQ84_TdFbjn2ejnRQaE
 KFe9DP_x1jRv3yb.DTuNrEiKHLeLhcJrUPXrnqC8EUzd56aLMgD6BvWGrGd5VqLXYSyKNltODTSo
 ms66naYkrnIwEB2_XBTBMuqH85q9jCoLj3TU_i8.A5r3Au1oliJYrtGC9A919QxtjWUjfINdOuV1
 CzwhWHNnXXdO1JN23Eh0h4naEPHJzQNsb3DM0uUHSpVMaaIELsOozBzXpt2mc_0JBAqm7hq8OpH6
 8mI8Atp9v1ZGnD7QImHM_XmTsXT4sDXmgNtK7sqYLvyaBIQ7khQmj04unIPEAr1VRrMsQSarqtCl
 bxxOt9U6Fu1QXEvf0dPxOevHWyp.kIYHBCtDAZK9v5Ac8Dshv4QFg2BNxPpFKlsAwq6e8geR7EAt
 fR52kNKGSiRUWGJx4q52UhRG97bCtiSUwst2njLfFcJA5zBJQgWhgOHj0CguGIUgdKI0QPyOVPIy
 RNK8NBBcjFJzd6Q88PKaUdYT_dFt0Cw3KE.200q2scVMnUWRv7M3qDwx07DKG45HMGAUgUKly1Ii
 rcPUxofonoPZvft73WUEYoMKDtqnlk_10h88_X6FACFCdKPpcpKtfA7MmPJ.w2lAC16Ngpw1mBk.
 6ZS4_VMZhEc2S6xvfrSqQy8_iVmPGywlxjajyV9facQ55nYlbegxa9CGdTqRN0zbsVfNBhsTC4Ct
 YvJmgQUxtM50icGvO6Mlcyhxz0rC5VnJOWx2ZHXfL294AkYEpy6vlEFB3iX_3W_EiXPJ8kOi9G4d
 t1usiVe141Sa3l0jxEzojUrTRt1.6AOypwOc6FuiMKYUttPVVnrVek26.wkoyIHmHFrI936AI7az
 bScah3MI-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: daf3c7f7-dda3-4cff-8e25-14c4dd9e854a
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 17 Aug 2026 15:39:31 +0000
Received: by hermes--production-ir2-cddf86dcf-w95gp (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 93ce5bcfbe1a688feff3ddb16045ee60; 
 Mon, 17 Aug 2026 15:39:26 +0000 (UTC)
Message-ID: <5c34319974b4968841f7e1a700643b6d626b2747.camel@aol.com>
Subject: Re: [PATCH] drm: Optimized by adding the TV modes attribute
From: Ruben Wauters <rubenru09@aol.com>
To: Edward Adam Davis <eadavis@qq.com>, 
 syzbot+1944765c3659f63d3777@syzkaller.appspotmail.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, simona@ffwll.ch, syzkaller-bugs@googlegroups.com, 
 tzimmermann@suse.de
Date: Mon, 17 Aug 2026 16:39:23 +0100
In-Reply-To: <tencent_C6A625E0BAF4BB77334C9E0F1B244B7B1B08@qq.com>
References: <6a829a95.dbb3a75c.20434b.0043.GAE@google.com>
 <tencent_C6A625E0BAF4BB77334C9E0F1B244B7B1B08@qq.com>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-HmUUdfRcoGgo6G3FWtsa"
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


--=-HmUUdfRcoGgo6G3FWtsa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-17 at 20:37 +0800, Edward Adam Davis wrote:
> When adding gud properties for drm connector within the function
> gud_connector_add_properties(), if the TV modes property is not added
> first, drm_mode_create_tv_properties_legacy() would fail to add the TV
> modes property because the tv_select_subconnector_property has already
> been added.
>=20
> This causes gud_connector_property_lookup() to fail when looking for
> the TV modes property (returning NULL), which subsequently triggers
> issue [1] when a NULL property is passed to drm_object_attach_property().
>=20
> The fix ensures that within drm_mode_create_tv_properties_legacy(), the
> TV modes property is correctly added regardless of whether the subconnect=
or
> property exists.
>=20
> [1]
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc000000000c: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
> RIP: 0010:drm_object_attach_property+0x85/0x3b0 drivers/gpu/drm/drm_mode_=
object.c:240
> Call Trace:
>  gud_connector_add_properties drivers/gpu/drm/gud/gud_connector.c:572 [in=
line]
>  gud_connector_create drivers/gpu/drm/gud/gud_connector.c:680 [inline]
>  gud_get_connectors+0x86e/0x1700 drivers/gpu/drm/gud/gud_connector.c:717
>  gud_probe+0x17aa/0x1c20 drivers/gpu/drm/gud/gud_drv.c:635
> =20
> Fixes: f453ba046074 ("DRM: add mode setting support")
> Reported-by: syzbot+1944765c3659f63d3777@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1944765c3659f63d3777
> Tested-by: syzbot+1944765c3659f63d3777@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Acked-by: Ruben Wauters <rubenru09@aol.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 11646453aaac..ecbbc967f51f 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2175,8 +2175,12 @@ int drm_mode_create_tv_properties_legacy(struct dr=
m_device *dev,
>  	struct drm_property *tv_subconnector;
>  	unsigned int i;
> =20
> -	if (dev->mode_config.tv_select_subconnector_property)
> +	if (dev->mode_config.tv_select_subconnector_property) {
> +		if (num_modes && !dev->mode_config.legacy_tv_mode_property)
> +			goto other;
> +
>  		return 0;
> +	}
> =20
>  	/*
>  	 * Basic connector properties
> @@ -2199,6 +2203,7 @@ int drm_mode_create_tv_properties_legacy(struct drm=
_device *dev,
>  		goto nomem;
>  	dev->mode_config.tv_subconnector_property =3D tv_subconnector;
> =20
> +other:
>  	/*
>  	 * Other, TV specific properties: margins & TV modes.
>  	 */

--=-HmUUdfRcoGgo6G3FWtsa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmqDKysbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJENJ+UMBQrgzh/qkP/33EARU9YdD+Uqv67N/R
FeA+5Yq6MrkWRVWu7EXo3RPrliHkuqkJ9pZeolmCWGYedPVlda5k1iwXVLuT7omE
8dNC+Pb+0rROEt/i+Pvk/YN2rW9uU307RaEsuSaX9+A2WAR9NaCq3N6zGgX4gENR
eiT5MIqD9AKVGcDRQH+aquPjPLUxTSxfHAtlYuVUBeQP5ZxEvQ1SaX2sd4aPe3bx
uChCU8/22E2t36DeH4JKphYDyvKHG/+HHj4wOCYkgfYetZ6Yi1MIoKZmo8QStuYK
W4xQyrxhSHwAXorKbQdsdIaN1IXxaa8CDibpzyKCsaV4/lzceZDZMvuuyk5Zmcgs
FE1vgDgQCQnn1OqdTs5vEbmvhBkY/zxNsUHCXnuqZ76Dg5FEihlaUBBZUjiH23FZ
5m51r6ETM2fYwrlGOzs35wVzPwasE7jGIoxg0HmO/L8U5yXcjtp68Y1b4XE3AfYc
yl2tUIhAKDf++/VTMFVGHJkoGMR64NdL2IIkNyU1oagknmLJMxo0MByb6i/4B2AJ
M44VS+Lb/HbZSsTl8IBmotazqnsl4UKbY7iKkjGHsaQqNXVaXizsFLAiGEFmk0vX
aOZldItxZ0CbGmXOYMkS+5uNB0E9KrrRgD4k8UtCgg6b4TM5YJm+aKvYUBPdxN0k
d9M+pGEPS8gCEBTMsWxOw0In
=7f31
-----END PGP SIGNATURE-----

--=-HmUUdfRcoGgo6G3FWtsa--
