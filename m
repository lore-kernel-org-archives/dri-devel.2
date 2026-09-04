Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22696C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 17:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83FF410E1F7;
	Fri,  4 Sep 2026 17:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nLdtlL5z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745A010E1F7
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 17:41:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32ED8419FF;
 Fri,  4 Sep 2026 17:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B9D1F00A3D;
 Fri,  4 Sep 2026 17:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788543675;
 bh=YusEUZyQ5+YYORtWEn5uAmqra/Skq1w9OYjuDPNcdhA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nLdtlL5ze4sza34RguF94HwCHpI5oWriVvXe/jlgLCQn7AVHwXr4owEB458NVGntQ
 VP8tkcfs1Kwn6tJNllVkHOxS4/0LO5L3/0FckJhd3mo3kReGl8qpObovf49ejcGMLd
 B3saVE2jiWQIKbUGi4CoeFKuJH50Eq+IRCeLM5WoGG9Mm7ASrhPGekb82VdvhVgxnr
 vYjAELw8ZohGfvmxnxJZYrW51BmSOjy1UxnczqmKFpWXhguFhiu7ZXB3/P9LkZePaE
 +XjAkUnU5T0ECIQuJM/BdA4AEeSTL8BhklTg1LYQg/f9MJC2aDOl0sYMxfIQyNJBDk
 wJvSVdiHyAPaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] drm/bridge: add support for lontium lt9211c bridge
To: vishnu.saini@oss.qualcomm.com
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-add-lt9211c-bridge-v8-2-36d66168e176@oss.qualcomm.com>
References: <20260904-add-lt9211c-bridge-v8-0-36d66168e176@oss.qualcomm.com>
 <20260904-add-lt9211c-bridge-v8-2-36d66168e176@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:41:14 +0000
Message-Id: <20260904174114.D7B9D1F00A3D@smtp.kernel.org>
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
- [High] Use-after-free of `ctx->dsi` in the deferred work item during devi=
ce unbind due to incorrect devres registration order.
--

commit f4afb8a9dbec6141c1ce6b1a75c1128b1885dc29
Author: Yi Zhang <zhanyi@qti.qualcomm.com>

drm/bridge: add support for lontium lt9211c bridge

This commit extends the existing lontium-lt9211 driver to support the
LT9211C variant. It adds LT9211C-specific regmap support, initialization
sequences, and schedules a work item to handle RX auto-detection once a
DSI stream is active.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/br=
idge/lontium-lt9211.c
> --- a/drivers/gpu/drm/bridge/lontium-lt9211.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9211.c

[ ... ]

> @@ -454,6 +552,656 @@ static int lt9211_configure_tx(struct lt9211 *ctx, =
bool jeida,
>  	return 0;
>  }
> =20
> +static int lt9211c_configure_rx(struct lt9211 *ctx)
> +{
> +	unsigned int pval;
> +
> +	const struct reg_sequence lt9211c_rx_phy_seq[] =3D {
> +		{ REG_DSI_LANE, REG_DSI_LANE_COUNT(ctx->dsi->lanes) },

[Severity: High]
Does this code dereference a freed pointer during driver unbind?

When the device is unbound, the workqueue is destroyed, which flushes any
pending work. If the work item executes here, it dereferences ctx->dsi,
but ctx->dsi might have already been freed due to the devres teardown order
configured in lt9211_probe().

[ ... ]

> @@ -748,45 +1516,48 @@ static int lt9211_probe(struct i2c_client *client)
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
> +	if (ctx->chip_data->chip_type =3D=3D LT9211C) {
> +		ctx->wq =3D create_workqueue("lt9211_work");
> +		if (!ctx->wq)
> +			return -ENOMEM;
> +		ret =3D devm_add_action_or_reset(dev, lt9211_destroy_wq, ctx->wq);
> +		if (ret)
> +			return ret;
> +		INIT_WORK(&ctx->lt9211_work, lt9211_work_func);
> +	}
> =20
>  	ctx->bridge.of_node =3D dev->of_node;
> -	drm_bridge_add(&ctx->bridge);
> -
> -	ret =3D lt9211_host_attach(ctx);
> +	ret =3D devm_drm_bridge_add(dev, &ctx->bridge);
>  	if (ret)
> -		drm_bridge_remove(&ctx->bridge);
> -
> -	return ret;
> -}
> -
> +		return ret;
> =20
> +	return lt9211_host_attach(ctx);
>  }

[Severity: High]
Is there a devres order mismatch here that leads to a use-after-free?

Because devres actions are executed in reverse order of addition, registeri=
ng
the workqueue teardown action before registering the DSI device in
lt9211_host_attach() means the DSI device will be unregistered and freed
before the workqueue is destroyed.

During driver unbind, if the initialization work is pending, the workqueue
destruction flushes and executes it. The work function then calls
lt9211c_configure_rx(), which accesses the already freed ctx->dsi pointer.

Could the workqueue destruction be deferred until after the DSI device is
attached, or could the DSI device attachment be moved earlier in the probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-add-lt9211=
c-bridge-v8-0-36d66168e176@oss.qualcomm.com?part=3D2
