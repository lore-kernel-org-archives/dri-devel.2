Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE705C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23DB10E1D6;
	Mon, 10 Aug 2026 07:36:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NviYese7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C66E10E1AA
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:36:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05FDB43EE4;
 Mon, 10 Aug 2026 07:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1A51F000E9;
 Mon, 10 Aug 2026 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786347364;
 bh=3Et54bXDbqoLGqfi5vN5uIJoywtTxCjPrnSwvHBbMww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NviYese7bpjHSKcWvxuTpzTnYKXJsrspJqZnlKf+Y/hwW//hUmgotSVB2TJoYAQMq
 9lYHFHxapIq3zv0XboJ7L7N/vLCZbDPGL3gSZn4dt4NEoP3e0iP0/5L+azrASPRuJp
 zbGyOYFQ1AaUVQF61PomAoOLM6WGVEM26z6MzT/wz/uqtUcFHAhu2z2o4laO6yrDLy
 q4rbNBgEmRJE/Ez72u9nT8DzWemiTbxrMUgDNUHpLtpzLiowT0sq5jBu4INNrn7m+4
 AzgbBVB71cO+mlXX1xc/amVEFLzhae8tikeH9Z3Ch52FVS7j0tPHXrSan/X1y+O0pM
 LBMn+Pi/9v21A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810-ti-sn65dsi83-fixes-v4-2-ae9c95c8d162@geanix.com>
References: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
 <20260810-ti-sn65dsi83-fixes-v4-2-ae9c95c8d162@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 07:36:04 +0000
Message-Id: <20260810073604.BD1A51F000E9@smtp.kernel.org>
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
- [High] The background work `reset_work` is not cancelled when the device =
is unbound, leading to a Use-After-Free when the workqueue executes the pen=
ding work item after the driver data structure has been freed.
- [High] Re-enabling the interrupt after a failed bridge reset creates an i=
nterrupt storm and infinite workqueue loop.
- [High] Preexisting double-unlock of connection_mutex in drm_bridge_helper=
_reset_crtc() triggered during pipeline reset.
--

--- Patch [2]: [PATCH v4 2/3] drm/bridge: ti-sn65dsi83: Propagate error in =
sn65dsi83_reset_pipe() ---
commit a871b12bfaa133da03afd275986f3c4abe9be9c0
Author: Esben Haabendal <esben@geanix.com>
drm/bridge: ti-sn65dsi83: Propagate error in sn65dsi83_reset_pipe()

This commit modifies sn65dsi83_reset_pipe() to propagate the error code from
drm_bridge_helper_reset_crtc() instead of unconditionally returning 0. This
gives callers the opportunity to handle reset failures.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index 0ccfff401b2a6..475224c5a5d83 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -403,7 +403,7 @@ static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn6=
5dsi83)
>  	drm_modeset_drop_locks(&ctx);
>  	drm_modeset_acquire_fini(&ctx);
> =20
> -	return 0;
> +	return err;

[Severity: High]
This is a pre-existing issue, but returning the error here exposes a
problem in drm_bridge_helper_reset_crtc() which is called earlier in
this function.

Does drm_bridge_helper_reset_crtc() suffer from a double-unlock of
connection_mutex?

It manually acquires connection_mutex, then calls:
drm_atomic_get_connector_for_encoder(encoder, ctx)

This helper appears to unconditionally unlock connection_mutex before retur=
ning:

drivers/gpu/drm/drm_atomic.c:drm_atomic_get_connector_for_encoder() {
    ...
    ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
    ...
    drm_modeset_unlock(&dev->mode_config.connection_mutex);
    return out_connector;
}

Then drm_bridge_helper_reset_crtc() explicitly drops it again:

drivers/gpu/drm/drm_bridge_helper.c:drm_bridge_helper_reset_crtc() {
    ...
    connector =3D drm_atomic_get_connector_for_encoder(encoder, ctx);
    ...
out:
    drm_modeset_unlock(&dev->mode_config.connection_mutex);
    return ret;
}

Could this lead to lock state corruption or kernel panics when the reset pa=
th
is executed?

>  }
> =20
>  static void sn65dsi83_reset_work(struct work_struct *ws)

[Severity: High]
This isn't a bug introduced by this patch, but now that
sn65dsi83_reset_pipe() propagates errors, will this workqueue re-enable the
interrupt even if the reset failed?

If sn65dsi83_reset_pipe() returns an error, the hardware might not be reset
and the error condition could remain asserted. If we unconditionally call
enable_irq(ctx->irq) at the end of sn65dsi83_reset_work():

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_reset_work() {
    ...
    ret =3D sn65dsi83_reset_pipe(ctx);
    if (ret)
        dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));

    if (ctx->irq)
        enable_irq(ctx->irq);
}

Will the interrupt immediately fire again, causing an interrupt storm and an
infinite workqueue loop?

[Severity: High]
This is another pre-existing issue, but there appears to be a problem with
reset_work during driver removal.

Does sn65dsi83_remove() fail to cancel reset_work before the device is
unbound?

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_remove() {
    struct sn65dsi83 *ctx =3D i2c_get_clientdata(client);

    drm_bridge_unplug(&ctx->bridge);
}

If an error interrupt fires and schedules reset_work, and the driver is
unbound before the work executes, will devres free the sn65dsi83 structure
while the workqueue still holds a dangling pointer to it, leading to a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-ti-sn65dsi=
83-fixes-v4-0-ae9c95c8d162@geanix.com?part=3D2
