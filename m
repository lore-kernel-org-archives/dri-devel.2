Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2C6C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 02:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90CD510EE84;
	Wed, 15 Jul 2026 02:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bI2Hpp+X";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4112C10EE84
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 02:06:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2DBC443C58;
 Wed, 15 Jul 2026 02:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73771F000E9;
 Wed, 15 Jul 2026 02:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784081177;
 bh=jjc6v2Q+/8RgtuO09Lly8InjigX8L2V4kQGIE75cYxo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bI2Hpp+XflD95TMZnDsgLgjLZHrzPDP1x0zXtnu1kj546Sss4jI9+pECzd8OlJU4e
 +mJRjnFMo10WAGjh8svzy/6Bm/Z3r4EUZ5oOrk6bt5/Z1rtvA2M1B3KwejtVC5i4kZ
 I5EEyqsBEtwrzb34KdNmdnXEPzukeo0WNKxl7CbsiIyjKz1NGZ8I0Ol9h/caa7Tss4
 XhS59ou73WsluFtxzbe6FJbgtsx7Bz6vX+XEnpRRUWonCkK77xcUe1Dy3fSu/ksYYH
 srSwXlb6PR0vKBBn0z8PSn534Pm1BOFhCUQNyVQRFgXeq+Fmtp1g0VVpPtaO/9fyqC
 OV57C+27XQRug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 2/2] drm/bridge: Add Lontium LT7911EXC eDP to MIPI
 DSI bridge
To: syyang@lontium.com
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260715015438.2770155-3-syyang@lontium.com>
References: <20260715015438.2770155-1-syyang@lontium.com>
 <20260715015438.2770155-3-syyang@lontium.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 02:06:16 +0000
Message-Id: <20260715020616.B73771F000E9@smtp.kernel.org>
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
- [High] Missing cleanup of `output_bridge` in `mipi_dsi_host_detach` preve=
nts DSI device rebinds and causes use-after-free.
- [High] Sysfs attribute `lt7911exc_firmware` is accessible before the driv=
er has finished initialization in `probe`, leading to a kernel panic.
- [High] Asynchronous firmware upgrade worker accesses `bridge.dev` without=
 holding a reference, causing a Use-After-Free if the DRM display controlle=
r unbinds.
- [Medium] Driver illegitimately mutates the state of a downstream bridge o=
bject by explicitly modifying `pre_enable_prev_first`.
- [Low] The `lt7911exc->removed` flag is read without a lock or memory barr=
ier in the firmware upgrade work, leading to a data race.
--

--- Patch [2]: [PATCH v17 2/2] drm/bridge: Add Lontium LT7911EXC eDP to MIP=
I DSI bridge ---
commit f9cec7dee2928b841f4104ddf68c1ebfeffba41a
Author: Sunyun Yang <syyang@lontium.com>

drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI bridge

Add support for the Lontium LT7911EXC bridge chip, which converts
eDP input to MIPI DSI output using an internal firmware-controlled
pipeline.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/drm=
/bridge/lontium-lt7911exc.c
> new file mode 100644
> index 0000000000000..5b7a184e96194
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c

[ ... ]

> @@ -458,6 +458,25 @@ static void lt7911exc_firmware_upgrade_work(struct w=
ork_struct *work)
>  out_mcu_run:
>  	scoped_guard(mutex, &lt7911exc->ocm_lock)
>  		lt7911exc_inside_mcu_run(lt7911exc);
> =20
>  out_release_fw:
>  	release_firmware(fw);
> =20
>  out_unlock_upgrade:
>  	scoped_guard(mutex, &lt7911exc->ocm_lock) {
>  		if (!lt7911exc->removed)
>  			lt7911exc->upgrade =3D false;
>  	}
> =20
>  	/* Notify DRM to re-trigger modeset after firmware upgrade */
>  	if (!lt7911exc->removed && lt7911exc->bridge.dev)

[Severity: Low]
Is there a data race on the removed flag here?

The lt7911exc->removed flag is set under ocm_lock in lt7911exc_remove(), but
it is read here outside of any lock or memory barrier.

While cancel_work_sync() in the remove path prevents a logical use-after-fr=
ee,
could this still trigger unmarked data race warnings from KCSAN?

[Severity: High]
Can this code trigger a use-after-free if the DRM display controller unbind=
s?

The firmware upgrade work accesses bridge.dev asynchronously. The bridge.dev
pointer is assigned when the DRM master attaches, but the I2C bridge driver
holds no reference to it.

If a user starts a firmware upgrade via sysfs and then unbinds the DRM
master driver before the async work completes, the drm_device is freed.

Does this leave a dangling pointer that the worker will then dereference in
drm_kms_helper_hotplug_event()?

>  		drm_kms_helper_hotplug_event(lt7911exc->bridge.dev);
> =20
>  	mutex_unlock(&lt7911exc->upgrade_lock);
>  }

[ ... ]

> @@ -515,10 +515,31 @@ static int lt7911exc_dsi_host_attach(struct mipi_ds=
i_host *host, struct mipi_dsi_device *dev)
>  	lt7911exc->output_bridge =3D bridge;
> =20
>  	/*
>  	 * Force panel-first enable order: the DSI output stream (0xe0b0)
>  	 * must not be enabled before the panel is powered on.
>  	 * This override is safe because LT7911EXC's transfer() is a stub =E2=
=80=94
>  	 * panel DCS commands are silently discarded and panel init is done
>  	 * by the chip's internal firmware. The panel driver's
>  	 * prepare_prev_first preference is therefore irrelevant here.
>  	 */
>  	lt7911exc->output_bridge->pre_enable_prev_first =3D false;

[Severity: Medium]
Is it safe to explicitly mutate the state of a downstream bridge object?

The downstream bridge object belongs to the panel driver. Overriding its
pre_enable_prev_first flag violates object ownership and could disrupt the
panel's expected power-on sequence.

Could this cause the panel to fail to power on correctly?

> =20
>  	drm_bridge_add(&lt7911exc->bridge);
> =20
>  	return 0;
>  }
> =20
>  static int lt7911exc_dsi_host_detach(struct mipi_dsi_host *host, struct =
mipi_dsi_device *dev)
>  {
>  	struct lt7911exc *lt7911exc =3D dsi_host_to_lt7911exc(host);
> =20
>  	drm_bridge_remove(&lt7911exc->bridge);
> =20
>  	return 0;
>  }

[Severity: High]
Does this missing cleanup prevent DSI device rebinds and cause a
use-after-free?

In lt7911exc_dsi_host_attach(), output_bridge is initialized, but it is nev=
er
cleared back to NULL in this detach function.

If the downstream DSI panel is unbound via sysfs, the old wrapper remains,
pointing to a freed panel.

If the panel is subsequently rebound, the check for output_bridge in
lt7911exc_dsi_host_attach() will falsely trigger and return -EBUSY,
permanently breaking the display pipeline. Should output_bridge be set to
NULL here?

[ ... ]

> @@ -662,11 +662,20 @@ static int lt7911exc_probe(struct i2c_client *clien=
t)
>  	lt7911exc =3D devm_drm_bridge_alloc(dev, struct lt7911exc, bridge, &lt7=
911exc_bridge_funcs);
>  	if (IS_ERR(lt7911exc))
>  		return dev_err_probe(dev, PTR_ERR(lt7911exc), "drm bridge alloc failed=
.\n");
> =20
>  	dev_set_drvdata(dev, lt7911exc);
> =20
>  	lt7911exc->dev =3D dev;
>  	lt7911exc->upgrade =3D false;
>  	lt7911exc->removed =3D false;
> =20
>  	ret =3D devm_mutex_init(dev, &lt7911exc->ocm_lock);

[Severity: High]
Could a concurrent sysfs write during probe trigger a kernel panic?

Because lt7911exc_attr_groups is attached via driver.dev_groups, the driver
core creates the sysfs files before probe() runs.

Here, dev_set_drvdata() exposes the struct before ocm_lock, upgrade_lock,
and the work struct are initialized.

If a user writes to the sysfs file during this window,
lt7911exc_firmware_store() will retrieve the partially initialized struct a=
nd
attempt to lock the uninitialized mutex. Should the drvdata be set after
initialization is complete?

>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to init mutex\n");
> =20
>  	ret =3D devm_mutex_init(dev, &lt7911exc->upgrade_lock);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715015438.2770=
155-1-syyang@lontium.com?part=3D2
