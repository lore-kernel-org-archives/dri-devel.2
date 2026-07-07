Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE7EC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D6F10E283;
	Tue,  7 Jul 2026 15:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mSNEKNBV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8514910E283
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:51:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF49360018
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728F51F000E9;
 Tue,  7 Jul 2026 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783439499;
 bh=ejyxLdxO5YSGlgGugBLvj6WAVBa2gWIeCx/VJqEtD10=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mSNEKNBVDCm6G1LK22e6HN8ApAlEgqPm4R2Rik53u3S3uEiU3Q+Z5gBv5mOwAYXnM
 hwNhgSQGpBY1lk02e30G9fxUvsayz5WxeOQarA9BQGMA+n1pxsT1akLoRv2Y1FPfmE
 9GTxKaFCn5/Vseo1nBb83K44y1CduDSuL2QtaGZoCgpzahfaTW/PUL18iHQbw9TWEh
 JeD+PymxvG781h4U988/Taf8Y9QZsLWos6kwVD9fhqBCNqMfPID/CgSLn+6bosSoSV
 ISyiBzAdw5TNxKZ4fMeCI6J+IQrNsWB2VPHqdlgDSOBSMEe8n2sxdV/FtgahE7JJD2
 9vseXpL6h41Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 25/37] drm/bridge: waveshare-dsi: Switch to atomic
 bridge callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-25-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-25-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:51:39 +0000
Message-Id: <20260707155139.728F51F000E9@smtp.kernel.org>
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
- [High] Freed `regmap` and `backlight` resources are accessed during `atom=
ic_enable` and `atomic_disable` if the driver is unbound while the bridge i=
s still attached.
- [High] The bridge's atomic_enable and atomic_disable callbacks execute sl=
eeping functions, violating atomic context requirements.
--

--- Patch [25]: [PATCH v2 25/37] drm/bridge: waveshare-dsi: Switch to atomi=
c bridge callbacks ---
commit 5ef73541c5abfd37236a332fd681aeaf873d8239
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: waveshare-dsi: Switch to atomic bridge callbacks
   =20
The waveshare-dsi bridge uses the legacy non-atomic enable and disable
bridge callbacks. In order to remove the legacy bridge callback support
from the DRM bridge core, switch to their atomic counterparts and add the
bridge atomic state handlers.

> diff --git a/drivers/gpu/drm/bridge/waveshare-dsi.c b/drivers/gpu/drm/bri=
dge/waveshare-dsi.c
> index ded57f298d640..9c9825c9b7c59 100644
> --- a/drivers/gpu/drm/bridge/waveshare-dsi.c
> +++ b/drivers/gpu/drm/bridge/waveshare-dsi.c

[ ... ]

> @@ -92,7 +93,8 @@ static int ws_bridge_bridge_attach(struct drm_bridge *b=
ridge,
>  				 &ws->bridge, flags);
>  }
> =20
> -static void ws_bridge_bridge_enable(struct drm_bridge *bridge)
> +static void ws_bridge_bridge_enable(struct drm_bridge *bridge,
> +				    struct drm_atomic_commit *commit)
>  {
>  	struct ws_bridge *ws =3D bridge_to_ws_bridge(bridge);
> =20
>  	regmap_write(ws->reg_map, 0xad, 0x01);
>  	backlight_enable(ws->backlight);

[Severity: High]
This isn't a bug introduced by this patch, but does accessing ws->reg_map a=
nd
ws->backlight here risk a use-after-free if the driver is unbound?

The bridge object is managed by DRM and stays alive as long as it's attached
to the encoder. However, the regmap and backlight resources are device-mana=
ged
(devm) and are freed immediately upon driver unbind (e.g., manual unbind via
sysfs or hardware hot-unplug).

If a modeset or DPMS change occurs after unbind, the DRM core calls the
bridge's atomic_enable callback, which dereferences the freed ws->reg_map a=
nd
ws->backlight.

[Severity: High]
This is a pre-existing issue, but does calling sleeping functions from this
atomic callback violate context requirements?

According to the DRM subsystem guidelines, drm_atomic_helper_commit_tail()
(which calls these bridge callbacks) executes in atomic context where sleep=
ing
is forbidden.

However, ws_bridge_bridge_enable() calls regmap_write() (which uses an I2C
transfer and acquires a mutex) and backlight_enable() (which acquires a mut=
ex),
both of which can sleep.

>  }
> =20
> -static void ws_bridge_bridge_disable(struct drm_bridge *bridge)
> +static void ws_bridge_bridge_disable(struct drm_bridge *bridge,
> +				     struct drm_atomic_commit *commit)
>  {
>  	struct ws_bridge *ws =3D bridge_to_ws_bridge(bridge);
> =20
>  	backlight_disable(ws->backlight);
>  	regmap_write(ws->reg_map, 0xad, 0x00);

[Severity: High]
This is a pre-existing issue, but similar to the enable path, could these
calls result in a use-after-free or violate atomic context requirements?

If a modeset or DPMS change occurs after the driver is unbound, atomic_disa=
ble
will dereference the freed ws->reg_map and ws->backlight. Additionally,
calling backlight_disable() and regmap_write() executes sleeping functions =
in
atomic context.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D25
