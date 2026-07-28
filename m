Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B1EC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE5110E591;
	Tue, 28 Jul 2026 13:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jhLAtdF/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED3810E591
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:11:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 970F260A77;
 Tue, 28 Jul 2026 13:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8F41F000E9;
 Tue, 28 Jul 2026 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785244262;
 bh=/DHybVfKQhGUih2P0VJfkof6KAVUHkjdB/Zz4kKvXEU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jhLAtdF/wTdyGtpxIYxV5yDSRSHf+BX05zIQ7fTsSqRQMQbgykBoYPJIr94swTukP
 MMjtaGcdeRB1glxEzCXznEFjO6u73wynF9Gex1BC5J4BdZoete4muEMoTATXJ2LYkT
 qcWvJeEnNAlYLEwxiQl6ARGE6D1fRS+K1dkA9LlQnmMo/1dFkG1zhEgE7UVcmrZE3+
 Ntuf0OBfPlU91oppCDRmcyzbBIGtmGKG//H5fWscTaHPpN+ex/TGAxuOc3nQmwct1H
 eKTOWIzVXOho/xMVDvndd6Cl/3DIv7rC6n1pZlZL1tIPCD60D0r4ZvzKCyf1op0o5t
 uatUKHO0/dK/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] drm: bridge: cdns-mhdp8546: Add no-hpd property
To: "Yashas D" <y-d@ti.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728125336.776116-3-y-d@ti.com>
References: <20260728125336.776116-1-y-d@ti.com>
 <20260728125336.776116-3-y-d@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 13:11:01 +0000
Message-Id: <20260728131102.2C8F41F000E9@smtp.kernel.org>
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
- [High] Reading `DP_LANE0_1_STATUS` (0x202) for connection polling violate=
s DRM guidelines and disrupts link training state machines.
- [High] The `.detect()` callback unconditionally triggers hardware stream =
re-enablement during periodic polling in `no-hpd` mode.
- [High] Resource leak of `drm_dp_aux` if firmware loading times out during=
 `cdns_mhdp_attach()`, leading to a Use-After-Free.
- [Medium] Hardcoded 100ms timeout for asynchronous firmware loading in `cd=
ns_mhdp_attach()` can spuriously fail bridge attachment.
- [Medium] Changing DPCD read failures to `dev_err()` will flood the kernel=
 log with false-positive errors during normal operations.
--

--- Patch [2]: [PATCH v5 2/2] drm: bridge: cdns-mhdp8546: Add no-hpd proper=
ty ---
commit d6385d712222c0d749e282f8179c659c2e87c45d
Author: Rahul T R <r-ravikumar@ti.com>
Subject: drm: bridge: cdns-mhdp8546: Add no-hpd property

This commit adds a 'no-hpd' property to support boards where the HPD line
cannot be used for hotplug detection due to hardware limitations. When set,
the driver uses auxiliary channel (AUX) DPCD reads to detect monitor presen=
ce
by polling the connection status via the .detect() callback.

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
[ ... ]
> @@ -788,9 +792,14 @@ static ssize_t cdns_mhdp_transfer(struct drm_dp_aux =
*aux,
>  		ret =3D cdns_mhdp_dpcd_read(mhdp, msg->address,
>  					  msg->buffer, msg->size);
>  		if (ret) {
> -			dev_dbg(mhdp->dev,
> -				"Failed to read DPCD addr %u\n",
> -				msg->address);
> +			if (mhdp->no_hpd)
> +				dev_dbg(mhdp->dev,
> +					"Failed to read DPCD addr %u\n",
> +					msg->address);
> +			else
> +				dev_err(mhdp->dev,
> +					"Failed to read DPCD addr %u\n",
> +					msg->address);

[Severity: Medium]
Will this change spam the kernel log with false-positive errors during norm=
al
operations?

DP AUX channel transactions routinely fail during normal operations, such as
when a disconnected monitor is probed, during DP sleep states, or when the
DRM DP helper retries transient link training failures. Emitting a dev_err()
on every AUX read failure might flood the kernel log on standard hardware.

[ ... ]
> @@ -1523,6 +1532,26 @@ static int cdns_mhdp_attach(struct drm_bridge *bri=
dge,
> =20
>  	spin_unlock(&mhdp->start_lock);
> =20
> +	if (mhdp->no_hpd) {
> +		/*
> +		 * In no-hpd mode there is no interrupt to signal firmware
> +		 * readiness. The firmware loads asynchronously after probe(),
> +		 * so we must wait here until the uCPU is running before
> +		 * attempting the first AUX channel poll for monitor presence.
> +		 */
> +		ret =3D wait_event_timeout(mhdp->fw_load_wq,
> +					 mhdp->hw_state =3D=3D MHDP_HW_READY,
> +					 msecs_to_jiffies(100));

[Severity: Medium]
Could this hardcoded 100ms timeout spuriously fail bridge attachment?

Firmware loading from a filesystem (via request_firmware_nowait) can easily
take hundreds of milliseconds or longer depending on storage performance and
system load. If the timeout expires prematurely, the driver aborts with
-ETIMEDOUT, which could permanently break the display pipeline for that boo=
t.

> +		if (ret =3D=3D 0) {
> +			dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n",
> +				__func__);
> +			return -ETIMEDOUT;

[Severity: High]
Does this direct return leak the drm_dp_aux resource?

If the firmware loading timeout expires, this returns -ETIMEDOUT directly
instead of jumping to the aux_unregister error handling label.

Since drm_dp_aux_register() sets up an I2C adapter and the DRM core does not
call .detach() if attach fails, bypassing drm_dp_aux_unregister() leaks the
I2C adapter. Because the memory backing the drm_dp_aux structure is
devm-managed, unloading the module frees the memory while the adapter is st=
ill
registered, which can cause a use-after-free when the I2C subsystem accesses
it.

> +		}
> +
> +		cdns_mhdp_update_link_status(mhdp);
> +		return 0;
> +	}
[ ... ]
> @@ -2100,7 +2132,16 @@ static int cdns_mhdp_update_link_status(struct cdn=
s_mhdp_device *mhdp)
> =20
>  	mutex_lock(&mhdp->link_mutex);
> =20
> -	mhdp->plugged =3D cdns_mhdp_detect_hpd(mhdp, &hpd_pulse);
> +	if (mhdp->no_hpd) {
> +		ret =3D drm_dp_dpcd_read_link_status(&mhdp->aux, status);

[Severity: High]
Does reading the link status here violate DRM subsystem guidelines and disr=
upt
link training state machines?

The DRM core polls .detect() every 10 seconds when no-hpd is set, which
calls cdns_mhdp_update_link_status(). This unconditionally calls
drm_dp_dpcd_read_link_status() which reads DP_LANE0_1_STATUS (0x202).

According to DRM guidelines, registers in the link training status range
(0x202-0x207) participate in the CR/EQ training state machine and are not
safe for arbitrary read access outside of a link training sequence. Reading
this register continuously for presence detection can induce hardware
instability, screen flickering, and link drops. Should a safe register like
DP_DPCD_REV (0x000) be used instead?

> +		hpd_pulse =3D false;

[Severity: High]
Does hardcoding hpd_pulse to false cause the active display stream to be
re-initialized on every 10-second poll?

In no-hpd mode, .detect() is polled every 10 seconds. Because hpd_pulse is
hardcoded to false here, the later logic bypasses the check that validates
link status without state mutation:

    if (hpd_pulse && old_plugged =3D=3D mhdp->plugged) {
        ret =3D drm_dp_dpcd_read_link_status(&mhdp->aux, status);
        if (!ret && ...)
            goto out;
        ...
    }

Instead, execution falls through to the end of the function. If
mhdp->bridge_enabled is true, this causes cdns_mhdp_sst_enable() to be
called:

    if (mhdp->bridge_enabled) {
        ...
        cdns_mhdp_sst_enable(mhdp, current_mode);
    }

This repeatedly re-programs active stream and framer configuration registers
on every poll, which can cause the active video stream to reset and glitch
every 10 seconds.

> +		if (ret < 0)
> +			mhdp->plugged =3D false;
> +		else
> +			mhdp->plugged =3D true;
> +	} else {
> +		mhdp->plugged =3D cdns_mhdp_detect_hpd(mhdp, &hpd_pulse);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728125336.7761=
16-1-y-d@ti.com?part=3D2
