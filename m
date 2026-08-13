Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFC6C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B1010F48F;
	Thu, 13 Aug 2026 18:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qi+eDstf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627EC10F48F
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:03:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C8056600B0;
 Thu, 13 Aug 2026 18:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4E71F00A3A;
 Thu, 13 Aug 2026 18:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786644223;
 bh=3xoJxc9VrgvGCU3xP+w9TNsFdFtgrt22mhUHc7kG7FE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qi+eDstfakK/U2GAg2bc13MqCjNkb620YoSuAppjs8ciHkUg5LmoPLhuRmgWMo4Ex
 Cp2fnxd/rLO7GGlQOxbYZiYrsM5+pS/13fTD2iFZW6nIQnMe16D1GM1JoapqHQF4TQ
 pZ/XdQ1XckNdk4Wn637840cuQwX+cIKeT1iPfDeW1IITof8fJ53bk+Q+uAR2uzdhiV
 33qrXQJrrHpr/L7eCf7UFVdScGu1yI2NCEAatI2gP6hvAIbboD7T5/8Cz5P7s5jjKj
 Lqs52IFFPsK2BQ5VeHnHWleMc5D/DA9MrYk9jQYGpg2FkraRoq8XjHm1rQ3BNHz0k7
 7Iz/E+D/UbLUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] drm/nouveau/kms/nv50-: Enable atomic modesetting
 by default
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813174416.1812656-6-lyude@redhat.com>
References: <20260813174416.1812656-1-lyude@redhat.com>
 <20260813174416.1812656-6-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 18:03:42 +0000
Message-Id: <20260813180343.5F4E71F00A3A@smtp.kernel.org>
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
- [Medium] The patch completely fails to enable atomic modesetting by defau=
lt on nv50+ hardware and introduces a spurious warning on every boot for le=
gacy hardware.
--

--- Patch [5]: [PATCH v6 5/5] drm/nouveau/kms/nv50-: Enable atomic modesett=
ing by default ---
commit 72a6dbf310da7445e59ffec7fdf8ec40a1396882
Author: Lyude Paul <lyude@redhat.com>
drm/nouveau/kms/nv50-: Enable atomic modesetting by default

This commit aims to enable atomic modesetting by default on nv50+ hardware
while retaining a module parameter to turn it off if regressions occur.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 82a8061e6d3e2..8ee36c5d79fdb 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -745,7 +745,7 @@ nouveau_drm_device_new(struct device *parent, struct =
nvkm_device *device)
>  		else
>  			driver =3D &driver_legacy_kms;
>  	} else {
> -		if (nouveau_atomic)
> +		if (nouveau_atomic !=3D -1)

[Severity: Medium]
Does this inadvertently leave atomic modesetting disabled by default on
nv50+ hardware, and introduce a regression where spurious warnings are
printed on older hardware?

Looking at nouveau_drm_device_new(), the check above this else block for nv=
50+
hardware remains unmodified:

	if (device->card_type >=3D NV_50) {
		if (nouveau_atomic)
			driver =3D &driver_atomic_kms;
		else
			driver =3D &driver_legacy_kms;
	}

Since the module parameter nouveau_atomic remains initialized to 0, atomic
modesetting remains disabled by default on nv50+, which seems to defeat the
purpose described in the commit message.

Additionally, for pre-nv50 hardware, the modified condition=20
(nouveau_atomic !=3D -1) now evaluates to true by default (0 !=3D -1), whic=
h will
cause this dev_warn() to print spuriously on every boot.

>  			dev_warn(parent, "Atomic modesetting not supported (needs nv50+)\n");
> =20
>  		driver =3D &driver_legacy_kms;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813174416.1812=
656-1-lyude@redhat.com?part=3D5
