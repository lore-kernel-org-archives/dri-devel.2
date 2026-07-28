Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31BEC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07BB110E90E;
	Tue, 28 Jul 2026 14:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nzWGKaPj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F8310E90D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:04:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A944860A77;
 Tue, 28 Jul 2026 14:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CC21F000E9;
 Tue, 28 Jul 2026 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785247451;
 bh=7bRDoEeLAxKSlDCywHX/Hl6y+eo3pF7vZKKs+imgsmE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nzWGKaPjfcYTCV+kjHnMRMRpE47P0ZCgJdSRuwdDi3g66DGZOa68Dqztj1fZYDQJt
 MWmDOFyNQny+3xY/9rEWhiNnMJu62bYwchjaHO4j8YjXfL0FZo1ngPSv6fas45qCUI
 0TISSAP9q831NpS9Hqw7LssnFg0boksIwnjrj68MwTt9cNMEg4S6cwYb/MqrZMXOpX
 lV9iOwWHmRb2glBC1VDXgpv9YwoqKdtBm36/75/B7oOuklfVdJX8dlem4yMhB7LDE5
 81/s73CN0A7OXVXjmihVxddBa27vM93AsFqOvt1/Up6K9eNmWo9V84xdhcGPhBB6Mx
 B9bXk0bQoWpfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: adv7511: cancel HPD work during teardown
To: "Hongyan Xu" <getshell@seu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728135205.859-1-getshell@seu.edu.cn>
References: <20260728135205.859-1-getshell@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 14:04:10 +0000
Message-Id: <20260728140411.41CC21F000E9@smtp.kernel.org>
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
- [High] drm_bridge_add() is called prematurely in adv7511_probe(), exposin=
g the bridge to concurrent access before initialization completes and riski=
ng a Use-After-Free if later probe steps fail.
- [High] Hardware regulators are disabled before the DRM bridge is unregist=
ered in adv7511_remove(), allowing concurrent I2C access to powered-down ha=
rdware.
- [High] Concurrent execution of HPD work and bridge detection modifies har=
dware sequences and state without synchronization.
--

--- Patch [1]: [PATCH] drm/bridge: adv7511: cancel HPD work during teardown=
 ---
commit b44080d3f93c1a423486c2876b7db016031c7403
Author: Hongyan Xu <getshell@seu.edu.cn>

drm/bridge: adv7511: cancel HPD work during teardown

The threaded IRQ handler queues hpd_work. The work accesses the regmap
and calls drm_bridge_hpd_notify(), so it must not run after the bridge or
the devm-allocated driver data has been released.

Free the IRQ before cancelling hpd_work so the handler cannot queue the
work again. Do this in remove and when adv7533_attach_dsi() fails after
the IRQ has been registered.

The remove-side race was reported previously, but the proposed fix did
not cover the late probe failure path.

This issue was found by a static analysis tool.

Link: https://lore.kernel.org/r/20230413065943.198088-1-zyytlz.wz@163.com

> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index db99e252aeebc..316b9f80d7429 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1400,11 +1400,15 @@ static int adv7511_probe(struct i2c_client *i2c)
>  	if (adv7511->info->has_dsi) {
>  		ret =3D adv7533_attach_dsi(adv7511);
>  		if (ret)
> -			goto err_unregister_audio;
> +			goto err_free_irq;
>  	}
> =20
>  	return 0;
> =20
> +err_free_irq:
> +	if (i2c->irq)
> +		devm_free_irq(dev, i2c->irq, adv7511);
> +	cancel_work_sync(&adv7511->hpd_work);
>  err_unregister_audio:
>  	drm_bridge_remove(&adv7511->bridge);

[Severity: High]
This is a pre-existing issue, but is it safe to expose the bridge before pr=
obe
completes?

drm_bridge_add() is called earlier in adv7511_probe(), before critical
structures like the waitqueue are initialized:

	drm_bridge_add(&adv7511->bridge);

	if (i2c->irq) {
		init_waitqueue_head(&adv7511->wq);

If a concurrent KMS driver discovers the bridge and initiates operations,
could it crash on the uninitialized waitqueue?

For example, adv7511_wait_for_edid() accesses this waitqueue:

		ret =3D wait_event_interruptible_timeout(adv7511->wq,
				adv7511->edid_read, msecs_to_jiffies(timeout));

Also, if the probe subsequently fails and we reach this cleanup path,
could the concurrent KMS driver be left with a dangling pointer to
devres-allocated memory?

[ ... ]
> @@ -1425,6 +1429,10 @@ static void adv7511_remove(struct i2c_client *i2c)
>  {
>  	struct adv7511 *adv7511 =3D i2c_get_clientdata(i2c);
> =20
> +	if (i2c->irq)
> +		devm_free_irq(&i2c->dev, i2c->irq, adv7511);
> +	cancel_work_sync(&adv7511->hpd_work);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does the driver have an
unsynchronized concurrency issue between HPD work and bridge detection?

adv7511_hpd_work() runs asynchronously and modifies state:

	if (status =3D=3D connector_status_connected &&
	    adv7511->status =3D=3D connector_status_disconnected &&
	    adv7511->powered) {
		regcache_mark_dirty(adv7511->regmap);
		adv7511_power_on(adv7511);
	}

	if (adv7511->status !=3D status) {
		adv7511->status =3D status;

At the same time, KMS can concurrently call adv7511_detect():

	if (status =3D=3D connector_status_connected && hpd && adv7511->powered) {
		regcache_mark_dirty(adv7511->regmap);
		adv7511_power_on(adv7511);
		if (adv7511->status =3D=3D connector_status_connected)
			status =3D connector_status_disconnected;
	}

Since neither function holds a lock while reading and modifying
adv7511->status and adv7511->powered, could both evaluate the state as
requiring a power cycle?

This might cause both to concurrently invoke adv7511_power_on(),
resulting in non-atomic, interleaved I2C register writes and overlapping
regcache_sync operations.

>  	of_node_put(adv7511->host_node);
> =20
>  	adv7511_uninit_regulators(adv7511);
> =20
>  	drm_bridge_remove(&adv7511->bridge);

[Severity: High]
This is a pre-existing issue, but does removing regulators before the
bridge is unregistered allow concurrent I2C access to powered-down
hardware?

In adv7511_remove(), adv7511_uninit_regulators() cuts power to the chip.

If a concurrent modeset, hotplug polling thread, or sysfs EDID read
invokes bridge operations (like adv7511_detect() or adv7511_edid_read())
before drm_bridge_remove() executes, could the driver attempt I2C
transactions on an unresponsive chip?

This could potentially cause hardware crashes, I2C bus timeouts, or
driver lockups.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728135205.859-=
1-getshell@seu.edu.cn?part=3D1
