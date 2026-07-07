Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92205C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E5E10E2DB;
	Tue,  7 Jul 2026 15:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E37zCzDa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC5A10E2DB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:52:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 93AAB60018
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDF01F000E9;
 Tue,  7 Jul 2026 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783439542;
 bh=j2UybkpBiwi2M1C5YAAOz344Zemn+r5D5Wat4r/DeDU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E37zCzDarBHwW68cpky4P0wHA4mT3gzcavmWXoeg3hk0naokLk9dciT9Jkz1FMgb0
 2fiDan+rt9b5RImF7r0zalsxipvfnXFR9cENm9wc4JZS9nFJghVyVZWcD1Csw8S6+/
 gp9lqs7hIuV3otqFTTamfQ7+dvxyipk2hFN9PxotVq+wOlMI+cy8yu1a89e/bEJTSi
 qARqUMTY4aVL6U/6sNK/dWRB7oDkZ5rwZKz3wFS45T2vTxojIZHYcJ3IykHecXGrO+
 suTlq/U7iVmPCfiu7DuiIcCq1hP3h5fj0Ja1xxSkR/qKXvzehER0aBMwl4KWgHyhhy
 dQbum73qzegMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/37] drm/bridge: tda998x: Switch to atomic bridge
 callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-21-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-21-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:52:21 +0000
Message-Id: <20260707155222.2BDF01F000E9@smtp.kernel.org>
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
- [High] The atomic_enable and atomic_disable bridge callbacks call sleepin=
g functions but execute in an atomic context.
--

--- Patch [21]: [PATCH v2 21/37] drm/bridge: tda998x: Switch to atomic brid=
ge callbacks ---
commit 3c3197b45d3a1fb57e72b15de2a23cbccfa9ab6d
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: tda998x: Switch to atomic bridge callbacks

This patch switches the tda998x bridge driver from legacy non-atomic enable
and disable callbacks to their atomic counterparts. It updates the callback
signatures and the drm_bridge_funcs structure accordingly.

> diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridg=
e/tda998x_drv.c
> index 6c427bc75896b..16c7455911758 100644
> --- a/drivers/gpu/drm/bridge/tda998x_drv.c
> +++ b/drivers/gpu/drm/bridge/tda998x_drv.c
[ ... ]
> @@ -1410,7 +1410,8 @@ static enum drm_mode_status tda998x_bridge_mode_val=
id(struct drm_bridge *bridge,
>  	return MODE_OK;
>  }
> =20
> -static void tda998x_bridge_enable(struct drm_bridge *bridge)
> +static void tda998x_bridge_enable(struct drm_bridge *bridge,
> +				  struct drm_atomic_commit *commit)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but will this cause sleeping in
atomic context warnings or deadlocks?

The tda998x_bridge_enable() callback executes in an atomic context under
drm_atomic_helper_commit_tail(), where sleeping is forbidden. However, it
calls reg_write():

static void tda998x_bridge_enable(...)
{
	...
	if (!priv->is_on) {
		reg_write(priv, REG_ENA_VP_0, 0xff);

which takes a mutex (mutex_lock(&priv->mutex)) and initiates an I2C
transfer, both of which can sleep. Migrating to the atomic_enable hook
retains this behavior in the atomic commit path.

>  	struct tda998x_priv *priv =3D bridge_to_tda998x_priv(bridge);
> =20
[ ... ]
> @@ -1428,7 +1429,8 @@ static void tda998x_bridge_enable(struct drm_bridge=
 *bridge)
>  	}
>  }
> =20
> -static void tda998x_bridge_disable(struct drm_bridge *bridge)
> +static void tda998x_bridge_disable(struct drm_bridge *bridge,
> +				   struct drm_atomic_commit *commit)
>  {

[Severity: High]
This is a pre-existing issue, but does this face the same atomic context
problem as tda998x_bridge_enable()?

Similar to the enable path, tda998x_bridge_disable() runs in an atomic
context but invokes reg_write() which can sleep:

static void tda998x_bridge_disable(...)
{
	...
	if (priv->is_on) {
		reg_write(priv, REG_ENA_VP_0, 0x00);

>  	struct tda998x_priv *priv =3D bridge_to_tda998x_priv(bridge);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D21
