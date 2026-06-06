Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68531CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 19:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB8D510E85D;
	Sat,  6 Jun 2026 19:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bz+ldM7s";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC7D10E85D
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 19:42:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDA25600AE;
 Sat,  6 Jun 2026 19:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FD71F00893;
 Sat,  6 Jun 2026 19:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780774963;
 bh=jAzdkDGNLoGjQ7YCDenK1UV/7PlT9nAPJpRlJn+Lcyc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bz+ldM7snR6aLTrV5EDoYea0tsyPcBLP2Ethb4ja0yZh8Y7PsQTG/PQpBFMZB6RLZ
 KBt6++KpDHCaSh7Hy+rNQ3gKBTi0GF8H0Ok5U7xT+D2/2uemZL3/hzp+Qyv3DR8pTL
 ZvUnY8EC1Uf3LRfSGwZfg85zHCfenH7XQtoRZJgjBBN0UxW3zMHVzFxOVx9uJq31aZ
 UQLMJ1MbiCHbYqFpjxdZyjebG9ztwu5JVYSQm+MFOqA1NURXeLwKLkWbXGisMPQKDI
 Wnod8livojWqI4A04RMJS9wBwmrEM4RUtXcgHPp+2w7TzeI92gi44BAZ7ynK6NrhzX
 4FeOdULWzpXYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] drm/bridge: simple-bridge: replace deprecated DRM
 logging macros
To: "Piyush Patle" <piyushpatle228@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260606193625.24465-2-piyushpatle228@gmail.com>
References: <20260606193625.24465-2-piyushpatle228@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 19:42:42 +0000
Message-Id: <20260606194243.43FD71F00893@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but proceeding with =
hardware enablement after a power regulator failure can cause hardware dama=
ge. In `simple_bridge_enable()`, if `regulator_enable(sbridge->vdd)` fails,=
 an error is logged but the function continues and unconditionally asserts =
the `enable` GPIO. Driving logic signals into an unpowered integrated circu=
it can back-power the chip through its IO pins, potentially leading to latc=
h-up or permanent hardware damage. The function should abort early if the r=
egulator fails to enable.
--

commit db4bbe0cc09da9b2a76aa9fd998d0133aa578bd2
Author: Piyush Patle <piyushpatle228@gmail.com>

drm/bridge: simple-bridge: replace deprecated DRM logging macros

Replace deprecated DRM_ERROR() and DRM_INFO() with device-aware
drm_err() and drm_info(), passing bridge->dev or connector->dev.

> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bri=
dge/simple-bridge.c
> index 8aa31ca3c72d4..d8457e68c342f 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c

[ ... ]

> @@ -140,7 +140,7 @@ static void simple_bridge_enable(struct drm_bridge *b=
ridge)
>  	if (sbridge->vdd) {
>  		ret =3D regulator_enable(sbridge->vdd);
>  		if (ret)
> -			DRM_ERROR("Failed to enable vdd regulator: %d\n", ret);
> +			drm_err(bridge->dev, "Failed to enable vdd regulator: %d\n", ret);
>  	}
> =20
>  	gpiod_set_value_cansleep(sbridge->enable, 1);

[Severity: High]
This isn't a bug introduced by this patch, but does proceeding with hardware
enablement after a power regulator failure risk hardware damage?

If regulator_enable() fails for sbridge->vdd, an error is logged, but the
function continues and unconditionally asserts the enable GPIO in
simple_bridge_enable().

Driving logic signals into an unpowered integrated circuit can back-power
the chip through its IO pins, potentially leading to latch-up or permanent
hardware damage.

Should the function abort early if the regulator fails to enable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606193625.2446=
5-1-piyushpatle228@gmail.com?part=3D1
