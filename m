Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4844C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E52710EBFC;
	Wed, 22 Jul 2026 01:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M+ZeHK8z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75FBF10EBFC
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:12:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1F07600FC;
 Wed, 22 Jul 2026 01:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450EB1F000E9;
 Wed, 22 Jul 2026 01:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784682763;
 bh=DU5lHwHbZcBB00a2hM0TqBYsiGQSL2t9fEAtpMdRRkU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M+ZeHK8zQT44+s40q1nwklIg3WbtkbrLM/cql2mNqphT/khS/sVCBpvgi2h27Hmmz
 vxGKMxaiE/8z0QUnjjt7utaDLcRj4x3S9FCroK39eAmR+LPlcZ4+OGnZuoWuYxCdSM
 jx1vo5k/D9SAL/KEc8i12733Kfu3LpPj8jDhUfAEIWYvla3DVxdgAkfl26cEhRykE1
 thPXpLY/k0S0hA8nykblLBBwfnHPwK+MWFHF93aALmvsff/cEjcUTsTGYx8UEL+Olu
 XExjAeUC3vLxPOQjIjtPPMhj7ee8utKlGAfc7606BwAERbsKdwFDCN7Xpg1sKH2maB
 Ca+JLa6xVqf0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] drm/bridge: it6505: Don't reject audio hw_params
 without an encoder
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2c08315fede798f8632fe985da5ffd568c945de3.1784681487.git.daniel@makrotopia.org>
References: <cover.1784681487.git.daniel@makrotopia.org>
 <2c08315fede798f8632fe985da5ffd568c945de3.1784681487.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 01:12:42 +0000
Message-Id: <20260722011243.450EB1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Division by zero kernel panic in `__it6505_enable_audio()` when `R=
EG_AUDIO_INPUT_FREQ` reads 0.
--

--- Patch [5]: [PATCH v4 5/5] drm/bridge: it6505: Don't reject audio hw_par=
ams without an encoder ---
commit ce61845cbb90df0a24913039e8ff09c7c4ff53e7
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: Don't reject audio hw_params without an encoder
   =20
This commit drops the encoder check in it6505_audio_setup_hw_params() to
ensure stream parameters are always cached, even when no display is attache=
d.
It also moves the application of audio parameter defaults to probe time.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 6bb5db565ccac..e01d57b0166a8 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -3004,9 +2994,6 @@ static int it6505_audio_setup_hw_params(struct it65=
05 *it6505,
>  			     params->sample_rate, params->sample_width,
>  			     params->cea.channels);
> =20
> -	if (!it6505->bridge.encoder)
> -		return -ENODEV;
> -

[ ... ]

[Severity: High]
This is a pre-existing issue, but can this code cause a division by zero ke=
rnel
panic?

Looking at __it6505_enable_audio() in drivers/gpu/drm/bridge/ite-it6505.c,=
=20
if it6505_read() returns 0 (e.g. if no I2S clock is present or the read fai=
ls),=20
regbe is used as a denominator:

	regbe =3D it6505_read(it6505, REG_AUDIO_INPUT_FREQ);
	DRM_DEV_DEBUG_DRIVER(dev, "regbe:0x%02x audio input fs: %d.%d kHz",
			     regbe, 6750 / regbe, (6750 % regbe) * 10 / regbe);

When DRM debugging is enabled, this would evaluate the arguments and divide=
 by
zero. Should there be a check to ensure regbe is non-zero before it is used=
 in
the DRM_DEV_DEBUG_DRIVER macro?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784681487.gi=
t.daniel@makrotopia.org?part=3D5
