Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80714C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8C810EE51;
	Wed,  5 Aug 2026 12:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K92hAgj4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E830C10EE4B
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 12:15:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D2DC40579;
 Wed,  5 Aug 2026 12:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4660F1F00A3A;
 Wed,  5 Aug 2026 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785932105;
 bh=QhsLfGLRwwYootvbfIdp4XxQcUqZ+MUKxuxCyHXsDTo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K92hAgj41qYUfN5ihhhvLJSU0QPS7oGmv55zknXpWFH0JnUFYyCxd5x48Xhi7LeLr
 aZCOgWlOkov5VTm/iOf/1+7XOaS+PoL/eceeqUObpm08jANVjAzf1BaqNS1/2iljsY
 dgKE/VcuGPsMKR+JHeSP8KC4+dyyXf9+FETNUevT83kEHXWK7v0CEs6wk1p9WyKio5
 JwXwjoltNODZ88LNUhm+UCERYBiY3Xy87ZeYRTipQccNiy94Zat/7K2FADPkNLJtn5
 wGqSg/Bkago3HN7CA0fUPm9CZdSJ+0W8W2lEY52qEtcTrk324YbHkmprVxAugQvly3
 2eokwz8iRvCKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi83: Cancel reset_work on
 remove to avoid use-after-free
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805115546.152786-1-fanwu01@zju.edu.cn>
References: <20260805090804.78914-1-fanwu01@zju.edu.cn>
 <20260805115546.152786-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:15:04 +0000
Message-Id: <20260805121505.4660F1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Interrupt storm between drm_bridge_unplug() and disable_irq()

Pre-existing issues:
- [High] Spurious IRQ during probe causes NULL pointer dereference in sn65d=
si83_reset_work()
- [High] Leaked SRCU read lock in sn65dsi83_reset_work() error path
- [High] Missing IRQ synchronization in sn65dsi83_release_resources() cause=
s race condition
--

--- Patch [1]: [PATCH v2] drm/bridge: ti-sn65dsi83: Cancel reset_work on re=
move to avoid use-after-free ---
commit 197f183cb3d12c2d5d1810b8f11c167e77438773
Author: Fan Wu <fanwu01@zju.edu.cn>

drm/bridge: ti-sn65dsi83: Cancel reset_work on remove to avoid use-after-fr=
ee

The error recovery code queues reset_work from the threaded IRQ handler
and polling monitor_work. Neither the remove path nor the probe failure
path after the IRQ is registered drains that work before devres releases
the bridge allocation.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index f9fdbf48c6b32..bf263f407cb2c 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -996,6 +996,18 @@ static irqreturn_t sn65dsi83_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
> =20
> +static void sn65dsi83_stop_error_recovery(struct sn65dsi83 *ctx)
> +{
> +	/* Block new bridge users and wait for existing critical sections. */
> +	drm_bridge_unplug(&ctx->bridge);
> +
> +	if (ctx->irq)
> +		disable_irq(ctx->irq);

[Severity: High]
Could this ordering cause an interrupt storm leading to a CPU lockup?

When drm_bridge_unplug() sets bridge->unplugged =3D true, if an IRQ fires b=
efore
disable_irq() is called, sn65dsi83_handle_errors() will see drm_bridge_ente=
r()
fail and return early:

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_handle_errors() {
    ...
	if (!drm_bridge_enter(&ctx->bridge, &idx))
		return;
    ...
}

Since this threaded IRQ handler returns IRQ_HANDLED without clearing the
hardware interrupt or disabling the IRQ, will the IRQ core unmask the
still-asserted interrupt line, causing it to immediately fire again and
starve the teardown code?

[Severity: High]
This is a pre-existing issue, but will the addition of drm_bridge_unplug()
here cause a system deadlock during driver unbind or probe failure?

In the error path of sn65dsi83_reset_work(), if resetting the pipe fails,
it returns early:

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_reset_work() {
    ...
	ret =3D sn65dsi83_reset_pipe(ctx);
	if (ret) {
		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
		return;
	}
    ...
}

This early return skips drm_bridge_exit(idx), permanently leaking the SRCU
read lock. If that happens, won't this new drm_bridge_unplug() call block
forever in synchronize_srcu()?

> +
> +	cancel_delayed_work_sync(&ctx->monitor_work);
> +	cancel_work_sync(&ctx->reset_work);
> +}
> +
>  static int sn65dsi83_probe(struct i2c_client *client)
>  {
[ ... ]
> @@ -1060,7 +1072,7 @@ static int sn65dsi83_probe(struct i2c_client *clien=
t)
>  	return 0;
> =20
>  err_remove_bridge:
> -	drm_bridge_remove(&ctx->bridge);
> +	sn65dsi83_stop_error_recovery(ctx);

[Severity: High]
This is a pre-existing issue, but can a spurious interrupt during probe
cause a NULL pointer dereference?

If a spurious interrupt fires after devm_request_threaded_irq() is called
in sn65dsi83_probe() but before the KMS driver calls drm_bridge_attach(),
the threaded handler will schedule reset_work.

The worker then executes sn65dsi83_reset_pipe() which calls:

drivers/gpu/drm/drm_bridge_helper.c:drm_bridge_helper_reset_crtc() {
    ...
	struct drm_device *dev =3D encoder->dev;
    ...
}

Since the bridge is not attached yet, bridge->encoder is NULL. Does this
unconditionally crash if an early interrupt occurs?

>  	return ret;
>  }
> =20
> @@ -1068,7 +1080,7 @@ static void sn65dsi83_remove(struct i2c_client *cli=
ent)
>  {
>  	struct sn65dsi83 *ctx =3D i2c_get_clientdata(client);
> =20
> -	drm_bridge_unplug(&ctx->bridge);
> +	sn65dsi83_stop_error_recovery(ctx);
>  }

[Severity: High]
This is a pre-existing issue, but does sn65dsi83_release_resources() contain
a race condition with the IRQ handler?

During display teardown, sn65dsi83_release_resources() disables the hardware
interrupt and powers off the chip without synchronizing against the executi=
ng
IRQ handler:

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_release_resources() {
    ...
	if (ctx->irq) {
		/* Disable irq */
		regmap_write(ctx->regmap, REG_IRQ_EN, 0x0);
		regmap_write(ctx->regmap, REG_IRQ_GLOBAL, 0x0);
	}
    ...
}

If the threaded IRQ handler sn65dsi83_handle_errors() runs concurrently,
won't its I2C read fail due to the chip being powered down? It seems it
would misinterpret this as a hardware error and improperly schedule
reset_work while the display pipeline is being torn down.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805115546.1527=
86-1-fanwu01@zju.edu.cn?part=3D1
