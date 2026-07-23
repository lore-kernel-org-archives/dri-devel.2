Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66590C531D1
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8756410E17C;
	Thu, 23 Jul 2026 13:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YOpb0peS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3351610E17C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:26:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 571AA4053E;
 Thu, 23 Jul 2026 13:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9B71F000E9;
 Thu, 23 Jul 2026 13:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784813188;
 bh=F1wkB1a+vwSSZh98Yv5uA16g9k8Yv/YEDhBfUd/JuYc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YOpb0peSLH42qM2GC8RaExKSdDamSdQQmYLzHt2BEnfLMZaZ98RF282booBkdK4OM
 zo8gBNYteBhoq6WmcODpGLHpXE3/ymYk0BhQjCIwQpp8gqkUkk2f+I5uHS0hjm7h6m
 0LKVL6JQWNsE1bnZwBJGghxFvfpCAKq/D6lbehO8jmXTIoKM8Tziv/GkI2Rk+1GPJ9
 pOQKqTvbxCRnkphetjmlYWgmK2FVA7GLG1hBxBewdKJnz2QMBTOGRAS0JB1J9NPdEv
 WQlx2oMfB6EBdcPEdrYcvF2xN00pX+slnWrDp30+oKKtYOtj3SpvgLLOImN3vwCej1
 kSoEtPegCbU6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] drm/bridge: ti-sn65dsi83: Remove redundant
 dev_err_probe()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723131649.134127-10-panchuang@vivo.com>
References: <20260723131649.134127-1-panchuang@vivo.com>
 <20260723131649.134127-10-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 13:26:25 +0000
Message-Id: <20260723132628.1B9B71F000E9@smtp.kernel.org>
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
- [High] The background work `ctx->reset_work` is never explicitly canceled=
, which can lead to a Use-After-Free if it executes after `ctx` is freed.
--

--- Patch [9]: [PATCH 09/10] drm/bridge: ti-sn65dsi83: Remove redundant dev=
_err_probe() ---
commit ae3029f9f75aff0082e24f794cc2c0d8fb473908
Author: Pan Chuang <panchuang@vivo.com>

drm/bridge: ti-sn65dsi83: Remove redundant dev_err_probe()

Since commit 55b48e23f5c4, devm_request_threaded_irq() automatically logs
detailed error messages on failure. This patch removes the now-redundant
driver-specific dev_err_probe() call.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -1040,7 +1040,7 @@ static int sn65dsi83_probe(struct i2c_client *clien=
t)
>  		ret =3D devm_request_threaded_irq(ctx->dev, ctx->irq, NULL, sn65dsi83_=
irq,
>  						IRQF_ONESHOT, dev_name(ctx->dev), ctx);
>  		if (ret)
> -			return dev_err_probe(dev, ret, "failed to request irq\n");
> +			return ret;
>  	}
> =20
>  	dev_set_drvdata(dev, ctx);

[Severity: High]
This is a pre-existing issue, but looking at the driver initialization and
teardown, is there a risk of a use-after-free with ctx->reset_work?

When the IRQ is successfully requested, the handler sn65dsi83_irq() becomes
active. If a hardware error triggers the IRQ handler, it calls
sn65dsi83_handle_errors() which schedules the reset work:

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_handle_errors() {
    ...
    schedule_work(&ctx->reset_work);
    ...
}

If the probe fails later (for example, when sn65dsi83_host_attach() fails),
the err_remove_bridge path is taken:

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_probe() {
err_remove_bridge:
    drm_bridge_remove(&ctx->bridge);
    return ret;
}

Since there is no explicit cancellation of the work here, and devres will
subsequently free the ctx structure upon probe failure, could a scheduled
reset work execute and dereference the freed ctx pointer?

The same pattern appears to exist in the normal driver removal path:

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_remove() {
    struct sn65dsi83 *ctx =3D i2c_get_clientdata(client);

    drm_bridge_unplug(&ctx->bridge);
}

Could this also leave a dangling work item that outlives the device context
if the device is unbound via sysfs while the background work is pending?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723131649.1341=
27-1-panchuang@vivo.com?part=3D9
