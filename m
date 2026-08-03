Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E0FC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24E710E761;
	Mon,  3 Aug 2026 18:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cLduoOmF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C01D10E761
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 18:27:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6C3860AA9;
 Mon,  3 Aug 2026 18:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E4E1F000E9;
 Mon,  3 Aug 2026 18:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785781640;
 bh=YKzOprLtohFv0KEenS/ctnXGc/voAI2HyKTrlPqFKbw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cLduoOmFZT2nZSZ43fOtFfyCzHRHf2icb5oOViK8ixd4wRVsj84hJRnLTAA5+LPR9
 HbfDLyLRi2qs+bgaBurfF2skC0uWIw0qlA4kZYvE4vSRDA3uQmGeh31ZEdylWfoLfO
 NJtJQrKvJXac2JITkPs6wl8Ex8Tz27u0ngH38iXhhronlFbIb0i/C0jAKfYSOhlMqI
 BB2f09q6JWlihw1htD5pl8hB+pHT4fA5bQslwiwx1AEh6CoC7/xbRVzcja0cMpsYVm
 MNyXsQa/Dmz/oNUtIW5VDctkHXRDpoug4KfcZiYcXKHxmaWbUo2ZIgZRTu3I3pz70U
 0+TGZhfCvigOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/22] drm/bridge: synopsys: dw-dp: Add missing mutex
 cleanups on module removal
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260803-synopsys-dw-dp-improvements-v9-6-2e6e46135312@collabora.com>
References: <20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com>
 <20260803-synopsys-dw-dp-improvements-v9-6-2e6e46135312@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:27:19 +0000
Message-Id: <20260803182720.58E4E1F000E9@smtp.kernel.org>
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
- [High] Missing Completion Reinitialization causes permanent link training=
 desynchronization on timeouts.
- [High] Concurrent hardware modification between the HPD worker and non-bl=
ocking atomic commits leads to hardware state corruption.
- [Medium] Hotplug events can be lost due to overwriting the single boolean=
 tracking variable `dp->hotplug.long_hpd` before the worker processes it.
--

--- Patch [6]: [PATCH v9 06/22] drm/bridge: synopsys: dw-dp: Add missing mu=
tex cleanups on module removal ---
commit d8b2520d774bd92589d70544eca3e846bc879920
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add missing mutex cleanups on module removal

The driver is currently missing to fully clean up after itself. Ensure
that the mutex is cleaned up.

Reported-by: Sashiko <sashiko-bot@kernel.org>

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index facd1c4799923..af3fa7886429b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -2039,9 +2039,12 @@ struct dw_dp *dw_dp_probe(struct platform_device *=
pdev, const struct dw_dp_plat_
>  	dp->pixel_mode =3D plat_data->pixel_mode;
>  	dp->plat_data.max_link_rate =3D plat_data->max_link_rate;
> =20
> -	mutex_init(&dp->irq_lock);
>  	init_completion(&dp->complete);

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the
completion initialization, I noticed a potential regression.

If dw_dp_aux_transfer() times out and returns -ETIMEDOUT, and a delayed
hardware reply or spurious IRQ later completes the completion:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_aux_transfer() {
	...
	regmap_write(dp->regmap, DW_DP_AUX_CMD, value);

	status =3D wait_for_completion_timeout(&dp->complete, timeout);
	...
}

Would a subsequent call to dw_dp_aux_transfer() immediately consume the sta=
le
completion since reinit_completion() is not called before the transfer?
Could this lead to garbage DPCD reads and permanent link training failure?

> =20
> +	ret =3D devm_mutex_init(dev, &dp->irq_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	res =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(res))
>  		return ERR_CAST(res);

[Severity: Medium]
This is a pre-existing issue, but could hotplug events be lost if a short
pulse overwrites the state before the worker processes it?

If a monitor is plugged in and asserts a long HPD pulse, and a short HPD
pulse occurs before the worker executes:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_handle_hpd_event() {
	...
	if (value & HPD_IRQ) {
		dev_dbg(dp->dev, "IRQ from the HPD\n");
		dp->hotplug.long_hpd =3D false;
		regmap_write(dp->regmap, DW_DP_HPD_STATUS, HPD_IRQ);
	}
	...
}

Does this overwrite the boolean flag, causing the worker to branch incorrec=
tly
and skip the hotplug notification?

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_hpd_work() {
	...
	if (!long_hpd) {
		if (dw_dp_needs_link_retrain(dp)) {
			ret =3D dw_dp_link_retrain(dp);
			...
}

[Severity: High]
This is a pre-existing issue, but I am wondering if there is a concurrent
hardware modification regression between the HPD worker and non-blocking
atomic commits.

The worker relies on connection_mutex, which DRM does not hold during
asynchronous atomic hardware commits:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_link_retrain() {
	...
	for (;;) {
		ret =3D drm_modeset_lock(&dev->mode_config.connection_mutex, &ctx);
		if (ret !=3D -EDEADLK)
			break;

		drm_modeset_backoff(&ctx);
	}
	...
}

Concurrently, dw_dp_bridge_atomic_enable() executes in the commit worker
without connection_mutex:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bridge_atomic_enable() {
	...
	ret =3D dw_dp_link_enable(dp);
	if (ret < 0) {
	...
}

Could both paths attempt to modify PHY and DPCD registers simultaneously,
leading to hardware corruption or link training failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-synopsys-d=
w-dp-improvements-v9-0-2e6e46135312@collabora.com?part=3D6
