Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC46C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 16:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF6F10F68F;
	Thu, 24 Sep 2026 16:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bV8xxj7Q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D3F10F68E
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 16:08:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5873F43262;
 Thu, 24 Sep 2026 16:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8F31F0089E;
 Thu, 24 Sep 2026 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790266097;
 bh=2amtWoddep7pLojeoPlYnSOvF1cjX1L2EV1PPtxJAkM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bV8xxj7QLljb63+9SMJVZr5rMtdrlNkzybIwY8y2BSFTnj2H2ZwAVkN7O9tU5L4+Y
 Qqp/sDY4OyTSqPQpz5Ch9ZWB0pgvPJgyqzZEjTfU2yV9+4pQivEfV0ePZHumJ0W6NY
 3+S33ED5n1cHhog0A6laY3Hc9Jutw+M+6zaNOB18iVp8VE7fYenB1ZS9qyi5gOzVHb
 blvPM3wv+MVoPgbZQ/eupg4UJAilP31w6CtP5JXJHgLJlxWgVmZRSGPkrGixTVX2mL
 cn56JF2rMx5Zpd8Y73bv2zaYh64GrDw0JfWSo46rAGEdSPI3YnrTW10Yh5SUbBQ4ao
 CCJIgPfois6rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/2] drm/bridge: add support for lontium lt9211c bridge
To: vishnu.saini@oss.qualcomm.com
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260924-add-lt9211c-bridge-v9-2-d78b39677a61@oss.qualcomm.com>
References: <20260924-add-lt9211c-bridge-v9-0-d78b39677a61@oss.qualcomm.com>
 <20260924-add-lt9211c-bridge-v9-2-d78b39677a61@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:08:16 +0000
Message-Id: <20260924160816.ED8F31F0089E@smtp.kernel.org>
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
- [High] drm/bridge: probe race causing NULL pointer dereference via early =
devm_drm_bridge_add()
- [High] drm/bridge: use-after-free of workqueue on unbind due to reversed =
devres cleanup ordering
- [Medium] drm/bridge: asynchronous atomic_enable breaks DRM synchronous br=
idge chain initialization
--

commit 2cf60daaeefff033f413189c179402f2bd50e48c
Author: Yi Zhang <zhanyi@qti.qualcomm.com>

drm/bridge: add support for lontium lt9211c bridge

This commit extends the lontium-lt9211 driver to support the LT9211C
variant by detecting the new chip ID and implementing its specific
initialization sequences. It defers the final bridge configuration to
a work item scheduled from atomic_enable() to wait for an active DSI stream.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/br=
idge/lontium-lt9211.c
> index 23682384daf46..e6c08a7fdc27c 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9211.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9211.c

[ ... ]

> @@ -523,6 +1271,21 @@ static void lt9211_atomic_enable(struct drm_bridge =
*bridge,
>  	if (ret)
>  		return;
> =20
> +	if (ctx->chip_data->chip_type =3D=3D LT9211C) {
> +		drm_mode_copy(&ctx->lt9211c_mode, mode);
> +		ctx->lt9211c_bpp24 =3D lvds_format_24bpp;
> +		ctx->lt9211c_jeida =3D lvds_format_jeida;
> +		ctx->lt9211c_de_high =3D !!(bus_flags & DRM_BUS_FLAG_DE_HIGH);
> +		ctx->lt9211c_crtc =3D crtc;
> +
> +		/*
> +		 * Needs a live DSI stream to auto-detect RX resolution/format;
> +		 * defer bridge configuration until vblank inside the work item.
> +		 */
> +		queue_work(ctx->wq, &ctx->lt9211_work);
> +		return;
> +	}

[Severity: Medium]
Does returning asynchronously here violate the DRM bridge API contract?

By offloading the hardware initialization to a workqueue and returning
immediately, the DRM core might proceed to enable downstream panels in the
chain before the LVDS signal is actually active.

Could this result in display initialization failures on platforms where
downstream panels require a stable LVDS stream during their enable sequence?

[ ... ]

> @@ -748,45 +1516,53 @@ static int lt9211_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
> =20
> -	ctx->regmap =3D devm_regmap_init_i2c(client, &lt9211_regmap_config);
> +	ctx->chip_data =3D i2c_get_match_data(client);
> +	if (!ctx->chip_data)
> +		return -ENODEV;
> +
> +	ctx->regmap =3D devm_regmap_init_i2c(client, ctx->chip_data->regmap_con=
fig);
>  	if (IS_ERR(ctx->regmap))
>  		return PTR_ERR(ctx->regmap);
> =20
> -	dev_set_drvdata(dev, ctx);
> -	i2c_set_clientdata(client, ctx);
> -
>  	ctx->bridge.of_node =3D dev->of_node;
> -	drm_bridge_add(&ctx->bridge);
> +	ret =3D devm_drm_bridge_add(dev, &ctx->bridge);
> +	if (ret)
> +		return ret;

[Severity: High]
Is there a risk of a NULL pointer dereference here if the bridge is exposed
before its workqueue is initialized?

Because devm_drm_bridge_add() globally exposes the bridge to the subsystem,=
 a
concurrent display controller probe could immediately discover it and initi=
ate
an atomic commit.

If lt9211_atomic_enable() is reached before ctx->wq and ctx->lt9211_work are
initialized further down in lt9211_probe(), it will call queue_work() with =
an
uninitialized NULL workqueue.

>  	ret =3D lt9211_host_attach(ctx);
>  	if (ret)
> -		drm_bridge_remove(&ctx->bridge);
> -
> -	return ret;
> -}
> +		return ret;
> =20
> -static void lt9211_remove(struct i2c_client *client)
> -{
> -	struct lt9211 *ctx =3D i2c_get_clientdata(client);
> +	if (ctx->chip_data->chip_type =3D=3D LT9211C) {
> +		ctx->wq =3D create_workqueue("lt9211_work");
> +		if (!ctx->wq)
> +			return -ENOMEM;
> +		/* Register after DSI attach so devres flushes work before freeing ctx=
->dsi. */
> +		ret =3D devm_add_action_or_reset(dev, lt9211_destroy_wq, ctx->wq);
> +		if (ret)
> +			return ret;
> +		INIT_WORK(&ctx->lt9211_work, lt9211_work_func);
> +	}

[Severity: High]
Could this devres ordering lead to a use-after-free during driver unbind?

The devres infrastructure executes cleanup actions in reverse order of
addition (LIFO). Since devm_drm_bridge_add() was called earlier in the probe
sequence, the workqueue cleanup (lt9211_destroy_wq) will execute before the
bridge is unregistered from the DRM subsystem.

If the DRM core invokes lt9211_atomic_enable() or lt9211_atomic_disable()
during this unbind window, the driver will dereference the freed ctx->wq
pointer in queue_work() or cancel_work_sync().

> -	drm_bridge_remove(&ctx->bridge);
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-add-lt9211=
c-bridge-v9-0-d78b39677a61@oss.qualcomm.com?part=3D2
