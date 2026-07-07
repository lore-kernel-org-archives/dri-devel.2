Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A09C44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABE010EE52;
	Tue,  7 Jul 2026 16:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X0TUil+d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 462AA10EE3F
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:04:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 30B75403AA
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF3F1F000E9;
 Tue,  7 Jul 2026 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783440243;
 bh=ADGOlt5Fw1FkLx4BzM3JQg3Ehi9SyZVWh9Me1B9E9SI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X0TUil+d20V9S9g/+c1aZZ2GZfLxiTwIKBwxUwaZE8V0kUA4kOKK0RQuyaWO0eerY
 7ofS9nICKsWMpxjzjAi7YSVZCRGtksiSEXjFTXt+eAQ7r29d49feAd7glm7zfoLsPG
 goEma27vtFdKC7xABZAbebmeXW/edKE81HvVmrQ+M89NNDTkQP3LhfTJE3bHdxO26S
 +Pd6CG66ifGs9N0dUlyRqVKsQVkXH3FMMHlDaBNxtBOWOw2TP5hx+s8sLQHLrKG9Oo
 kC9tuciv0hUK4ZZvp9Vfyydv/QGmNw9A+rcJUyfTnc/J/nyta7TURXHoceYRCNB1s4
 ODHfH7XF/k7oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 33/37] drm/omap: venc: Switch to atomic bridge callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-33-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-33-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:04:02 +0000
Message-Id: <20260707160402.DEF3F1F000E9@smtp.kernel.org>
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
- [High] The atomic_enable and atomic_disable bridge callbacks invoke funct=
ions that sleep, violating the DRM atomic context rules.
--

--- Patch [33]: [PATCH v2 33/37] drm/omap: venc: Switch to atomic bridge ca=
llbacks ---
commit d92bb384d028f7e7472ce6ad66e7c5996b3db815
Author: Maxime Ripard <mripard@kernel.org>

drm/omap: venc: Switch to atomic bridge callbacks

The venc bridge uses the legacy non-atomic enable and disable bridge
callbacks.

In order to remove the legacy bridge callback support from the DRM
bridge core, switch to their atomic counterparts and add the bridge
atomic state handlers.

> diff --git a/drivers/gpu/drm/omapdrm/dss/venc.c b/drivers/gpu/drm/omapdrm=
/dss/venc.c
> index 9b5d53dc361e6..5416c668a2055 100644
> --- a/drivers/gpu/drm/omapdrm/dss/venc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/venc.c
[ ... ]
> @@ -614,14 +615,16 @@ static void venc_bridge_mode_set(struct drm_bridge =
*bridge,
>  	dispc_set_tv_pclk(venc->dss->dispc, 13500000);
>  }
> =20
> -static void venc_bridge_enable(struct drm_bridge *bridge)
> +static void venc_bridge_enable(struct drm_bridge *bridge,
> +			       struct drm_atomic_commit *commit)
>  {
>  	struct venc_device *venc =3D drm_bridge_to_venc(bridge);
> =20
>  	venc_power_on(venc);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does calling venc_power_on()
here violate DRM atomic context rules?

The atomic_enable callback can be reached from drm_atomic_helper_commit_tai=
l()
during non-blocking atomic commits, which can be initiated by untrusted
userspace via DRM/KMS operations. This path constitutes an atomic context
where sleeping is strictly forbidden.

However, venc_power_on() internally calls sleeping functions like
regulator_enable() and pm_runtime_get_sync() (via venc_runtime_get()):

drivers/gpu/drm/omapdrm/dss/venc.c:venc_power_on() {
	...
	r =3D venc_runtime_get(venc);
	...
	r =3D regulator_enable(venc->vdda_dac_reg);
	...
}

Calling sleeping functions in this context could cause kernel warnings like
BUG: scheduling while atomic, system instability, or potential deadlocks.

> =20
> -static void venc_bridge_disable(struct drm_bridge *bridge)
> +static void venc_bridge_disable(struct drm_bridge *bridge,
> +				struct drm_atomic_commit *commit)
>  {
>  	struct venc_device *venc =3D drm_bridge_to_venc(bridge);
> =20
>  	venc_power_off(venc);
>  }

[Severity: High]
This is a pre-existing issue, but does venc_power_off() also call sleeping
functions from an atomic context?

Similar to venc_bridge_enable() above, this atomic_disable callback is exec=
uted
from the atomic commit path. If venc_power_off() sleeps, this could also ca=
use
scheduling while atomic warnings and instability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D33
