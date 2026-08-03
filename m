Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D26C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3FE710E76F;
	Mon,  3 Aug 2026 18:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ewtzql0K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23A010E762
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:35:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B9C91406D6;
 Mon,  3 Aug 2026 18:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4C81F000E9;
 Mon,  3 Aug 2026 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785782128;
 bh=0AqkjNDFJtarMC02jJHMihgGFupN6Tfle49TtbjmOjM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ewtzql0K7f0mM7BIuB2QZV3u++jOvj5D0C/yWNvqHPvtH/evWtkLgQHhT4KXOOAQN
 Ice/OVHRqkhTnNk7UZZ7MbNkf175XHAsXvGWLq8M7Iqn52MpweZ4RCTGSzk4bx5xz3
 +SAWC9sJ1UDsJ/91QOgMQh9KgEYcrgjFKtE7H01w6L5HOvnjtnoxeWVNLHOZ68Iu6s
 8+/xk2zQw4+0oWY72kbpmFq8gri2S+SwMpTyBRtyRn7H1SlUttDpI/ysDWCjQUkH5w
 dlmY3kD3xLCKNRtOfw0291S6v4D5GvZX/yTfPKpuV2wM70RVXbEMA18c3FYtfWvedW
 8h513AAF/qzQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/22] drm/bridge: synopsys: dw-dp: Cancel pending
 HPD work
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260803-synopsys-dw-dp-improvements-v9-4-2e6e46135312@collabora.com>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
 <20260803-synopsys-dw-dp-improvements-v9-4-2e6e46135312@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:35:27 +0000
Message-Id: <20260803183528.4F4C81F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The patch uses `devm_work_autocancel()` to stop the HPD worker, bu=
t relies on devres cleanup which executes during device removal rather than=
 component unbind, leaving a TOCTOU race window where the worker can access=
 freed memory.
- [High] Bridge registration occurs before probe completion, leading to pot=
ential Use-After-Free if a subsequent probe step fails.
- [High] Sleeping delay and polling functions are called from atomic contex=
t in `dw_dp_bridge_atomic_disable()`.
- [Medium] Unbounded loop in `dw_dp_link_clock_recovery` can cause a kernel=
 thread hang.
--

--- Patch [4]: [PATCH v9 04/22] drm/bridge: synopsys: dw-dp: Cancel pending=
 HPD work ---
commit c38b05d3219e4122c1777f880ab0fd447f213375
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Cancel pending HPD work
   =20
There is a race condition during device removal: If the HPD interrupt
started an HPD worker exactly when the device is removed, the worker
thread might access invalid resources. Avoid this by stopping any
pending work immediately after disabling the interrupt.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index e332d66b80571..278953a8549a2 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -2120,6 +2120,10 @@ struct dw_dp *dw_dp_probe(struct platform_device *=
pdev, const struct dw_dp_plat_
>  	if (dp->irq < 0)
>  		return ERR_PTR(dp->irq);
> =20

[Severity: High]
This is a pre-existing issue, but can this error path lead to a
use-after-free?

Just before this block in dw_dp_probe(), the bridge is registered globally:

    ret =3D devm_drm_bridge_add(dev, bridge);
    if (ret)
            return ERR_PTR(ret);

If a subsequent step like devm_work_autocancel() or
devm_request_threaded_irq() fails, the probe aborts and devres cleans up
the allocated memory. If another driver discovers and references the bridge
between registration and this failure, will it dereference freed memory?

> +	ret =3D devm_work_autocancel(dev, &dp->hpd_work, dw_dp_hpd_work);
> +	if (ret)
> +		return ERR_PTR(ret);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this fix fully resolve
the race condition during component unbind?

The patch uses devm_work_autocancel() to stop the HPD worker during device
removal (devres cleanup). However, dw_dp_unbind() is currently empty and
does not disable the IRQ or cancel the work:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_unbind() {
    /* nothing to do */
}

If the component master unbinds, it initiates the destruction of the DRM
device while the worker might still be scheduled. The worker locklessly rea=
ds
dp->bridge.dev:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_hpd_work() {
    ...
    if (!dp->bridge.dev)
            return;
    ...
}

This creates a time-of-check to time-of-use race with drm_bridge_detach(),
which clears the device pointer. Could this lead to a use-after-free when
the worker proceeds to use the freed DRM device in dw_dp_link_retrain()?

>  	ret =3D devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
>  					IRQF_ONESHOT, dev_name(dev), dp);
>  	if (ret) {


While reviewing this file, I noticed a couple of other pre-existing issues
that might need attention:

[Severity: Medium]
This is a pre-existing issue, but I noticed a potential unbounded loop
in dw_dp_link_clock_recovery():

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_link_clock_recovery() {
    ...
    for (;;) {
        ...
        adj_changed =3D dw_dp_link_get_adjustments(link, status);
        if (!adj_changed)
            tries++;
        else
            tries =3D 0;

        if (tries =3D=3D 5)
            break;
    }
}

If a non-compliant or malicious DP sink continually alternates its
adjustment requests, dw_dp_link_get_adjustments() will continuously
return true. Since tries is repeatedly reset to 0, does this prevent
the loop from ever exiting and cause a kernel thread hang?


[Severity: High]
This isn't a bug introduced by this patch, but does the bridge disable
sequence sleep in atomic context?

During a DRM atomic commit, drm_atomic_helper_commit_tail() runs in an
atomic context. It disables bridges, calling dw_dp_bridge_atomic_disable(),
which calls dw_dp_reset() unconditionally:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bridge_atomic_disable() {
    ...
    dw_dp_reset(dp);
    pm_runtime_put_autosuspend(dp->dev);
}

Inside dw_dp_reset(), the code calls sleeping functions:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_reset() {
    ...
    usleep_range(10, 20);
    ...
    regmap_read_poll_timeout(dp->regmap, DW_DP_HPD_STATUS, val,
                             FIELD_GET(HPD_HOT_PLUG, val), 200, 200000);
}

Can this violation of kernel locking rules lead to warnings and potential
deadlocks during an atomic mode-set or display disable sequence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-synopsys-d=
w-dp-improvements-v9-0-2e6e46135312@collabora.com?part=3D4
