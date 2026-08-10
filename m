Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25FEC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98E710E700;
	Mon, 10 Aug 2026 07:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DgSc0U6q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D53F10E700
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:22:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9146F600AB;
 Mon, 10 Aug 2026 07:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABD61F000E9;
 Mon, 10 Aug 2026 07:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786346577;
 bh=Mt5U2irxMyfNZGaozbb0hKyUbVB2/Gg0vCmI/NA75FY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DgSc0U6quEBCZkFtjBrJQxYfFW9IRv2cv1NqoCUu1EAzw97Fn6qznm9wPVx4V7PFw
 IPswLYKWSuyIf+nnbCl3ulClg1mVWSuWVeJ0ZBZI8DqB850HTPem4a/QuFZUxv+qxw
 FdTCoETpYlhIEyFIn/RpvS/6pZ02fEBdrSjphRkDLm+45Xgi8IjaDtDdRwUV+QjVf5
 /oL31fiiUh+706vDjnhYAk8bCQOuFZvkO0tVM5NRris1mw3KOmjtHXh7QwqHm4jtmx
 ikpdaVeRzGX7VX1rEd2faopbV18Kpvg6vQbdZGBhPCjldgvdlYFrDQZFRHlpDopVlz
 GjCtrIEU5GpjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] drm/bridge: nwl-dsi: Add error handling of
 nwl_dsi_mode_set()
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810-nwl-dsi-fixes-v3-4-256da9d672e1@geanix.com>
References: <20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com>
 <20260810-nwl-dsi-fixes-v3-4-256da9d672e1@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 07:22:56 +0000
Message-Id: <20260810072257.2ABD61F000E9@smtp.kernel.org>
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
- [High] Unbalanced resource teardown and PM runtime underflow in mode_set =
error path.
--

--- Patch [4]: [PATCH v3 4/5] drm/bridge: nwl-dsi: Add error handling of nw=
l_dsi_mode_set() ---
commit 0db3c1cc2f73a9bc66aea2633f754029dd76b743
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: nwl-dsi: Add error handling of nwl_dsi_mode_set()

This commit adds a return value check for nwl_dsi_mode_set() in
nwl_dsi_bridge_mode_set(), jumping to an error path on failure.

> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nw=
l-dsi.c
> index 3fd41212933c8..e90588299c5ea 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -884,7 +884,9 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  	}
> =20
>  	/* Step 2 from DSI reset-out instructions */
> -	nwl_dsi_mode_set(dsi);
> +	ret =3D nwl_dsi_mode_set(dsi);
> +	if (ret < 0)
> +		goto runtime_put;

[Severity: High]
This is a pre-existing issue, but does taking the runtime_put error path he=
re
lead to unbalanced resource teardown and PM runtime underflows?

Because the drm_bridge_funcs.mode_set callback returns void, failures canno=
t be
propagated to the DRM core to abort the commit. If nwl_dsi_mode_set() fails=
 and
jumps to runtime_put, it calls pm_runtime_put_sync() and returns early.=20

However, the DRM core still considers the bridge pipeline state to be 'enab=
led',
and will unconditionally call nwl_dsi_bridge_atomic_disable() during the ne=
xt
pipeline teardown.

When atomic_disable() runs, it unconditionally calls pm_runtime_put(), lead=
ing
to a reference count underflow:

drivers/gpu/drm/bridge/nwl-dsi.c:nwl_dsi_bridge_atomic_disable() {
	...
	pm_runtime_put(dsi->dev);
}

Furthermore, atomic_disable() unconditionally calls nwl_dsi_disable(), which
blindly attempts to tear down the PHY:

drivers/gpu/drm/bridge/nwl-dsi.c:nwl_dsi_bridge_atomic_disable() {
	...
	nwl_dsi_disable(dsi);
	...
}

Since nwl_dsi_mode_set() already cleans up its own PHY resources on internal
failure, this double-disable pushes the PHY framework's power_count and
init_count to -1. The next attempt to initialize the display will increment
these counters to 0, skipping the actual hardware ops->power_on() and
ops->init() calls, permanently leaving the display broken until the module =
is
reloaded.

While this broken error path already existed for clock initialization failu=
res
in this function, wiring up nwl_dsi_mode_set's return value to it exposes t=
he
PHY breakage on a new failure path.

> =20
>  	/* Step 3 from DSI reset-out instructions */
>  	ret =3D reset_control_deassert(dsi->rst_esc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-nwl-dsi-fi=
xes-v3-0-256da9d672e1@geanix.com?part=3D4
