Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5D0C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFFEE10E0FC;
	Mon, 24 Aug 2026 10:06:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=goldelico.com header.i=@goldelico.com header.b="ido/t3AN";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ShhGPoFF";
	dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D6110E0FC
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787565989; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=aw3LS/ZdKUmC7d4PMwTFio7mCRQRE8euZuGIHexXTZhvK04rPCm8P5sroI2UOqUWzk
 /xmM7gXQ+Q8Osf4lE2ZEd05orEM3bfCqg52kRztCniYfnEZQqZC1jmBuL2qmm0lCU0UK
 bTE5ML2RlWxLGsHSvQGkOKu8H1Hdu12RqB0sTEL4leDN2mtlytLPVWh702xnpY4OS1HG
 jaK2wiFVNUUJaFxPVywIDSCCETytlZ3yGsLkdht8zR6oodO+Ixu6GSB1EDuiGBRmHO6C
 GVlBswDnC5Ynvp3NYVG8CWDktSXn49xsIpjjqEy/ox0ksmnH3wE+RKAauXjEAzwg6Hl3
 DSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787565989;
 s=strato-dkim-0002; d=strato.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=BZNS6yonFZhtqNirDSAgAz29wmJOTQK+KRlmTy8iYlo=;
 b=bQVByvzhWtn1jerJU5K+JPP6QP0lWdzc1Acang1HQjcwixA2P3kUrLbF+MxxzJ32O3
 mdTvDQAwbVZHKWQvrDkgH7XIPKZCVZSPAYxUgH3npj7XPGv+EFfB4cPBGzXX56liDa5f
 hCkcPgNbTNNA/EbCGvEePSt/BySrRcQ/1ToaEvMC3Xq9U9fOD9tEIew/bJSzROdBfzwM
 TFnDdhxZfJG4vI/M9GKbPEvjLL4Kf9piZGyZ2wp4q6nx8Fw5Y6WPUXkD9PVNrVXdo6Jl
 dBjFgfr1f402ZL06tL7uUzor8h/YT72WEY2ZNhAYIxDbsZRQrs9V28ym7A3L+8yEVrx5
 TlKg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787565989;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=BZNS6yonFZhtqNirDSAgAz29wmJOTQK+KRlmTy8iYlo=;
 b=ido/t3ANj8QUjkNRI6zQM8I95un7c73eYl1hPwVHnNcgi5ldiQ/HX46Ts/etzwztB9
 /bbDtT9EfKQ+o+7WpBhfuYcJ6SZuk8dki7yPwOicTiOmuCNugdSSike/oNMWCyr59i02
 c0bL3YnpyTNOeM2jB49z5TNqsZc/5aiKSiaYMWsOp1f9ptENnEyeZDUsUvfO0Nj0kjiq
 AS1qn/ru6c381/R/yXWVbs0D/Jcn0F8S0d17ZHiEplHF/HjY1MBYiCSOz5S525wa0srF
 aekil2m4vu2l4a2NnspPSbXeTXhQJ72BPK8TnSmlG3Z1SCNqXU0kJ0FmvMTN4jjozdNP
 qeJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787565989;
 s=strato-dkim-0003; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=BZNS6yonFZhtqNirDSAgAz29wmJOTQK+KRlmTy8iYlo=;
 b=ShhGPoFF8lgTgMR69JejgWCHR+Ms9RU+2EnUz8SwpDBJK2RtJMB1V39wDi4PnMo8x6
 gwAzDtpQrJEkbTtXGICQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQipoOy8iN9EQCaJvpc3APUCy9LxWOnfZGxS9c"
Received: from smtpclient.apple by smtp.strato.de (RZmta 55.6.2 AUTH)
 with ESMTPSA id Qfefb327OA6Sa21
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Mon, 24 Aug 2026 12:06:28 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v3] drm/ingenic: fix bridge allocation
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <0cf9366ba1a217ad743fd7f49d00813b32f104f2.camel@crapouillou.net>
Date: Mon, 24 Aug 2026 12:06:18 +0200
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-mips@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org, wbx@openadk.org, kernel@pyra-handheld.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A09A1723-95E2-4562-8B08-8C3232A25051@goldelico.com>
References: <a3b64245250cd092776cf23cddffe18318b48995.1787494377.git.hns@goldelico.com>
 <0cf9366ba1a217ad743fd7f49d00813b32f104f2.camel@crapouillou.net>
To: Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
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

Hi Paul,

> Am 24.08.2026 um 11:56 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> Le dimanche 23 ao=C3=BBt 2026 =C3=A0 16:12 +0200, H. Nikolaus Schaller =
a =C3=A9crit :
>> Bridge allocation API has changed and ingenic/drm was broken
>> leading to
>>=20
>> [   54.997593] dw-hdmi-ingenic 10180000.hdmi: Detected HDMI \X
>> controller v1.31a with HDCP (DWC HDMI 3D TX PHY)
>> [   55.491338] dw-hdmi-ingenic 10180000.hdmi: registered DesignWare
>> HDMI I2C bus driver
>> [   55.899132] [drm] DRM bridge corrupted or not allocated by
>> devm_drm_bridge_alloc()
>> [   55.904136] ------------[ cut here ]------------
>> [   55.908753] WARNING: lib/refcount.c:25 at drm_bridge_get+0x58/0x6c
>> [drm], CPU#0: kworker/u4:2/36
>> [   55.917538] refcount_t: addition on 0; use-after-free.
>> ...
>> [   56.354928] [<c04898b8>] drm_bridge_attach+0x80/0x208 [drm]
>> ...
>>=20
>> Fixes: 9347f2fbb0183b0 ("drm/bridge: add warning for bridges using
>> neither devm_drm_bridge_alloc() nor drm_bridge_add()")
>> Tested-by: Waldemar Brodkorb <wbx@openadk.org> (on CI20 with HDMI)
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Cc: Waldemar Brodkorb <wbx@openadk.org>
>> Cc: stable@vger.kernel.org
>> ---
>>=20
>> Notes:
>>     v3: fixed a malformed diff
>>    =20
>>     v2: removed ib->bridge->ops =3D DRM_BRIDGE_OP_EDID |
>> DRM_BRIDGE_OP_DETECT as suggested by Sashiko-reviews
>>       =20
>> =
https://sashiko.dev/#/patchset/400ba2fe0d4f76484e929d2efaa32f67a940163a.17=
87477392.git.hns@goldelico.com?part=3D1
>>=20
>>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 23 +++++++++++++++++++--
>> --
>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>> index 42c86f195c66b3..8d7979a7859332 100644
>> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>> @@ -122,7 +122,7 @@ struct ingenic_drm {
>> =20
>> =20
>> - ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,
>> + ib->bridge->interlace_allowed =3D true;
>=20
> That one line feels like it doesn't belong here, but in its own patch.

You are right, it is not a fix but adds a feature.

I'll send a v4 asap.

>=20
> Cheers,
> -Paul

BR,
Nikolaus

