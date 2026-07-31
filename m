Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9BCC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 846B410F2D1;
	Fri, 31 Jul 2026 15:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GOxmtpiw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C63D10F2D1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:30:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 672096004E;
 Fri, 31 Jul 2026 15:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC6B1F000E9;
 Fri, 31 Jul 2026 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785511809;
 bh=WzdVo8q3b91/FoccTpw8l7GtCfa4SvJ3/H3fGuD7iUI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GOxmtpiwlaFAHgl+oZJjGFJnW18ISeuAsvwgiUGiMgssMpscxjmVEmTEBIj5V1H9B
 NAmCtiztTexgyslTwtNkN46dBAjLh8m9zpYEpSUPn3nVDPKMWKG0LNZvAdUgnxxlyP
 VH80Su3bkHjEWVpe8drXdAywjbizrKJmEInmqzK3Rj9hL/B+a5l1pf83DhDxoeOgmN
 P4uBLHu4fCZMOeegkgB/TL9topvVh8YQKZqA53z5ubjdIDhFuf3Ug/iarDbe0SLDkq
 3UcK3SB8TcHK6o1IBoxCV00liriZK++GDH34AB4nUP3YdAB503P/nw86oFtA4GF1fB
 WBz/1f0FoO9Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/21] drm/bridge: synopsys: dw-dp: Cancel pending
 HPD work
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-3-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
 <20260731-synopsys-dw-dp-improvements-v8-3-ac1e6a75782f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 15:30:08 +0000
Message-Id: <20260731153008.CCC6B1F000E9@smtp.kernel.org>
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
- [High] The HPD worker `dw_dp_hpd_work` unconditionally accesses `dp->brid=
ge.dev`, causing a NULL pointer dereference or use-after-free.
- [High] Missing `reinit_completion()` in `dw_dp_aux_transfer()` causes pre=
mature completions after a previous timeout.
- [High] Sleeping functions are called from within the `dw_dp_bridge_atomic=
_disable` callback.
--

--- Patch [3]: [PATCH v8 03/21] drm/bridge: synopsys: dw-dp: Cancel pending=
 HPD work ---
commit 2a199fd0ed454a3e93c9003823239c66f8489c2a
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Cancel pending HPD work

There is a race condition during device removal: If the HPD interrupt
started an HPD worker exactly when the device is removed, the worker
thread might access invalid resources. Avoid this by stopping any
pending work immediately after disabling the interrupt.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support =
library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 7f82495141711..6289ed06e2317 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
[ ... ]
> @@ -2027,7 +2028,6 @@ struct dw_dp *dw_dp_probe(struct platform_device *p=
dev, const struct dw_dp_plat_
>  	dp->plat_data.max_link_rate =3D plat_data->max_link_rate;
> =20
>  	mutex_init(&dp->irq_lock);
> -	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);
>  	init_completion(&dp->complete);

[Severity: High]
This is a pre-existing issue, but can dw_dp_aux_transfer() complete=20
prematurely after a timeout?

We initialize the completion here, but dw_dp_aux_transfer() calls=20
wait_for_completion_timeout(&dp->complete, timeout) without calling=20
reinit_completion() before starting the transfer.

If a previous transfer times out, but a delayed hardware interrupt=20
later calls complete(&dp->complete), won't the next call to=20
wait_for_completion_timeout() return immediately with the stale=20
completion state?

> =20
>  	res =3D devm_platform_ioremap_resource(pdev, 0);
[ ... ]
> @@ -2108,6 +2108,10 @@ struct dw_dp *dw_dp_probe(struct platform_device *=
pdev, const struct dw_dp_plat_
>  	if (dp->irq < 0)
>  		return ERR_PTR(dp->irq);
> =20
> +	ret =3D devm_work_autocancel(dev, &dp->hpd_work, dw_dp_hpd_work);

[Severity: High]
This isn't a bug introduced by this patch, but does the devres cleanup=20
still leave a window for a NULL pointer dereference in the worker?

Looking at dw_dp_hpd_work(), it unconditionally accesses dp->bridge.dev:

dw_dp_hpd_work()
   drm_helper_hpd_irq_event(dp->bridge.dev);

And in dw_dp_link_retrain(), it does:

dw_dp_link_retrain()
   ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, &ctx);

During component bind/unbind, drm_bridge_attach() sets up and tears down=20
bridge->dev. Since component_del() is typically called before devres=20
actions, the DRM device is unbound and bridge->dev becomes NULL before=20
this devm_work_autocancel() takes effect. Does this allow a pending HPD=20
interrupt to execute the worker against a NULL or freed bridge->dev=20
during teardown?

> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	ret =3D devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
>  					IRQF_ONESHOT, dev_name(dev), dp);
>  	if (ret) {

[Severity: High]
This is a pre-existing issue, but can the atomic disable path sleep?

According to the DRM subsystem rules, atomic disable callbacks run in=20
atomic context and cannot sleep. However, the driver's=20
dw_dp_bridge_atomic_disable() unconditionally calls dw_dp_reset(), which=20
contains sleeping functions:

dw_dp_bridge_atomic_disable()
   dw_dp_reset()
      usleep_range(10, 20);

Since usleep_range() and disable_irq() can sleep, does this cause kernel=20
warnings or deadlocks when the DRM core disables the display pipeline=20
during modesetting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-synopsys-d=
w-dp-improvements-v8-0-ac1e6a75782f@collabora.com?part=3D3
