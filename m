Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBA3C4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 20:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A9110E4CC;
	Wed, 22 Jul 2026 20:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k2JaT9rf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D3B10E4CC
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 20:36:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A45E60051;
 Wed, 22 Jul 2026 20:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3E31F000E9;
 Wed, 22 Jul 2026 20:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784752608;
 bh=3R6CeXQI9MNlo/spd0Upe0cyipsh8y3RKdy4V+57QjQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k2JaT9rfwWhuN1y3+3wWGgGKfrz+UvQDsjOCT+EHBwpygPDUXO5NlJ+QwksElOQE7
 VNt0pRTZvouAROBoTn9TqY87lp6/XWvspyShAzrcwQaMbrLkuwuOnhT8o+e/NcTZg2
 Ch0FCggJigYXkghnTJk3EdIyp0VC9y9JiF3vJgBovDPsl2riMS1dxUm+KrCiRqX3mL
 8yj42Ni5BUQ244QXAspSCDDUTzMT9UpL1Eya3N8cgujQQKIPAyvB/egcQ/LpLG9ZeX
 d/XI50LN7wmQY/yOajvsZpBOVyHGW8Ocgf7EnvoMZrf+lKB0lLbqqwos1skFqWiun9
 51Bfa5jKdqyYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/11] drm/bridge: it6505: balance and disable
 runtime PM on remove
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2ba351075bfd63f0ea937080c37f417140a8c97a.1784717129.git.daniel@makrotopia.org>
References: <cover.1784717129.git.daniel@makrotopia.org>
 <2ba351075bfd63f0ea937080c37f417140a8c97a.1784717129.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 20:36:48 +0000
Message-Id: <20260722203648.AA3E31F000E9@smtp.kernel.org>
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
- [High] Use-After-Free of devres-managed resources when I2C device is unbo=
und while DRM pipeline is active.
--

--- Patch [2]: [PATCH v5 02/11] drm/bridge: it6505: balance and disable run=
time PM on remove ---
commit e15fa2b94105d4f1aa7e633d5a8987820994caa9
Author: Daniel Golle <daniel@makrotopia.org>

drm/bridge: it6505: balance and disable runtime PM on remove

This commit balances the usage reference held for a connected display and
explicitly disables runtime PM in the I2C remove path. This prevents a
device from leaking the reference count across rebinds and resolves an
unbalanced pm_runtime_enable warning.

> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -3660,6 +3660,9 @@ static void it6505_i2c_remove(struct i2c_client *cl=
ient)
>  	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
>  	cancel_delayed_work_sync(&it6505->hdcp_work);
>  	cancel_work_sync(&it6505->extcon_wq);
> +	if (it6505->extcon_state)
> +		pm_runtime_put_sync(&client->dev);
> +	pm_runtime_disable(&client->dev);
>  	it6505_poweroff(it6505);
>  	it6505_remove_edid(it6505);
>  }

[Severity: High]
This is a pre-existing issue, but does this remove sequence lead to a
use-after-free if the device is unbound via sysfs while the DRM pipeline is
active?

When it6505_i2c_remove() returns, the driver core cleans up devres-managed
resources allocated during probe, including the regmap and regulators.

The bridge container itself is allocated via devm_drm_bridge_alloc(), which
uses a kref to manage its lifetime, meaning it outlives the devres cleanup
as long as the DRM pipeline holds a reference.

If the DRM pipeline is subsequently torn down, it will call bridge callbacks
like it6505_bridge_atomic_disable() which attempt to access the freed regmap
and regulators. Is there a way to ensure the bridge is fully disconnected a=
nd
hardware resources are safe from late access during unbind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784717129.gi=
t.daniel@makrotopia.org?part=3D2
