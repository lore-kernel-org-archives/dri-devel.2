Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7244CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 14:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5406110EB23;
	Tue, 12 May 2026 14:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aol.com header.i=@aol.com header.b="OhY1pk4H";
	dkim-atps=neutral
Received: from sonic314-19.consmr.mail.gq1.yahoo.com
 (sonic314-19.consmr.mail.gq1.yahoo.com [98.137.69.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197D110EAE6
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1778597073; bh=9tdTGPEgHb6BsG8sKG9esxzHuTjRjZyKRoOAQd+JHJ4=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=OhY1pk4HX8uqBXfmHn544pCj0BALVmo6/uT0g3MKjBtmjIyvMdJzVNgnBQzQS+2fUgwVCpLFN8RJ2diwt8/0+ighgBaehIn3Mz5pp/xFxZObBO+Z++Z8DG77O5nNzpyZOCcyMo+T/loJoCcpoCuGA8P0neVPQ/HewV69E9+lzgl5uwmDxa8RHVyYG/vE378kw3P9e4rqDvj6fEZ8qaOwq3vf3RXo6EFUs9P8x4lrcCzaQj6sltTMmOtNxgrv4HcDqY7f6pRzYHCea28x8SmqDtcKGLjr3Em+4NHudwiTaBjLVku0CcbvEnMhuzS9hrG5axvTLL4Dg059SKTC1lD+Sw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1778597073; bh=zLji1TO9uZwVKF1aHbJ1lln6LeTJRkwifzFf7iEbEgH=;
 h=X-Sonic-MF:Subject:From:To:Date:From:Subject;
 b=cHdOCbTOQDrb7R2jbdTwdf5L68tazthxlqzykYANGMV/sDouapS8xgMGpljDETu42K86mXnHtV7Ebv0VMheJiJ6eXGccBfWto47Tgd8+A1IDq8OhFOXQSgQGHpa3E7MHh5ZD737GhxE58/WTsQPqa9NmYuL4qRVVwxr/TB5E4qj181l1LuEjTHYGZKWB9Z+bT4xvBPCfeSIEQ8GkWFlgI3pimYECOAHOgCOcJ0WBrv2DnPhjt1j7tGKZ1GAL1cTKnua9eyHbYKy9Q/NygfwH6sYRIktwPnbWK5ookCYFiVGNVo5MPc3b3tEr1OrPYnN47I10DL6DerTvs4B4RXHWOA==
X-YMail-OSG: ngAA60sVM1ky98A65gJYs62hIW8kkDc5tREcCuUPqHY.AcwEvOIvAcxWAZdKxJZ
 HRTYdH22Arfip9mUO3ZZWlus4XisDwANXuKFQ3EYBhVOpot75vFJwl.HJwoVbWCdx48GaMc1QWJZ
 2rDGw_rdt5znEhOQ07wrHoLZgKJwUfu49HTK5rE2V9thd3oV_D78.NIhZutgPHfn5q43jOGGRTkF
 7x_KpPq6A5PZGMfAIpUq.qNczmv7svey0gi40daNqTMjN9kMnszePovLnAYFmN7jU.0M0M3Pn9iF
 aIsPV4So6t30a5Ink0ZwK5jEOcDtGV4.qil8Jkg_WlwgO8o2KAvw1jZJMFsLUAGSzE79wu9EDxIJ
 2Pweko7RX5sAbD4svmn.kF3IQz3QRSNL8Ua05g3UYDeFWgCAEsGAXxSW1hRPs8RU0IDsdTNKtrTo
 QB5f7fUhEZWFF.yqElrWFPGNieM0wKqTpcpyCInmdSu4HDiyQGpwQyfmFHeG_isZfm3pYpTanr27
 HJRNQ32OMAGWsSjoLcZ16G0gDcREnubF8qJtNgXAFMZhw0Rs_6RfRqEQZTCAgdrXqtRSm7uvRkyG
 AunuTuBdwdsNzfD1sG_ZlPKgq.sj6Ile2SWBgPAfZGilmkmjSRrowxXQUgIggfAnNjEhtYvLdaT8
 ickaQojrs2NDJeIaPei9Pen_XgQuz8pQD96CevR2u.stY5w6Lnjtt1.jt0YfepNhgtzdllVWZQsw
 FjzcaO6EJx6cwZS0wqYrGZiK6E7EP52ICd8skALmFhWDTuGQ6XVygNHO4zS1milNbIX59hTjWZiU
 KWZroCOAUYnomts4Ov93bcO563.1jXC2JwAgMjAfxvbaP17PvzuTziq3qx9nrpz4y9lCJNRy5K_0
 7S.CQ0HeW8yvnGBLpA1LwyxfqgmkmQDDVH9xijWCyGMvevS8syYbbKEcOtBhmr_54DIDYNVhg.Op
 hg2miarzG8WY1DC_XKcThwdosTDaNcvRwSxTm6RjI7dJ8gIZ_lSp.ID3fidA.mghf9oS.4c3LliK
 vnIealc5ZiZEtcbuRgWDMrGLDUYNQuMQt9SK.icLOyB7Q6i8kB2uykYkmtw2bjW9gWl10hXXqbk.
 n0xV3nAKcZXtdt0nZ6o4i4baeMIe6XwWCSkRBt2LTsZh.jjn5seqwQWnazU5hzTFPtoszvqqLT2g
 vCWUgjcVpKTed_K7y.fbw299O3hXJXbdSlAugIaR4kj4_x.N5qUuT7EBY3iol3d__WIKvt_E9jJt
 X3XoWCwDSxfaVl1hqag0bg2cI2vXLYZEgqYv40FnzBtZmyF2zqq6OKGxhk7w2hhDQX9DVr5C7PoG
 r6QvrRtA_fFcldYa91izZORsCy3DFa9Z_gdwILON2SDigr0E5L3wUbYyI85oswSTQaBo03pCpQYl
 pT1r7hjsZ3Gi7i1dR02pQvUzMt550oTeqlJX98dE6It314j71cJ5MxR2.jgugOpqR97oROT_2nm_
 bIbyQQtx_SO3gq6pirDpuhBb3v5qvrX9S0baTpYV1dNXoN.04lZj.aaM5YzPqp6M75.1X7kcn1xm
 du.GE43Rm.nZru97jCpv2wO3Kb3c7odKu47OqimeywUew6RyAA3bgjPLARc63bkJDaOCCdewkqKl
 DMjj2CFClqF.aDpzunblvsswbl9KFFVRa3nlERGsAxbOxJ.UHbNslP5OQZ4X4hWE4ZEcIJzZRPrs
 A1ZfEEUy._cVs2aY48vdTR4U557.TUAXAVE4d.HI5wwoVuBZx2XO3qmRt48flzSVfLRwiDfszhy3
 uN_0XbrYLvGkZYx8xnqxL81F7wB1htYot0buwXLsloCWFQ42fQjVkkztbJ0WlnCLwPeH9GyNb9pv
 .Q8eYnmWMbGTHWgt8utiQZyIEef.bZ8k24Mg7HtZ2ZhkSELWa1YTs1EhYlfhrPwYkE2M7dNXuAW_
 Exj2cMIrA8SqSs64gecXTTyVOnHk12jRv1MgU8wRGm.a5NA9x_IahHicXbCnwerLc8Xf0iBxRYd3
 I8eKG1OouMxPr_QNvYAu7ADPOGO35OJxFGdd7Jw03COCfZIKZAOU3F.7MGTgqkvLWwtTLKNdEGCD
 yQa22iiprgJ1j_AV_p6x2IBS9trftqgTNXyrqhKe_FUoBJpog.c8I_0z8uHNgp4xn4sFZHNqw5WL
 j7Qp5QO_7wfuzCEi1tDIkLLb1KLyfa0gjeNWPQDwjBmDjVJRrqF.VpVHb4GWEVLSeINY6jfiklgq
 cUlz7OIv4nPTlNyERhNptJR8YvBILGKTKHSTtcCOCrn_6HDtiQlVqeHkIQaUIBC4bWg--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: ba2acbad-9055-415a-bbf8-6f71ad7d3fe7
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Tue, 12 May 2026 14:44:33 +0000
Received: by hermes--production-ir2-89844b765-82cnf (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 4441621dfc4d6df6290527588349be5e; 
 Tue, 12 May 2026 14:44:27 +0000 (UTC)
Message-ID: <28b2c478a0fe13fe698ae87305f74c4b4263f2bd.camel@aol.com>
Subject: Re: [PATCH] drm/gud: Add RCade Display Adapter VID/PID pair
From: Ruben Wauters <rubenru09@aol.com>
To: Sophie D <patches@scd31.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, 	simona@ffwll.ch, linux-kernel@vger.kernel.org
Date: Tue, 12 May 2026 15:44:24 +0100
In-Reply-To: <871pfgahu0.fsf@scd31.com>
References: <20260509122037.4189266-1-patches@scd31.com>
 <13469286-2252-4da2-96eb-979cc121f8b9@suse.de> <871pfidu8n.fsf@scd31.com>
 <af49bbcf-58d3-4fe4-a742-ba4da4493cbd@suse.de> <871pfgahu0.fsf@scd31.com>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-07PfTVCDeKTx9xdghQPC"
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-Mailer: WebService/1.1.25725
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


--=-07PfTVCDeKTx9xdghQPC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-12 at 09:16 -0400, Sophie D wrote:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
>=20
> > Ok. Patch is now merged.
>=20
> Thanks so much, this is my first kernel patch (:

Hi,

Sorry for any delay

Looks like Thomas got to it before I could, which is great

It's quite exciting that other people are using the gud driver, since
until this point it has tended to be a lesser-used one, so I am glad
people are using it.

Thank you for the patch

Ruben
>=20
> Sophie

--=-07PfTVCDeKTx9xdghQPC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmoDPMgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJENJ+UMBQrgzhXRoP/3a1ANOAy9n1kQAJRuQj
WpX0juzF2qTOn7Hi3OXMPJ9ZSTxdaE92cfY7w462Gvp+3GTykdq0uy83qSsCykxC
QP+F45823xEfpPP8rT/jhk36p1uT9u8Ik5a2GgUBlljH8KgmTC3Fxy/8SYAM044G
xK7AaDnC6ChjQd1z5adOAXihhPf+laowWJJOyZrxUFzzbzQpQQDisOQrUghjwVUz
a8yP+CwZiASSwp+cbimSuC6pWVf/P2ZKnVjFcRnS84vFMsIiTndlsaV5s3s4f0XZ
Jum6tD0Vjb6SMHHqbxThaLiTNYb+ymtDmI4ND2u3ndIwfSVjgVKxTelREDOhtZbl
CbH0UYxRmovZ4gIBhud9amKhEt6unNZJ0dUi0K3K2LHIfaRwDrPBD54WgGW6vFn3
XcH4wSF8i9CYUgZje8cn7IUP4bC57Mprd2YHMNMaO84t36a/U+wc6hfDALIrZDsJ
VDBXsbY+jh8AWxvlr/4k+Oje8QMB8i52NBMowrynZY3iwv7P+vXPdigeDDcbBtzF
W7nWjCN0mR7KhGzrHgC4SacXElR6epJ86sisD92ZPKeVD+Qc4XSrTiVZyBHw6/yy
D/QzxdmVgslS6KClOdPRDwqvdXSkGbVamJLuYwL0lNsnHOj6RNvGwg3GllB3OQFq
hlhKZdHSiZOsPVQde7itQ13a
=IuiD
-----END PGP SIGNATURE-----

--=-07PfTVCDeKTx9xdghQPC--
