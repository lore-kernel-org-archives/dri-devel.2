Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F3DC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82FF610EE4D;
	Tue,  7 Jul 2026 16:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H3DX4lxW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6915710EE4D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:08:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF68160018
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D64F1F000E9;
 Tue,  7 Jul 2026 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783440511;
 bh=HF3yoTEEP+Eya1X1adqRns4/TM9m/iUcfp/m5+tV4hc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H3DX4lxW60RmxdmQbFQ5jmZoOuayH4Ker0eu3hH63gej8iSRWokCaRvsWPLbuWMGE
 m2p6bKuHfd/iWZWo+QkyqkChq4jaKle3qrFFxB/sybaRVPeGcE80EdIxfXKhibAfN9
 Z1zhjfA5G2clUH7LK0jPZ3cM0ELyOW95bNfMmYpC3SMmFAdy759TGZFolpzPVXuNtj
 PsNW+8FyHIDJM4X/rJO6tW2jZP8AZ4TPqs2jaCcHSBgxDtQaADuiC2viQL0fdMXMvM
 0+5PEzBhovom0IyNvREjmL8TYdS06RpMYjRJB4z+VH2sySp7AslIp3O0KW7PgJDqAq
 /zgyl+g+bRx/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 30/37] drm/omap: dpi: Switch to atomic bridge callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-30-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-30-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:08:30 +0000
Message-Id: <20260707160831.5D64F1F000E9@smtp.kernel.org>
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
- [High] Unbalanced resource teardown on bridge enable error paths leads to=
 PM runtime underflow and kernel panic.
--

--- Patch [30]: [PATCH v2 30/37] drm/omap: dpi: Switch to atomic bridge cal=
lbacks ---
commit 6fda2bd3a893061ddf4b74080bd409f4c3cc6741
Author: Maxime Ripard <mripard@kernel.org>

drm/omap: dpi: Switch to atomic bridge callbacks

The dpi bridge uses the legacy non-atomic enable and disable bridge
callbacks.  In order to remove the legacy bridge callback support from the
DRM bridge core, switch to their atomic counterparts and add the bridge
atomic state handlers.

> diff --git a/drivers/gpu/drm/omapdrm/dss/dpi.c b/drivers/gpu/drm/omapdrm/=
dss/dpi.c
> index 9f86db774c395..419915e338163 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dpi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dpi.c

[ ... ]

> @@ -482,7 +483,8 @@ static void dpi_bridge_mode_set(struct drm_bridge *br=
idge,
>  	dpi->pixelclock =3D adjusted_mode->clock * 1000;
>  }
> =20
> -static void dpi_bridge_enable(struct drm_bridge *bridge)
> +static void dpi_bridge_enable(struct drm_bridge *bridge,
> +			      struct drm_atomic_commit *commit)
>  {
>  	struct dpi_data *dpi =3D drm_bridge_to_dpi(bridge);
>  	int r;

[Severity: High]
This is a pre-existing issue, but does this early return on failure lead to
unbalanced resource teardown and a potential kernel panic?

Looking at dpi_bridge_enable() in drivers/gpu/drm/omapdrm/dss/dpi.c, if
initialization fails, the function cleans up and returns early:

	if (dpi->vdds_dsi_reg) {
		r =3D regulator_enable(dpi->vdds_dsi_reg);
		if (r)
			return;
	}

Because the callback returns void, the DRM core considers the bridge enable=
d.
During pipeline teardown, dpi_bridge_disable() executes and unconditionally
drops a PM runtime reference:

	dispc_runtime_put(dpi->dss->dispc);

Since the failed dpi_bridge_enable() never acquired (or already cleaned up)
this PM runtime reference, does this extra put operation incorrectly drop t=
he
reference held by the CRTC (omap_crtc_atomic_enable())?

If this drops the DISPC PM runtime usage count to 0 and immediately powers
down the dispc hardware, could the later call to drm_crtc_vblank_off() from
omap_crtc_atomic_disable() access powered-down DISPC registers and trigger
an L3 bus error or imprecise external abort?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D30
