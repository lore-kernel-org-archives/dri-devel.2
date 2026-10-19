Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26490CCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA7C10EA17;
	Mon, 19 Oct 2026 10:34:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F189910EA17
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:34:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6599A4161E;
 Mon, 19 Oct 2026 10:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009531F000C4;
 Mon, 19 Oct 2026 10:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792406047;
 bh=BxFJg1WeFW7LYxavisv8eBBfuyz6duDUtX3mBa2YhYs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a8HY3GLWLkQWLh72816xMNviirN4f0vjbLH2kvDhaKa0n4iULLYjbXftjvW5Kzwos
 Yak6w1RKrPXL93g26dgM2oy4X48ak8F5aS9o1SdciNQySjTX8Y471p7hguuPGXNRLd
 1Xtdg5jXLKAaebefb2HXaohnqkkvIcxFwfn2J9YcVoCl9rmUXpGPu0e63wSQpgy9FQ
 yNntfbEiOCAB2y+x0kqDGjR1FaP26REvYNk0MSwNJ6OFutZuXfKWiVoYRgjg8LObgL
 6KVcYiu+bI3xBs7zzvXU9RvIKy1RyTSQD5wCJibID0Ej5jMcW/yf3cZjQbHKlOuhXO
 U7YNJTz6BmB8w==
Message-ID: <sashiko-outbox-176995@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/bridge: simple-bridge: Support
 data-enable-active endpoint property
To: "Leonardo Costa" <leoreis.costa@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261019-v2-apalis-imx6-enable-vga-v2-2-ef6a3a780472@toradex.com>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
 <20261019-v2-apalis-imx6-enable-vga-v2-2-ef6a3a780472@toradex.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:34:06 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/bridge: simple-bridge: missing atomic_check() to propagate DE =
bus flags
- [Medium] drm/bridge: simple-bridge: timings devm_kzalloc() lifetime misma=
tch
--

commit 17d03fa8dcd99e5bb3af7da622344c856ca2c887
Author: Leonardo Costa <leonardo.costa@toradex.com>

drm/bridge: simple-bridge: Support data-enable-active endpoint property

This commit reads the data-enable-active property from the input endpoint in
simple_bridge_probe() and allocates a drm_bridge_timings structure to set
DRM_BUS_FLAG_DE_HIGH or DRM_BUS_FLAG_DE_LOW in input_bus_flags when the bri=
dge
does not already define its own timings.

> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bri=
dge/simple-bridge.c
> index 3fba7002322e9..393228bed6e28 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -171,6 +171,9 @@ static int simple_bridge_probe(struct platform_device=
 *pdev)
>  {
>  	struct simple_bridge *sbridge;
>  	struct device_node *remote;
> +	struct device_node *ep;
> +	bool de_present;
> +	u32 de;
> =20
>  	sbridge =3D devm_drm_bridge_alloc(&pdev->dev, struct simple_bridge,
>  					bridge, &simple_bridge_bridge_funcs);
> @@ -208,10 +211,26 @@ static int simple_bridge_probe(struct platform_devi=
ce *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(sbridge->enable),
>  				     "Unable to retrieve enable GPIO\n");
> =20
> -	/* Register the bridge. */
>  	sbridge->bridge.of_node =3D pdev->dev.of_node;
>  	sbridge->bridge.timings =3D sbridge->info->timings;
> =20
> +	ep =3D of_graph_get_endpoint_by_regs(pdev->dev.of_node, 0, -1);
> +	de_present =3D !of_property_read_u32(ep, "data-enable-active", &de);
> +	of_node_put(ep);
> +
> +	if (de_present && !sbridge->bridge.timings) {
> +		struct drm_bridge_timings *timings;
> +
> +		timings =3D devm_kzalloc(&pdev->dev, sizeof(*timings), GFP_KERNEL);
> +		if (!timings)
> +			return -ENOMEM;

[Severity: Medium]
Can allocating timings with devm_kzalloc() in simple_bridge_probe() cause a
lifetime mismatch with sbridge->bridge?

sbridge is allocated via devm_drm_bridge_alloc(), which manages the contain=
er's
lifetime through sbridge->bridge.refcount and only frees it in
__drm_bridge_free() after all drm_bridge references are dropped:

drivers/gpu/drm/drm_bridge.c:__drm_bridge_free()
	if (bridge->funcs->destroy)
		bridge->funcs->destroy(bridge);

	drm_bridge_put(bridge->next_bridge);

	kfree(bridge->container);

If pdev is unbound while an upstream bridge or encoder still holds a refere=
nce
to sbridge->bridge, devres_release_all() will free timings immediately, lea=
ving
sbridge->bridge.timings as a dangling pointer that can be dereferenced by
upstream drivers (for example, in imx8mp_hdmi_pvi_bridge_enable()).

Would embedding struct drm_bridge_timings inside struct simple_bridge (as d=
one
in lvds-codec.c and ti-tfp410.c), or pointing to static const
drm_bridge_timings instances for DRM_BUS_FLAG_DE_HIGH and DRM_BUS_FLAG_DE_L=
OW,
avoid this lifetime mismatch?

> +
> +		timings->input_bus_flags =3D de ? DRM_BUS_FLAG_DE_HIGH :
> +						DRM_BUS_FLAG_DE_LOW;
> +		sbridge->bridge.timings =3D timings;
> +	}

[Severity: High]
Will setting only sbridge->bridge.timings->input_bus_flags actually propaga=
te
the DE polarity to upstream atomic encoders and bridges?

simple_bridge_bridge_funcs registers atomic state callbacks without an
.atomic_check callback:

drivers/gpu/drm/bridge/simple-bridge.c:
static const struct drm_bridge_funcs simple_bridge_bridge_funcs =3D {
	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
	.attach		=3D simple_bridge_attach,
	.atomic_enable =3D simple_bridge_enable,
	.atomic_disable =3D simple_bridge_disable,
};

During an atomic modeset, drm_atomic_bridge_chain_check() calls
drm_atomic_bridge_propagate_bus_flags(), which overwrites
bridge_state->input_bus_cfg.flags with output_flags from the downstream bri=
dge
or connector (0 for a VGA connector) and never checks
bridge->timings->input_bus_flags:

drivers/gpu/drm/drm_bridge.c:drm_atomic_bridge_propagate_bus_flags()
	bridge_state->output_bus_cfg.flags =3D output_flags;
	...
	bridge_state->input_bus_cfg.flags =3D output_flags;

Because simple-bridge has a valid drm_bridge_state, upstream bridges and at=
omic
encoders such as imx_pd_bridge_atomic_check() in
drivers/gpu/drm/imx/ipuv3/parallel-display.c read
next_bridge_state->input_bus_cfg.flags instead of
next_bridge->timings->input_bus_flags:

drivers/gpu/drm/imx/ipuv3/parallel-display.c:imx_pd_bridge_atomic_check()
	if (next_bridge_state)
		bus_flags =3D next_bridge_state->input_bus_cfg.flags;
	else
		bus_flags =3D di->bus_flags;

As a result, bus_flags remains 0 instead of DRM_BUS_FLAG_DE_LOW or
DRM_BUS_FLAG_DE_HIGH.

Should simple_bridge_bridge_funcs implement an .atomic_check callback that
copies sbridge->bridge.timings->input_bus_flags into
bridge_state->input_bus_cfg.flags (similar to tfp410_atomic_check() in
drivers/gpu/drm/bridge/ti-tfp410.c)?

> +
> +	/* Register the bridge. */
>  	return devm_drm_bridge_add(&pdev->dev, &sbridge->bridge);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-v2-apalis-=
imx6-enable-vga-v2-0-ef6a3a780472@toradex.com?part=3D2
