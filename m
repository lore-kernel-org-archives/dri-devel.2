Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97034C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0443B10EDAD;
	Wed,  5 Aug 2026 09:23:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EFSuT1HC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BBB10EDAD
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 09:23:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F16B43447;
 Wed,  5 Aug 2026 09:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C9D1F00A3E;
 Wed,  5 Aug 2026 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785921794;
 bh=u2KB04vyV7eMYAtGBpvDi1qAK+S2w70bDLDlunWxwi4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EFSuT1HCN9MrtUR0fbsWEYwEHoZnelt2bfPTO4CGsPO+bm+lX6BcKOBk7uJN9yPR/
 CaBYIG0FTXVYHZHUAfxKM6acNx+sG17dhw1w8WA1ekBxp67pLvMlYD9HcYHW0Ur8Oy
 SJDf1XHW8tBrco+9C1LELcDuQpi8VAUEBANTG9aCDSJj5gAI43FJlndB44D/OkB69i
 pxi0SJ8KiHrjvy0FYEfxQaieuRh0LEzlVZzvYRND4smWkZAjG6w7UCDZkopkWSO4AK
 AAmA0TQ8S/8cvmwD2J3dYen6C5zDvZfN1RzRm2yfXNV93gnBfxi9k/kdTJXQZmOnXv
 FNSKaB9VFGIfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: Cancel reset_work on remove
 to avoid use-after-free
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805090804.78914-1-fanwu01@zju.edu.cn>
References: <20260805090804.78914-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 09:23:13 +0000
Message-Id: <20260805092313.E6C9D1F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent DRM commit can re-queue monitor_work after it has been =
cancelled, causing a use-after-free in polling mode.
- [High] SRCU read lock leak on error path in `sn65dsi83_reset_work` and sw=
allowed errors in `sn65dsi83_reset_pipe`.
- [High] Missing cancel_work_sync(&ctx->reset_work) in the probe error path=
 leads to a use-after-free.
--

--- Patch [1]: [PATCH] drm/bridge: ti-sn65dsi83: Cancel reset_work on remov=
e to avoid use-after-free ---
commit 8ee8b1cf3acf86f0f88ed002c2cab55bb6d809f3
Author: Fan Wu <fanwu01@zju.edu.cn>
   =20
drm/bridge: ti-sn65dsi83: Cancel reset_work on remove to avoid use-after-fr=
ee
   =20
The error recovery code queues ctx->reset_work from the threaded IRQ
handler and the polling monitor_work, but nothing ever cancels it.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -1068,6 +1068,12 @@ static void sn65dsi83_remove(struct i2c_client *cl=
ient)
>  {
>  	struct sn65dsi83 *ctx =3D i2c_get_clientdata(client);
> =20
> +	/* Stop the reset_work producers, then drain, before unplug. */
> +	if (ctx->irq)
> +		disable_irq(ctx->irq);
> +	cancel_delayed_work_sync(&ctx->monitor_work);
> +	cancel_work_sync(&ctx->reset_work);
> +
>  	drm_bridge_unplug(&ctx->bridge);

[Severity: High]
This isn't a bug introduced by this patch, but could this ordering cause a=
=20
use-after-free in polling mode?

Since drm_bridge_unplug() hasn't been called yet, bridge->unplugged is stil=
l=20
false. If ctx->irq =3D=3D 0 (polling mode), no IRQ is disabled. If a concur=
rent=20
DRM atomic commit calls sn65dsi83_atomic_enable() in this window, it will=20
successfully enter the bridge and call sn65dsi83_monitor_start(), which=20
re-arms monitor_work.

When sn65dsi83_remove() finishes, devres frees ctx, and the newly queued wo=
rk=20
executes on freed memory. Should drm_bridge_unplug() be called before=20
cancelling the works to act as a barrier?

While looking at the workqueue handling in this driver, I noticed a couple =
of=20
other pre-existing issues. In sn65dsi83_reset_work():

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_reset_work() {
        ...
        ret =3D sn65dsi83_reset_pipe(ctx);
        if (ret) {
                dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
                return;
        }
        ...
}

[Severity: High]
This is a pre-existing issue, but does this early return leak the SRCU read=
=20
lock? sn65dsi83_reset_work() calls drm_bridge_enter(), but this error path=
=20
returns without calling drm_bridge_exit(idx).

Additionally, in sn65dsi83_reset_pipe():

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_reset_pipe() {
        ...
        drm_modeset_drop_locks(&ctx);
        drm_modeset_acquire_fini(&ctx);
       =20
        return 0;
}

The error code from drm_bridge_helper_reset_crtc() is swallowed and=20
unconditionally returns 0, which masks the lock leak above, but instead cau=
ses=20
sn65dsi83_reset_work() to proceed and re-enable the IRQ without the hardwar=
e=20
being recovered. Could this lead to an immediate IRQ storm and an infinite=
=20
workqueue loop?

Finally, regarding the probe error path in sn65dsi83_probe():

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_probe() {
        ...
err_remove_bridge:
        drm_bridge_remove(&ctx->bridge);
        return ret;
}

[Severity: High]
This is another pre-existing issue, but is it possible for reset_work to=20
execute after ctx is freed here?

The IRQ is requested via devm_request_threaded_irq() before=20
sn65dsi83_host_attach() is called. If a spurious interrupt fires while the=
=20
chip is held in reset, an I2C read in the interrupt handler will fail, caus=
ing=20
it to queue ctx->reset_work.=20

If sn65dsi83_host_attach() then returns -EPROBE_DEFER, the code jumps to=20
err_remove_bridge: and returns. Devres will free the IRQ and ctx. Because=20
drm_bridge_remove() does not set bridge->unplugged =3D true, and there is n=
o=20
cancel_work_sync(&ctx->reset_work) here, the queued work could execute late=
r=20
and dereference the freed ctx memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805090804.7891=
4-1-fanwu01@zju.edu.cn?part=3D1
