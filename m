Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDD5C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2A810EE00;
	Tue,  7 Jul 2026 15:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PCB/2I/1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82C610EE00
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:39:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D00F61878
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2991F000E9;
 Tue,  7 Jul 2026 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783438740;
 bh=vd98bss+JgeR7uJJv5zPKlTlc7XQZWxAXKDlDlGD878=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PCB/2I/15AjLSEw4Ib8iRvGWVGwhQ7cb90sr936t10fVF4hstd+fHDcbfCSlWjqsV
 u5WGlNTwtK0pMjMvInX4MtNsQHNFUoIltxRDg3xbDHXBxr7XNBCHUHL5ZkgSach/1X
 6MwM3D/pqmVmO4nLB+Ywdsj+Tm1DPof2h3R3LTwEbwkZ+p/3RrDuwX1P5F2nPi+Mx/
 1M2T+hS+7cUPa5UPueniUqcsJb+2kLpjGo5TfnDID6/Dcp253L4p68qohkXXk2JMBf
 v3MS/XaYnV8i4m1BLS9zN7RzQUiefbIhaRqZx61DwMnzW25lG+Nfnd3dLNH9+PU9/W
 xpCiK4wixn72A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/37] drm/bridge: parade-ps8622: Switch to atomic
 bridge callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-16-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-16-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:39:00 +0000
Message-Id: <20260707153900.AE2991F000E9@smtp.kernel.org>
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
- [High] Bridge atomic callbacks use sleeping functions (`msleep`, `usleep_=
range`) while running in an atomic context path.
--

--- Patch [16]: [PATCH v2 16/37] drm/bridge: parade-ps8622: Switch to atomi=
c bridge callbacks ---
commit 6103d7b41fd50ff49b7002eef1519ecf77486219
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: parade-ps8622: Switch to atomic bridge callbacks

This commit updates the parade-ps8622 bridge to use atomic bridge callbacks
instead of the legacy ones. The functions have been updated to accept the
drm_atomic_commit state handlers.

> diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bri=
dge/parade-ps8622.c
> index f879a1df077d2..33844db753aa5 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8622.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8622.c
> @@ -336,7 +336,8 @@ static const struct backlight_ops ps8622_backlight_op=
s =3D {
>  	.update_status	=3D ps8622_backlight_update,
>  };
> =20
> -static void ps8622_pre_enable(struct drm_bridge *bridge)
> +static void ps8622_pre_enable(struct drm_bridge *bridge,
> +			      struct drm_atomic_commit *commit)
>  {
>  	struct ps8622_bridge *ps8622 =3D bridge_to_ps8622(bridge);
>  	int ret;

[Severity: High]
This is a pre-existing issue, but this function calls a sleeping function
further down in the body:

	usleep_range(PS8622_RST_HIGH_T2_MIN_US + PS8622_POWER_RISE_T1_MAX_US,
		     PS8622_RST_HIGH_T2_MAX_US + PS8622_POWER_RISE_T1_MIN_US);

Could this cause kernel warnings or deadlocks? The drm_atomic_helper_commit=
_tail()
path directly invokes these bridge atomic callbacks, and sleeping is forbid=
den
in this atomic context.

[ ... ]

> @@ -381,13 +382,15 @@ static void ps8622_pre_enable(struct drm_bridge *br=
idge)
>  	ps8622->enabled =3D true;
>  }
> =20
> -static void ps8622_disable(struct drm_bridge *bridge)
> +static void ps8622_disable(struct drm_bridge *bridge,
> +			   struct drm_atomic_commit *commit)
>  {
>  	/* Delay after panel is disabled */
>  	msleep(PS8622_PWMO_END_T12_MS);

[Severity: High]
This isn't a bug introduced by this patch, but does calling msleep() here
violate the atomic context requirements?

This callback can be executed from drm_atomic_helper_commit_tail() where
sleeping is forbidden.

>  }
> =20
> -static void ps8622_post_disable(struct drm_bridge *bridge)
> +static void ps8622_post_disable(struct drm_bridge *bridge,
> +				struct drm_atomic_commit *commit)
>  {
>  	struct ps8622_bridge *ps8622 =3D bridge_to_ps8622(bridge);

[Severity: High]
This is a pre-existing issue, but similar to the other callbacks, this path
also contains calls to sleeping functions later in the body:

	usleep_range(PS8622_POWER_FALL_T16_MAX_US,
		     2 * PS8622_POWER_FALL_T16_MAX_US);
	...
	msleep(PS8622_POWER_OFF_T17_MS);

Is it safe to use sleeping functions here since this bridge atomic
callback also runs in an atomic context path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D16
