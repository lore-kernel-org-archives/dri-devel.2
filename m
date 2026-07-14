Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76845C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B207210E20F;
	Tue, 14 Jul 2026 11:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XNWU5hcd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D346A10E068
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 11:16:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EFD2E60120;
 Tue, 14 Jul 2026 11:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ED11F000E9;
 Tue, 14 Jul 2026 11:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784027799;
 bh=oSD4Ijah9FPQnpFsXPHGC+3xDrLWI131nmYNXRf2k30=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XNWU5hcdYIiy7MCgWaM27Nc/1xkAjjsTSBA8Rh85ON2QatM+IaYvPlhG4m5Dc7wEe
 hERuii3QOMm2HlWQkb1lHcxMZ4IqiFd+cEbaEWuQ2EVSex8IyRpstRCB6uxJLWiLfG
 wv8W2ZElsYFI+NqTgEmf/CtHf/qYcZjra0NRq+HbDE5r6o/5yZWOq5PKK/Pfni25aL
 DRBdRI9p/6Gwiq87jSmuNxAY4xcnR7o/8kdelYQred+ieCpMzBKKIjSDalzFGdUN5C
 lQlQFeze7g0DoRdc4JQ2QGMimdUA+M2ivJoMBmlewsg5fa/lZhcuUiOKYXwv3Y8WZ9
 6f/gy6CO8ikaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 2/2] drm/bridge: Add Lontium LT7911EXC eDP to MIPI
 DSI bridge
To: syyang@lontium.com
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260714105828.2763677-3-syyang@lontium.com>
References: <20260714105828.2763677-1-syyang@lontium.com>
 <20260714105828.2763677-3-syyang@lontium.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:16:38 +0000
Message-Id: <20260714111639.53ED11F000E9@smtp.kernel.org>
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
- [High] Dynamic devm allocation and bridge registration in DSI host attach=
/detach causes devres leaks and list corruption.
- [High] Asynchronous workqueue dereferences dangling `bridge.dev` if the D=
RM display controller unbinds.
- [Medium] Failure to clear `output_bridge` in `dsi_host_detach` prevents p=
anel re-attachment.
- [Low] Mutating `pre_enable_prev_first` of a downstream bridge object viol=
ates subsystem API layering.
- [Low] Unsynchronized reads of `lt7911exc->removed` in the asynchronous wo=
rkqueue.
--

--- Patch [2]: [PATCH v16 2/2] drm/bridge: Add Lontium LT7911EXC eDP to MIP=
I DSI bridge ---
commit f0896e2dbabe50d3cbe793868df9c6d4afd6db5f
Author: Sunyun Yang <syyang@lontium.com>

drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI bridge

This commit adds support for the Lontium LT7911EXC bridge chip, which=20
converts eDP input to MIPI DSI output. It implements firmware upgrades,=20
GPIO reset handling, and DSI host interface attachment.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/drm=
/bridge/lontium-lt7911exc.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c

[ ... ]

> @@ -344,14 +344,14 @@ static void lt7911exc_firmware_upgrade_work(struct =
work_struct *work)
> +{
> +	struct lt7911exc *lt7911exc =3D container_of(work, struct lt7911exc, wo=
rk);
> +	struct device *dev =3D lt7911exc->dev;
> +	const struct firmware *fw;
> +	u8 *buffer;
> +	size_t total_size =3D FW_SIZE - 4;
> +	u32 crc32, version;
> +	int ret;
> +
> +	mutex_lock(&lt7911exc->upgrade_lock);
> +	if (lt7911exc->removed)

[Severity: Low]
Should this read of the removed flag be protected by the ocm_lock? It
appears this can be evaluated concurrently with driver removal since the
lock isn't held here.

> +		goto out_unlock_upgrade;
> +

[ ... ]

> +out_unlock_upgrade:
> +	scoped_guard(mutex, &lt7911exc->ocm_lock) {
> +		if (!lt7911exc->removed)
> +			lt7911exc->upgrade =3D false;
> +	}
> +
> +	/* Notify DRM to re-trigger modeset after firmware upgrade */
> +	if (!lt7911exc->removed && lt7911exc->bridge.dev)
> +		drm_kms_helper_hotplug_event(lt7911exc->bridge.dev);

[Severity: High]
Could this dereference a freed drm_device if the upstream DRM display
controller unbinds before the firmware upgrade completes?

The I2C device has a lifecycle independent of the DRM display controller.
If the upstream DRM driver is unloaded, the drm_device is destroyed, but
the I2C device remains, leaving bridge.dev populated but dangling.

If a sysfs write triggers this asynchronous workqueue in that window,
it looks like it will pass a freed pointer to drm_kms_helper_hotplug_event(=
).

> +
> +	mutex_unlock(&lt7911exc->upgrade_lock);
> +}

[ ... ]

> +static int lt7911exc_dsi_host_attach(struct mipi_dsi_host *host, struct =
mipi_dsi_device *dev)
> +{
> +	struct lt7911exc *lt7911exc =3D dsi_host_to_lt7911exc(host);
> +	struct drm_bridge *bridge;
> +
> +	/* currently do not support connecting several DSI devices to the same =
host */
> +	if (lt7911exc->output_bridge)
> +		return -EBUSY;
> +
> +	if (dev->lanes > 4) {
> +		dev_err(lt7911exc->dev, "unsupported number of data lanes(%u)\n", dev-=
>lanes);
> +		return -EINVAL;
> +	}
> +
> +	bridge =3D devm_drm_of_get_bridge(lt7911exc->dev, host->dev->of_node, 1=
, 0);

[Severity: High]
Is it safe to dynamically allocate devm memory during panel attach?

If the downstream panel driver is repeatedly unbound and rebound by a
local administrator, this will repeatedly allocate devres memory without
freeing it, causing a memory leak.

> +	if (IS_ERR(bridge)) {
> +		dev_err(lt7911exc->dev, "failed to add DSI device\n");
> +		return PTR_ERR(bridge);
> +	}
> +
> +	lt7911exc->output_bridge =3D bridge;
> +
> +	/*
> +	 * Force panel-first enable order: the DSI output stream (0xe0b0)
> +	 * must not be enabled before the panel is powered on.
> +	 * This override is safe because LT7911EXC's transfer() is a stub =E2=
=80=94
> +	 * panel DCS commands are silently discarded and panel init is done
> +	 * by the chip's internal firmware. The panel driver's
> +	 * prepare_prev_first preference is therefore irrelevant here.
> +	 */
> +	lt7911exc->output_bridge->pre_enable_prev_first =3D false;

[Severity: Low]
Is it acceptable to modify the state of a downstream bridge object
that is owned and managed by another driver? Doing so bypasses the
subsystem API layering.

> +
> +	drm_bridge_add(&lt7911exc->bridge);

[Severity: High]
Does this corrupt the global bridge list if the panel driver is rebound?

When the downstream panel unbinds, lt7911exc_dsi_host_detach() calls
drm_bridge_remove(), which moves the bridge to the bridge_lingering_list
and destroys its mutexes.

If the panel binds again, this drm_bridge_add() will be called on the same
bridge structure, invoking list_add_tail() on a node that is already tracked
in the lingering list.

> +
> +	return 0;
> +}
> +
> +static int lt7911exc_dsi_host_detach(struct mipi_dsi_host *host, struct =
mipi_dsi_device *dev)
> +{
> +	struct lt7911exc *lt7911exc =3D dsi_host_to_lt7911exc(host);
> +
> +	drm_bridge_remove(&lt7911exc->bridge);

[Severity: Medium]
Does this prevent the panel from re-attaching later?

The detach function does not set lt7911exc->output_bridge back to NULL.
If the downstream panel driver tries to attach again,
lt7911exc_dsi_host_attach() will check if output_bridge is set and return
-EBUSY, leaving the display pipeline permanently broken until the bridge
driver is reloaded.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714105828.2763=
677-1-syyang@lontium.com?part=3D2
