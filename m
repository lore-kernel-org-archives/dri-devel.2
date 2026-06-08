Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677E7CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B0310F70B;
	Mon,  8 Jun 2026 16:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yc5K74xc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD63510F70B
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:33:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1090660098
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFBC1F00893;
 Mon,  8 Jun 2026 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780936400;
 bh=jrbUQqA7fVSvdOrXQBo6sEPuHXv3tEo0P5qWn6KrEuc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Yc5K74xcXq6Ie/MfVfRo8Iy7vUcbueO6ZCziM97J0l/i4v4dDOMKPHZ8FoTcKLs3p
 19atrLL6m+cfmC9Gd2h+BFyGnbIceLdE7wnRIiYBU2Qrc60jXHZwVafTlro5UZsi8t
 F79QUBKsHR8US3e3DPIA+3/BoC3JbwfJUaG01lYj06MWZVfMbazNW9N4vJEXhOHFBw
 Dy2PcNaKc7AdE2osKWnkdkXHgMZ6pCgKYwFHbTI3iK/9wOENf26ZiE1WWSsw9Om6bQ
 2uZ1UH+Nh39qCVEHLuWM5pK5XYX3D2un5DKcSFPV+mcPwfzgA5WupGHwBzOsaXn4Ey
 CiAHFUqqZPA4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 32/78] drm/bridge: ssd2825: Switch to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-32-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-32-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:33:20 +0000
Message-Id: <20260608163320.9AFBC1F00893@smtp.kernel.org>
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
- [High] Stack-allocated buffers are used for SPI transfers, leading to pot=
ential stack memory corruption if the SPI controller maps them for DMA.
--

commit d2236b7da6130a7a64f424b8a7d39ff467bd42ef
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: ssd2825: Switch to atomic_create_state

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

> diff --git a/drivers/gpu/drm/bridge/ssd2825.c b/drivers/gpu/drm/bridge/ss=
d2825.c
> index 91f1510fc2d40..e345f3a652c2e 100644
> --- a/drivers/gpu/drm/bridge/ssd2825.c
> +++ b/drivers/gpu/drm/bridge/ssd2825.c
> @@ -680,7 +680,7 @@ static const struct drm_bridge_funcs ssd2825_bridge_f=
uncs =3D {
>  	.atomic_enable =3D ssd2825_bridge_atomic_enable,
>  	.atomic_disable =3D ssd2825_bridge_atomic_disable,
> =20
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that
ssd2825_write_raw() and ssd2825_read_raw() use stack-allocated buffers for =
SPI
transfers.

If the underlying SPI controller supports DMA, these buffers will be mapped=
 via
the DMA API. Since stack variables are not guaranteed to be cacheline-align=
ed,
DMA cache maintenance operations might corrupt adjacent stack frames, return
addresses, or local variables.

In drivers/gpu/drm/bridge/ssd2825.c:ssd2825_write_raw():

        u8 tx_buf[2];
        ...
        tx_buf[0] =3D low_byte;
        tx_buf[1] =3D high_byte;

        return spi_write(spi, tx_buf, 2);

And in drivers/gpu/drm/bridge/ssd2825.c:ssd2825_read_raw():

        u8 tx_buf[2];
        u8 rx_buf[2];
        ...
        ret =3D spi_sync(spi, &msg);

Could these stack allocations cause unpredictable memory corruption or pani=
cs
if a DMA-capable SPI controller maps them?

>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D32
