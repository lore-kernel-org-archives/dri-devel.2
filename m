Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6419606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aa6+Vmnp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5000210FEE2;
	Wed, 25 Nov 2026 18:16:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A33B10FEE2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:16:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3518340BFF;
 Wed, 25 Nov 2026 18:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39921F000C6;
 Wed, 25 Nov 2026 18:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630592;
 bh=UAPcNrDP7QMdQleQr1VHH52beHerF6JQMHMGMwSexf0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aa6+VmnprloQtSJ6/Xu4G0v/wqbBjbCWN4alUZ2+qSyTmLVHHx/C3tW//qT929Zdk
 Ym2KnZYHai8u9P8Qlp9VKOHJJPZzUxeOB4JguLs9jarMjkHLrho2FzW08R5WTPa8LH
 +BUrx9IgRDtBgoqUgJuXq6Amrfx5MWv2EEeFi5IJp9UzxylQQpR02YZeF5CcCgkMMy
 deJS7lctrswXrdEh3EfaTx4jauYUSHRA14NzIVtwBU1p6PfmfYQ6LToVhKNDiSiY3N
 1UDyQNth78WHEu2Ah1kiKyJH270wqyeQDMHv80BNgeaIG1au3ZvJiTqB9k4k/NwDl5
 cVy45x4IX/ejw==
Message-ID: <sashiko-outbox-233947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/32] drm/bridge: ti-sn65dsi86: protect device
 resources on unplug
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-14-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-14-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:16:31 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/bridge: ti-sn65dsi86: release action registered on wrong
  device
- [High] drm/bridge: ti-sn65dsi86: unprotected HPD and debugfs callbacks
  on unplug
- [Medium] drm/bridge: unchecked devm_add_action() in
  ti_sn_bridge_atomic_pre_enable()
--

commit c57970c3929d58f60b46d5db47153169c16eb129
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: ti-sn65dsi86: protect device resources on unplug

This commit wraps hardware accesses in bridge callbacks with
drm_bridge_enter() and drm_bridge_exit(), uses a devres action to release
resources acquired in ti_sn_bridge_atomic_pre_enable(), and switches
ti_sn_bridge_remove() to drm_bridge_unplug().

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 48b83df9aed61..38318113a534f 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
[ ... ]
> @@ -1176,26 +1188,57 @@ static void ti_sn_bridge_atomic_enable(struct drm=
_bridge *bridge,
[ ... ]
> +static void ti_sn_bridge_release_resources(void *data)
> +{
> +	struct ti_sn65dsi86 *pdata =3D (struct ti_sn65dsi86 *)data;
> +
> +	if (!pdata->refclk)
> +		ti_sn65dsi86_disable_comms(pdata);
> +
> +	pm_runtime_put_sync(pdata->dev);
> +}
> =20
>  static void ti_sn_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>  					   struct drm_atomic_commit *state)
>  {
>  	struct ti_sn65dsi86 *pdata =3D bridge_to_ti_sn65dsi86(bridge);
> +	int idx;
> +
> +	if (!drm_bridge_enter(bridge, &idx))
> +		return;
> =20
>  	pm_runtime_get_sync(pdata->dev);
> =20
>  	if (!pdata->refclk)
>  		ti_sn65dsi86_enable_comms(pdata, state);
> =20
> +	devm_add_action(pdata->dev, ti_sn_bridge_release_resources, pdata);

[Severity: Medium]
Does an allocation failure in devm_add_action() leak the runtime PM
reference and comms state?

If devm_add_action() fails with -ENOMEM, ti_sn_bridge_release_resources()
is never queued, so a later ti_sn_bridge_atomic_post_disable() hits
WARN_ON(IS_ERR(dr)) in devm_release_action() and skips releasing the
resources.  Using devm_add_action_or_reset() would run
ti_sn_bridge_release_resources() immediately on failure.

> +
>  	/* td7: min 100 us after enable before DSI data */
>  	usleep_range(100, 110);
> +
> +	drm_bridge_exit(idx);
>  }
> =20
>  static void ti_sn_bridge_atomic_post_disable(struct drm_bridge *bridge,
>  					     struct drm_atomic_commit *state)
>  {
>  	struct ti_sn65dsi86 *pdata =3D bridge_to_ti_sn65dsi86(bridge);
> +	int idx;
> +
> +	if (!drm_bridge_enter(bridge, &idx))
> +		return;
> =20
>  	/* semi auto link training mode OFF */
>  	regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0);
> @@ -1204,17 +1247,21 @@ static void ti_sn_bridge_atomic_post_disable(stru=
ct drm_bridge *bridge,
>  	/* disable DP PLL */
>  	regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 0);
> =20
> -	if (!pdata->refclk)
> -		ti_sn65dsi86_disable_comms(pdata);
> +	devm_release_action(pdata->dev, ti_sn_bridge_release_resources, pdata);

[Severity: High]
Should ti_sn_bridge_release_resources() be registered on
&pdata->bridge_aux->dev instead of pdata->dev?

During probe, ti_sn_aux_probe() creates pdata->bridge_aux via
ti_sn65dsi86_add_aux_device() -> __devm_auxiliary_device_create(), which
queues auxiliary_device_destroy() on pdata->dev.  When
ti_sn_bridge_atomic_pre_enable() later registers
ti_sn_bridge_release_resources() on pdata->dev at modeset time, that action
is queued after auxiliary_device_destroy().

Because devres_release_all(pdata->dev) runs actions in reverse order on
parent I2C device unbind, ti_sn_bridge_release_resources() drops the
runtime PM reference and powers down the bridge before
auxiliary_device_destroy() invokes ti_sn_bridge_remove() ->
drm_bridge_unplug(&pdata->bridge).  Bridge callbacks can then still enter
drm_bridge_enter() while the chip is powered off, and a concurrent
ti_sn_bridge_atomic_post_disable() hits WARN_ON(IS_ERR(dr)) in
devm_release_action() once devres_release_all(pdata->dev) has detached the
action list.

Conversely, if the bridge auxiliary device is unbound directly (for example
during ti_sn65dsi86_exit(), which unregisters ti_sn_bridge_driver before
the I2C driver), ti_sn_bridge_remove() calls drm_bridge_unplug() while
ti_sn_bridge_release_resources() stays attached to pdata->dev, preventing
a subsequent ti_sn_bridge_atomic_post_disable() from releasing the runtime
PM reference.

[ ... ]

> @@ -1475,7 +1535,7 @@ static void ti_sn_bridge_remove(struct auxiliary_de=
vice *adev)
>  	if (!pdata)
>  		return;
> =20
> -	drm_bridge_remove(&pdata->bridge);
> +	drm_bridge_unplug(&pdata->bridge);

[Severity: High]
Are ti_sn_bridge_hpd_enable(), ti_sn_bridge_hpd_disable() and status_show()
still exposed to device resource accesses or runtime PM leaks on unplug?

In DisplayPort mode with an IRQ, ti_sn_bridge_hpd_enable() takes a runtime
PM reference with pm_runtime_get_sync(pdata->dev) and accesses
pdata->regmap until ti_sn_bridge_hpd_disable() runs:

drivers/gpu/drm/bridge/ti-sn65dsi86.c:ti_sn_bridge_hpd_enable() {
	...
	pm_runtime_get_sync(pdata->dev);
	...
	if (client->irq) {
		ret =3D regmap_set_bits(pdata->regmap, SN_IRQ_EVENTS_EN_REG,
				      HPD_REMOVAL_EN | HPD_INSERTION_EN);
	...
}

Neither HPD callback checks drm_bridge_enter(), and
ti_sn_bridge_hpd_enable() does not register a devres cleanup action for its
runtime PM reference.  If the bridge is unplugged while HPD is enabled, the
runtime PM reference is leaked across device unbind (keeping regulators and
refclk enabled), or a subsequent HPD disable accesses pdata->regmap after
drm_bridge_unplug() completes.

Similarly, status_show() in connector debugfs calls
pm_runtime_get_sync(pdata->dev) and regmap_read(pdata->regmap, ...) without
drm_bridge_enter() and drm_bridge_exit() protection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D14
