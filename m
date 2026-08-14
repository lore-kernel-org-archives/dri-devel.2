Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2622C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6096610E578;
	Fri, 14 Aug 2026 14:24:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LNjYvP1h";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9275610E56C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:24:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F3A04023F;
 Fri, 14 Aug 2026 14:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128F01F000E9;
 Fri, 14 Aug 2026 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786717461;
 bh=iQcg3ogX8FJ6wWjk2dgIsIHrwkh6xSYiEXbxhtTL7oc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LNjYvP1ha7NPLAFGCDhRl1rMPRXjSKaj8PxAevPQL1rw1ugGDclfi68cbn4O9vpJ7
 vfUueQXewz7TRI+vOpdoXBR/mviK5rIoiYn/rDdoA9RYOLIqoek6/j9r5+IYXAUIEE
 89PgAV779ymeIjqqCw8xoz/K4Bxh3flBFHaPCyn+BQTxEGURfGto00WU3v63LUIm9y
 J9lYzmgMHpfag9Da6WoMQPrNdQ/ZFPXUP+5ZDB/ppwr8rYq1vaFLUJFMeqWS/olZXH
 NfcSQET7TDKxtSa/rrWpNzT63M4xGQI4asl8YghMAMZ4MgkVsOZNMzwKVZ9FQK0tvT
 S9g5UMaosoi1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] drm/mcde: dsi: don't create a panel_bridge
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-bridge-every-panel-v1-9-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-9-19cd5277cc8d@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:24:20 +0000
Message-Id: <20260814142421.128F01F000E9@smtp.kernel.org>
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
- [High] The reference to the remote bridge (next_bridge) acquired during b=
ind is permanently leaked on unbind.

Pre-existing issues:
- [High] Component unbind is missing drm_bridge_remove(), leading to list c=
orruption and memory leaks upon rebind or module unload.
- [High] The driver returns -EINVAL instead of -EPROBE_DEFER when the downs=
tream bridge is not found, breaking probe deferral.
- [High] Calling devm_clk_get() inside a repeatable component bind function=
 causes a devres leak.
--

--- Patch [9]: [PATCH 09/11] drm/mcde: dsi: don't create a panel_bridge ---
commit 62f9247edbd74ae414416ce89cd9ec90e6811731
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/mcde: dsi: don't create a panel_bridge

Now a panel_bridge is automatically created for every drm_panel, so this
code (similar to an open-coded variant of drm_of_find_panel_or_bridge())
would lead to creating a second panel_bridge for the same panel.

> diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_=
dsi.c
> index ce078aa3910f2..ec45440d20d70 100644
> --- a/drivers/gpu/drm/mcde/mcde_dsi.c
> +++ b/drivers/gpu/drm/mcde/mcde_dsi.c
[ ... ]
> @@ -1076,7 +1075,6 @@ static int mcde_dsi_bind(struct device *dev, struct=
 device *master,
>  	struct drm_device *drm =3D data;
>  	struct mcde *mcde =3D to_mcde(drm);
>  	struct mcde_dsi *d =3D dev_get_drvdata(dev);
> -	struct drm_panel *panel =3D NULL;

[Severity: High]
This is a pre-existing issue, but does calling devm_clk_get() inside
mcde_dsi_bind() cause a devres memory leak?

Since component drivers can be unbound and rebound multiple times (such as
via sysfs or master probe deferral), devres allocations in the bind
path will accumulate every time the component binds, because devres chunks
are bound to the platform device's lifetime, not the component bind/unbind
lifecycle.

[ ... ]
> @@ -1104,40 +1102,21 @@ static int mcde_dsi_bind(struct device *dev, stru=
ct device *master,
> =20
>  	/* Look for a panel as a child to this node */
>  	for_each_available_child_of_node_scoped(dev->of_node, child) {
> -		panel =3D of_drm_find_panel(child);
> -		if (IS_ERR(panel)) {
> -			dev_err(dev, "failed to find panel try bridge (%ld)\n",
> -				PTR_ERR(panel));
> -			panel =3D NULL;
> -
> -			bridge =3D of_drm_find_and_get_bridge(child);
> -			if (!bridge) {
> -				dev_err(dev, "failed to find bridge\n");
> -				return -EINVAL;
> -			}
> +		bridge =3D of_drm_find_and_get_bridge(child);
> +		if (!bridge) {
> +			dev_err(dev, "failed to find bridge\n");
> +			return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but should this return
-EPROBE_DEFER instead of -EINVAL when the downstream bridge is not found?

Returning a hard -EINVAL when of_drm_find_and_get_bridge() returns NULL
aborts the display probe irrevocably if the downstream panel/bridge probes
after the MCDE DSI host, rather than deferring the probe until it is ready.

[ ... ]
> @@ -1159,8 +1138,6 @@ static void mcde_dsi_unbind(struct device *dev, str=
uct device *master,
>  {
>  	struct mcde_dsi *d =3D dev_get_drvdata(dev);
> =20
> -	if (d->panel)
> -		drm_panel_bridge_remove(d->bridge.next_bridge);

[Severity: High]
Since this patch removes drm_panel_bridge_remove(), is a call to
drm_bridge_put(d->bridge.next_bridge) needed here to balance the reference
acquired in mcde_dsi_bind()?

In mcde_dsi_bind(), a reference to the downstream bridge is acquired and
stored via:

    d->bridge.next_bridge =3D drm_bridge_get(bridge);

Without a corresponding drm_bridge_put() here, the reference is stranded.
Upon the next rebind, a new reference is acquired and overwrites the old
pointer, permanently leaking the downstream bridge reference.

[Severity: High]
This is a pre-existing issue, but is a call to drm_bridge_remove(&d->bridge)
missing from mcde_dsi_unbind()?

mcde_dsi_bind() registers the bridge globally via
drm_bridge_add(&d->bridge). Without drm_bridge_remove() in the unbind path,
a rebind will call drm_bridge_add() on the same bridge object.

This invokes list_del_init(&bridge->list) without holding the bridge_lock,
introducing a data race that can corrupt the global bridge_list if traversed
concurrently. Additionally, it prevents the bridge's refcount from ever
reaching zero.

>  	regmap_update_bits(d->prcmu, PRCM_DSI_SW_RESET,
>  			   PRCM_DSI_SW_RESET_DSI0_SW_RESETN, 0);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-bridge=
-every-panel-v1-0-19cd5277cc8d@bootlin.com?part=3D9
