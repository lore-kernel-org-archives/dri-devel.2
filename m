Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355E4C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E6E10E1CA;
	Wed, 15 Jul 2026 13:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jQ7vpoFV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD6110E1CA
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:32:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 13DA861383;
 Wed, 15 Jul 2026 13:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939471F000E9;
 Wed, 15 Jul 2026 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784122375;
 bh=K2A0QrTS/lYkBcIVlbclE2MxDY161aDjP8tYCoAUMKU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jQ7vpoFVrgX3xFgld2wUByO7KN6TnVJKOAv5ncS4euf6veYz0xrGhryEyvuLDtKix
 LUZLPQ4KRmfr9pjZzL83/QWUOYVMPqn9LRXdnZuLF+LU32meoRUB+f6Bt4PD1dF5yK
 qqIj/W0mE5FyqaWGzCP54uR+HIOS5vxDLRtViLkY7KrSkGOhWtytGOwMGA3/dOdltp
 FYRZPIzIP50XF/paYTSfqJBKs5Dduh819GYf3Ftauqvog3ayt6UaT0cqaGlVHZjda8
 8xfAHQ/OMvu61PB4jYDlpGFDhQtWYhs04YJMaNMcQvuDOvP3RmYZMI5SiYz5SbpbZn
 XqdcbIjiwk5RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] drm/bridge: ti-sn65dsi83: Fix problem with
 premature PLL locking
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260715-ti-sn65dsi83-fixes-v2-1-ebc4c3fe29b6@geanix.com>
References: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
 <20260715-ti-sn65dsi83-fixes-v2-1-ebc4c3fe29b6@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 13:32:55 +0000
Message-Id: <20260715133255.939471F000E9@smtp.kernel.org>
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
- [High] The reset_work work item is never cancelled during device removal,=
 leading to a Use-After-Free if executed after devres cleanup.
--

--- Patch [1]: [PATCH v2 1/3] drm/bridge: ti-sn65dsi83: Fix problem with pr=
emature PLL locking ---
commit 6d16fdef43813e12caf14d60e8f68b785f57a520
Author: Esben Haabendal <esben@geanix.com>
Subject: drm/bridge: ti-sn65dsi83: Fix problem with premature PLL locking

This commit moves the PLL locking sequence from atomic_pre_enable() to
atomic_enable(), ensuring the DSI HS clock is running before the PLL is
locked. This resolves PLL lock failures seen with certain configurations.

Link: https://lore.kernel.org/all/20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.c=
om/

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index 42b451432bbb6..b4b220eee7909 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c

[ ... ]

> @@ -734,6 +732,7 @@ static void sn65dsi83_atomic_enable(struct drm_bridge=
 *bridge,
>  		sn65dsi83_monitor_start(ctx);
>  	}
> =20
> +err_exit:
>  	drm_bridge_exit(idx);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing
issue in this driver regarding device removal.

Could the reset_work item execute after the device has been unbound?

Looking at sn65dsi83_remove(), it unplugs the bridge but doesn't cancel
the pending work:

static void sn65dsi83_remove(struct i2c_client *client)
{
	struct sn65dsi83 *ctx =3D i2c_get_clientdata(client);

	drm_bridge_unplug(&ctx->bridge);
}

Because ctx is allocated via devres, the memory is freed immediately after
removal completes. If sn65dsi83_reset_work() is scheduled (e.g., from
hardware errors) and runs after this cleanup, it dereferences the freed
pointer:

static void sn65dsi83_reset_work(struct work_struct *ws)
{
	struct sn65dsi83 *ctx =3D container_of(ws, struct sn65dsi83, reset_work);
	...
	if (!drm_bridge_enter(&ctx->bridge, &idx))
		return;

Does this race condition lead to a use-after-free if the device is removed
while reset_work is pending?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-ti-sn65dsi=
83-fixes-v2-0-ebc4c3fe29b6@geanix.com?part=3D1
