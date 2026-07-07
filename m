Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C76C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E528710EBFE;
	Tue,  7 Jul 2026 09:00:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O2rnbqeH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C0510EBFE
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 09:00:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B99A8618AE;
 Tue,  7 Jul 2026 09:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D36D1F000E9;
 Tue,  7 Jul 2026 09:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783414844;
 bh=gpkE7NHIPZiEZUqWiQm69t/023+nafQT48/IzM6K3oo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O2rnbqeHF2Y7ajfWg9vI5ApShlmk6ihr3QAVGy2ExORdIN59lJqXNJro0ALHpRgb7
 W3jkR1SL2bbXUvAVqFNcmA9gjicX6gpy63QGjW0+Ej7y1j46QY0XY31NUtBLvzvTxe
 bFTO+SmVpo3UJnZ1QS9xxRZ+jtPOoEwQSNT5DyI/sGCtd2cWFyexA1ur37GibnRlFM
 bUYkVqgBMzrqITJfKqsHMQHYNNptINngVZB6bOhkpqd8pcjEslmTFat59wHJD5JeeD
 TD+IIfORqaY7BDxAB5Tvd+GGrVFxHQsfyyK29lEi9PLQUI0sOyKATQfJm1v7/FQAor
 nwaa7YKS0y5dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: sn65dsi83: perform host_attach on attach
 instead of probe
To: "Paul Geurts" <paul.geurts@prodrive-technologies.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707084655.2206320-1-paul.geurts@prodrive-technologies.com>
References: <20260707084655.2206320-1-paul.geurts@prodrive-technologies.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:00:43 +0000
Message-Id: <20260707090044.3D36D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Moving `devm_mipi_dsi_device_register_full()` and `devm_mipi_dsi_a=
ttach()` to the DRM bridge `.attach` callback causes duplicate registration=
s, resource leaks, and permanent failures if probe defers or unbinds occur.
- [High] Moving `mipi_dsi_attach()` to the DRM bridge `.attach` callback cr=
eates a circular dependency with DSI hosts (like samsung-dsim) that rely on=
 device attach to register their own DRM bridge.
- [Medium] Using `dev_err()` instead of `dev_err_probe()` for host attachme=
nt failures causes log spam on expected probe deferrals.

Pre-existing issues:
- [High] If the MIPI DSI host unbinds before the sn65dsi83 bridge, the DSI =
device is freed, leading to a use-after-free when the bridge's devres actio=
n fires.
- [Medium] If the device tree is missing the endpoint, the driver incorrect=
ly returns `-EPROBE_DEFER` instead of a hard error, leading to an infinite =
deferral loop.
--

--- Patch [1]: [PATCH] drm/bridge: sn65dsi83: perform host_attach on attach=
 instead of probe ---
commit 246eecbf86024f7bc9178b065620b4bc9cfe26df
Author: Paul Geurts <paul.geurts@prodrive-technologies.com>

drm/bridge: sn65dsi83: perform host_attach on attach instead of probe

This patch moves the sn65dsi83 DSI host attachment from the probe function
to the DRM bridge attach callback. This is intended to break an infinite
probe deferral loop between the i.MX8M Mini MIPI DSI host and the bridge.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index e6dbe51d0dba9..637a29ab284f8 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -288,6 +288,8 @@ static const int lvds_vod_swing_clock_table[2][4][2] =
=3D {
> [ ... ]
> @@ -298,6 +300,13 @@ static int sn65dsi83_attach(struct drm_bridge *bridg=
e,
>  			    enum drm_bridge_attach_flags flags)
>  {
>  	struct sn65dsi83 *ctx =3D bridge_to_sn65dsi83(bridge);
> +	int ret =3D 0;
> +
> +	ret =3D sn65dsi83_host_attach(ctx);

[Severity: High]
Does moving the devm-managed registrations into the bridge attach callback
cause resource leaks on failures?

The drm_bridge_attach() callback can be called multiple times if the DRM
pipeline bind process defers due to downstream components. Because the
devm_mipi_dsi_device_register_full() and devm_mipi_dsi_attach() allocations
inside sn65dsi83_host_attach() are tied to the I2C device which hasn't
unbound, a failure later in the attach process doesn't clean them up.

The next attach attempt might try to register a new DSI device with the
same name, resulting in an -EEXIST failure and permanently breaking the
display pipeline.

[Severity: High]
Could delaying the DSI host attach until the DRM bridge attach callback
create a circular dependency where the KMS pipeline can never be built?

If a DSI host (like samsung-dsim) expects to register its own DRM bridge
inside its mipi_dsi_host_ops.attach callback, that will now only happen when
sn65dsi83_attach() is called.

However, sn65dsi83_attach() is only called during the DRM pipeline bind
phase. This bind phase will fail and return -EPROBE_DEFER because it cannot
find the host's bridge (which hasn't been registered yet). This forms a
deadlock where the pipeline defers and never calls sn65dsi83_attach().

[Severity: High]
This is a pre-existing issue, but does sn65dsi83_host_attach() create a
use-after-free risk if the DSI host unbinds before the bridge?

Inside sn65dsi83_host_attach(), the child DSI device is registered using
devm_mipi_dsi_device_register_full(dev, host, &info). The device is added
as a child of the MIPI DSI host.

If the DSI host driver unbinds, it unregisters all children, freeing the
DSI device. However, the devm action is tied to the sn65dsi83 I2C bridge
device. If the bridge later unbinds, its devres cleanup will call
mipi_dsi_device_unregister() on the already-freed pointer.

[Severity: Medium]
This is a pre-existing issue, but does sn65dsi83_host_attach() mask device
tree configuration errors?

If the device tree is missing the endpoint, of_graph_get_endpoint_by_regs()
returns NULL. This cascades to the host being NULL, and the function returns
-EPROBE_DEFER. Should this return a hard error like -EINVAL instead of
deferring indefinitely when the endpoint is entirely missing?

> +	if (ret) {
> +		dev_err(ctx->dev, "Failed to attach DSI host %d\n", ret);

[Severity: Medium]
Will this spam the kernel log with errors during expected probe deferrals?

If the DSI host is not yet available, sn65dsi83_host_attach() will return
-EPROBE_DEFER. Since dev_err() is used here instead of dev_err_probe() or
an explicit check, it will log an error on every deferred bind attempt.

> +		return ret;
> +	}
> =20
>  	return drm_bridge_attach(encoder, ctx->panel_bridge,
> [ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707084655.2206=
320-1-paul.geurts@prodrive-technologies.com?part=3D1
