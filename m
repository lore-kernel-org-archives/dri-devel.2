Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA48C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA89A10EE38;
	Tue,  7 Jul 2026 15:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WmZf3Eco";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BFD10EE38
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:43:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCA4D601EB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EF31F000E9;
 Tue,  7 Jul 2026 15:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783439029;
 bh=qiDY6AjupSbBNKKmf6ye6zote27camPGiHslXsbRS6M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WmZf3EcoAOk2lB68z7q6OdIYGHD8DiIhFExrZGTbO86NSKKTyNNKxvUEYMtcBykvq
 yazvSdM9XN5ebervwVV338cC09C/NZNIp7zA3mJ0kObihCkde+eIiGYvvf4dMuPsFP
 ipK9jJhGgDjVevQw/med4es3Tt5y93u0Vlisi60BfjJSxIbaGvCbWvhMFoh+/h807m
 Wi/LY3+OLwiFtb6QvI/vw3pacJX2yZyY7DArz50rpqc0R8PIlS8zcIaZ3wVaRfzzT/
 NByuwHJB2XWC3Xsx+wB4oTO0orKQkPSEKVykXLwy1CLwfPEPjNSloUPkfTLlykmEcm
 3DWKBGISK48bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/37] drm/bridge: ti-tpd12s015: Add atomic bridge
 state handlers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-23-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-23-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:43:48 +0000
Message-Id: <20260707154349.69EF31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Release of devm-managed GPIOs if the bridge is accessed =
after the platform device unbinds.
- [High] Race condition where the HPD IRQ is active before its associated m=
utexes are initialized, and remains active after they are destroyed.
--

--- Patch [23]: [PATCH v2 23/37] drm/bridge: ti-tpd12s015: Add atomic bridg=
e state handlers ---
commit 8627a6c33db1265257320b25744b5861c235ec83
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: ti-tpd12s015: Add atomic bridge state handlers

The ti-tpd12s015 bridge doesn't implement any enable or disable callbacks,
but is still missing the atomic state handlers. In order to remove the lega=
cy
bridge callback support from the DRM bridge core, add them.

> diff --git a/drivers/gpu/drm/bridge/ti-tpd12s015.c b/drivers/gpu/drm/brid=
ge/ti-tpd12s015.c
> index 136e47ad1a10d..e7b172ab7f552 100644
> --- a/drivers/gpu/drm/bridge/ti-tpd12s015.c
> +++ b/drivers/gpu/drm/bridge/ti-tpd12s015.c
[ ... ]
> @@ -96,6 +97,9 @@ static void tpd12s015_hpd_disable(struct drm_bridge *br=
idge)
>  }
> =20
>  static const struct drm_bridge_funcs tpd12s015_bridge_funcs =3D {
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.attach			=3D tpd12s015_attach,
>  	.detach			=3D tpd12s015_detach,
>  	.detect			=3D tpd12s015_bridge_detect,

[Severity: High]
This isn't a bug introduced by this patch, but could this detect callback
race with driver unbinding and cause a use-after-free?

The DRM core holds a reference to the bridge, allowing it to outlive the
platform device's devres lifecycle. However, the GPIO descriptors are
allocated using devm_gpiod_get_index() in tpd12s015_probe():

gpio =3D devm_gpiod_get_index(&pdev->dev, NULL, 2, GPIOD_IN);

If the platform device unbinds, devres frees the GPIOs. If the still-attach=
ed
bridge's detect callback (tpd12s015_detect) is then invoked by the DRM core,
it accesses the freed GPIO:

if (gpiod_get_value_cansleep(tpd->hpd_gpio))

Will this cause memory corruption or a kernel oops if the bridge is accessed
after the device unbinds?


[Severity: High]
This is another pre-existing issue, but is there a potential race condition
with the HPD IRQ and bridge mutex initialization?

In tpd12s015_probe(), the HPD IRQ is requested via devm before
drm_bridge_add() initializes bridge->hpd_mutex:

ret =3D devm_request_threaded_irq(&pdev->dev, tpd->hpd_irq, NULL,
                                tpd12s015_hpd_isr, ...);

If an interrupt fires immediately, tpd12s015_hpd_isr() calls
drm_bridge_hpd_notify(), which attempts to lock the uninitialized hpd_mutex.

Similarly, in tpd12s015_remove():

drm_bridge_remove(&tpd->bridge);

drm_bridge_remove() is called to destroy the mutexes while the devm-managed
IRQ is still active. Can this lead to locking an uninitialized or destroyed
mutex if the HPD pin toggles during probe or removal?

>  	.hpd_enable		=3D tpd12s015_hpd_enable,
>  	.hpd_disable		=3D tpd12s015_hpd_disable,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D23
