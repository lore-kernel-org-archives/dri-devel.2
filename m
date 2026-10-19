Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0D606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJ8rSOGx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC0910EB68;
	Mon, 19 Oct 2026 21:59:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9011410EB68
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:59:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 052F1601F6;
 Mon, 19 Oct 2026 21:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9241F000C4;
 Mon, 19 Oct 2026 21:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792447178;
 bh=OLkrsWxYqgNI37+jBJXGMBTZZziPvnO5UX0EdVLBHFE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PJ8rSOGx7Qe8kqcoZ0yihaYd1zjZCQmg4pOxlzyqwtWfIhzF+aSfp1Sa+v1/GFlnO
 NUWs706v2YOzX09GA8JDR6ylaVgFBAGm3xb+U1G2egtgUaR05XEQSohJz0+nTbtHgx
 G3W6j27E2E3V9cX98wsr0XMWLNRToLdbo85HdogcjgK/CSR39EKDC/rb3yQg5tExeH
 sfH+MqaN+Xj9fIynmvHCAkzp/icfZK049djnM/JDlMRMNu4G0pPdURhdSoe7fwZcmD
 XxG2RoHWgAXOVIg3XV+xN+jozpFOp7WSoLnogvRamfJ8q79ByB/H+9N9C5xAI+n6TO
 A3obMUdVyCSTQ==
Message-ID: <sashiko-outbox-178286@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/14] arm64: dts: ti: [DO_NOT_MERGE] Add AM62L3 EVM
 overlay for GDEY042T81 e-paper display
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261019213726.4145532-15-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
 <20261019213726.4145532-15-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:59:38 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] drm/solomon: ssd16xx: broken RAM window in ssd16xx_clear_display=
() at 90/180 deg
- [Medium] drm/solomon: ssd16xx: missing fast refresh LUT preload on init a=
nd resume
- [Medium] drm/solomon: ssd16xx: broken deep_sleep_mode state and error rol=
lback in ssd16xx_pm_suspend()
- [Medium] drm/solomon: ssd16xx: missing RED RAM baseline restore after mod=
e 0x03 sleep
--

commit a52cd0ebb1dc317dd86b82ae1b73fbcb5d5fa3b6
Author: Devarsh Thakkar <devarsht@ti.com>

arm64: dts: ti: [DO_NOT_MERGE] Add AM62L3 EVM overlay for GDEY042T81 e-pape=
r display

This series adds a DRM driver for the Solomon SSD16xx family of e-paper
display controllers (including SSD1683 and SSD1677) with runtime and system
power management, session management, and plane properties, along with the
AM62L3 EVM device tree overlay for the GDEY042T81 panel.

> diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/=
ssd16xx.c
> new file mode 100644
> index 0000000000000..29dca237378f8
> --- /dev/null
> +++ b/drivers/gpu/drm/solomon/ssd16xx.c

[ ... ]

> +	[SSD1677] =3D {
> +		/*
> +		 * 10-bit pixel-level X/Y addressing; only deep sleep mode
> +		 * 0x03 is supported (no RAM-retain mode).  Border waveform
> +		 * encoding matches SSD1683.
> +		 */
> +		.max_width  =3D 960,
> +		.max_height =3D 680,
> +		.ram_x_address_bits =3D 10,
> +		.ram_y_address_bits =3D 10,
> +		.has_temp_sensor_ctrl    =3D true,
> +		.deep_sleep_mode_level1  =3D SSD1683_DEEP_SLEEP_MODE_2,  /* 0x03 */
> +		.deep_sleep_mode_level2  =3D SSD1683_DEEP_SLEEP_MODE_2,  /* 0x03 */

[ ... ]

> +	switch (device->orientation) {
> +	case 90:
> +	case 180:
> +		data_entry_mode =3D SSD16XX_DATA_ENTRY_XDEC_YDEC;
> +		break;
> +	default: /* 0=C2=B0/270=C2=B0 */
> +		data_entry_mode =3D SSD16XX_DATA_ENTRY_XINC_YINC;
> +		break;
> +	}
> +
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_DATA_ENTRY_MODE, &err);
> +	ssd16xx_send_data(device, data_entry_mode, &err);
> +	drm_dbg(&device->drm, "hw_init: orientation=3D%u=C2=B0 data_entry=3D0x%=
02x\n",
> +		device->orientation, data_entry_mode);
> +
> +	ssd16xx_wait_for_device(device, &err);
> +
> +	if (err)
> +		drm_err(&device->drm, "Hardware initialization failed: %d\n", err);
> +
> +	return err;
> +}
> +
> +/*
> + * Clear display by writing all-white to both BW and RED RAM.
> + * The ctrl2 argument selects the waveform (full/partial/fast refresh).
> + * Border waveform is set to init value before clearing, then restored
> + * to the update value to preserve the border during subsequent updates.
> + */
> +static int ssd16xx_clear_display(struct ssd16xx_device *device, u8 ctrl2)
> +{
> +	const u8 *bw_tbl =3D device->controller_cfg->border_waveform_table;
> +	int err =3D 0;
> +	unsigned int data_size =3D DIV_ROUND_UP(device->width, 8) * device->hei=
ght;
> +	u8 *white_buffer =3D device->tx_buf;
> +	u8 *red_buffer =3D white_buffer;
> +	u16 ram_x_end, ram_y_end;
> +
> +	memset(white_buffer, 0xFF, data_size);
> +
> +	if (device->controller_cfg->ram_x_address_bits =3D=3D 8)
> +		ram_x_end =3D (device->width / 8) - 1;
> +	else
> +		ram_x_end =3D device->width - 1;
> +	ram_y_end =3D device->height - 1;
> +
> +	/* Reset full display RAM window before clearing */
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_START_END, &err);
> +	ssd16xx_send_x_param(device, 0x00, &err);
> +	ssd16xx_send_x_param(device, ram_x_end, &err);
> +
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_Y_ADDRESS_START_END, &err);
> +	ssd16xx_send_y_param(device, 0x00, &err);
> +	ssd16xx_send_y_param(device, ram_y_end, &err);
> +
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER, &err);
> +	ssd16xx_send_x_param(device, 0x00, &err);
> +
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER, &err);
> +	ssd16xx_send_y_param(device, 0x00, &err);

[Severity: Medium]
When device->orientation is 90 or 180, ssd16xx_hw_init() sets
SSD16XX_CMD_DATA_ENTRY_MODE to SSD16XX_DATA_ENTRY_XDEC_YDEC, where the
controller decrements X and Y on every byte written.

In ssd16xx_fb_dirty(), 90 and 180 degree orientations program the RAM window
with end-before-start (ram_x_end to ram_x_start, ram_y_end to ram_y_start)
and place the initial address counters at (ram_x_end, ram_y_end).

Here in ssd16xx_clear_display(), the window is unconditionally programmed
from 0x00 to ram_x_end and 0x00 to ram_y_end with the counters starting at
(0x00, 0x00). When invoked via ssd16xx_clear_display_on_init(),
ssd16xx_clear_display_on_exit(), or ssd16xx_crtc_atomic_disable() on a panel
rotated 90 or 180 degrees, won't this fail to clear the display RAM and
leave RED RAM out of sync for subsequent partial updates?

[ ... ]

> +	/* Resume lets the runtime_resume callback re-run hw_init if needed. */
> +	ret =3D pm_runtime_resume_and_get(device->drm.dev);
> +	if (ret < 0) {
> +		drm_err(&device->drm, "plane_atomic_update: failed to resume: %d\n", r=
et);
> +		goto out_exit;
> +	}
> +
> +	if (!device->initialized) {
> +		drm_err(&device->drm, "plane_atomic_update: hw not initialized after r=
esume\n");
> +		pm_runtime_put_autosuspend(device->drm.dev);
> +		goto out_exit;
> +	}
> +
> +	drm_dbg(&device->drm, "plane_atomic_update: calling fb_dirty rect=3D(%d=
,%d)-(%d,%d)\n",
> +		rect.x1, rect.y1, rect.x2, rect.y2);
> +
> +	mutex_lock(&device->lock);
> +
> +	/* Diff refresh_mode against the plane's own previous state to see
> +	 * whether fast LUT preload is needed.
> +	 */
> +	if (old_ssd->refresh_mode !=3D new_ssd->refresh_mode) {
> +		/*
> +		 * Fast refresh omits LOAD_LUT each update; arm the
> +		 * one-shot flag so LUT is pre-loaded before the first
> +		 * fast frame.
> +		 */
> +		if (new_ssd->refresh_mode =3D=3D SSD16XX_REFRESH_FAST &&
> +		    old_ssd->refresh_mode !=3D SSD16XX_REFRESH_FULL)
> +			device->fast_lut_pending =3D true;
> +		else
> +			device->fast_lut_pending =3D false;
> +	}
> +
> +	ssd16xx_sync_session_props(device, new_ssd);
> +
> +	/*
> +	 * When refresh_mode_init was set, use the specified mode for this first
> +	 * frame only, then restore the user-configured refresh_mode so
> +	 * subsequent updates continue with the configured mode.
> +	 */
> +	saved_mode =3D device->refresh_mode;
> +	saved_border_waveform_idx =3D device->border_waveform_update_idx;
> +	if (device->init_refresh_pending) {
> +		device->refresh_mode =3D device->refresh_mode_init;
> +		device->border_waveform_update_idx =3D device->border_waveform_init_id=
x;
> +	}
> +
> +	/*
> +	 * Fast refresh (0xC7) omits LOAD_LUT on every update cycle and relies
> +	 * on the LUT being pre-loaded upfront.  The property setter arms
> +	 * fast_lut_pending whenever the user switches into fast mode.  Consume
> +	 * the flag here (once) before the first fast-refresh frame so the
> +	 * controller's LUT is in the correct state.
> +	 */
> +	if (device->fast_lut_pending) {
> +		ret =3D ssd16xx_preload_fast_lut(device);
> +		if (ret) {
> +			drm_err(&device->drm,
> +				"plane_atomic_update: fast LUT preload failed: %d\n", ret);
> +		}
> +
> +		device->fast_lut_pending =3D false;
> +	}

[Severity: Medium]
Can SSD16XX_REFRESH_FAST run without pre-loading the LUT in a few paths
here and in ssd16xx_crtc_atomic_enable()?

First, in ssd16xx_plane_atomic_update(), pm_runtime_resume_and_get() runs
ssd16xx_pm_runtime_resume() -> ssd16xx_hw_init() before
ssd16xx_sync_session_props() updates device->refresh_mode. If the device
resumes from runtime suspend when old_ssd->refresh_mode was
SSD16XX_REFRESH_FULL and new_ssd->refresh_mode is SSD16XX_REFRESH_FAST,
ssd16xx_hw_init() resets the controller (wiping the LUT) and sees the stale
FULL mode, while the check above also skips setting device->fast_lut_pending
because old_ssd->refresh_mode =3D=3D SSD16XX_REFRESH_FULL.

Second, in ssd16xx_crtc_atomic_enable(), both pm_runtime_resume_and_get()
and ssd16xx_hw_init() run before ssd16xx_sync_session_props(), so
ssd16xx_hw_init() checks the stale device->refresh_mode rather than the new
plane state's mode (and ssd16xx_clear_display_on_init() can also run
SSD16XX_REFRESH_FAST without a pre-loaded LUT).

Third, when device->init_refresh_pending is true, device->refresh_mode is
overridden with device->refresh_mode_init after device->fast_lut_pending is
computed from old_ssd and new_ssd. If refresh_mode_init is
SSD16XX_REFRESH_FAST while new_ssd->refresh_mode is SSD16XX_REFRESH_PARTIAL,
fast_lut_pending is not armed for the init frame. Conversely, if
new_ssd->refresh_mode switches from PARTIAL to FAST while refresh_mode_init
is PARTIAL, fast_lut_pending is consumed before the PARTIAL init frame
(which loads the Mode 2 partial LUT), leaving subsequent FAST frames without
a Mode 1 LUT preload.

[ ... ]

> +static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
> +					struct drm_atomic_commit *state)
> +{
> +	struct ssd16xx_device *device =3D crtc_to_ssd16xx_device(crtc);
> +	int ret, idx;
> +
> +	if (!drm_dev_enter(&device->drm, &idx))
> +		return;
> +
> +	mutex_lock(&device->lock);
> +
> +	if (device->clear_on_disable < 0 || device->cleared_on_disable)
> +		goto out;
> +
> +	ret =3D pm_runtime_resume_and_get(device->drm.dev);
> +	if (ret < 0)
> +		goto out;
> +
> +	drm_dbg(&device->drm, "clear_on_disable: running, mode=3D%d\n",
> +		device->clear_on_disable);
> +	ret =3D ssd16xx_clear_display(device,
> +				    ssd16xx_refresh_mode_to_ctrl2(device,
> +								  device->clear_on_disable));
> +	if (ret) {
> +		drm_err(&device->drm, "atomic_disable: clear failed: %d\n", ret);
> +		pm_runtime_put_autosuspend(device->drm.dev);
> +		goto out;
> +	}
> +
> +	device->cleared_on_disable =3D true;
> +	pm_runtime_put_sync_suspend(device->drm.dev);
> +out:
> +	mutex_unlock(&device->lock);
> +	drm_dev_exit(idx);
> +}

[ ... ]

> +static int ssd16xx_pm_suspend(struct device *dev)
> +{
> +	struct ssd16xx_device *device =3D dev_get_drvdata(dev);
> +	struct drm_device *drm =3D &device->drm;
> +	int ret;
> +
> +	/* Use level2 deep sleep for system suspend; SSD1683 loses RAM but save=
s more power. */
> +	device->deep_sleep_mode =3D device->controller_cfg->deep_sleep_mode_lev=
el2;
> +	dev_dbg(dev, "system suspend: entering deep sleep mode 0x%02x\n",
> +		device->deep_sleep_mode);
> +
> +	ret =3D drm_mode_config_helper_suspend(drm);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If the autosuspend timer already fired the device is RPM_SUSPENDED
> +	 * at level1.  pm_runtime_force_suspend() would skip its callback, so
> +	 * level2 would never reach the hardware.
> +	 *
> +	 * SPI is unresponsive in deep sleep; HWRESET is the only exit.
> +	 * After the reset, level2 can be sent directly without a full hw_init.
> +	 *
> +	 * Skip this for controllers where level1 =3D=3D level2 (e.g. SSD1677 w=
hich
> +	 * has only one deep sleep mode): the device is already in the deepest
> +	 * available state and no upgrade is needed.
> +	 */
> +	if (pm_runtime_status_suspended(dev)) {
> +		int err =3D 0;
> +
> +		if (device->controller_cfg->deep_sleep_mode_level1 !=3D
> +		    device->controller_cfg->deep_sleep_mode_level2) {
> +			dev_dbg(dev, "system suspend: upgrading level1->level2 via HWRESET\n"=
);
> +			ssd16xx_hw_reset(device);
> +			ssd16xx_wait_for_device(device, &err);
> +			ssd16xx_send_cmd(device, SSD16XX_CMD_DEEP_SLEEP_MODE, &err);
> +			ssd16xx_send_data(device,
> +					  device->controller_cfg->deep_sleep_mode_level2,
> +					  &err);
> +		} else {
> +			dev_dbg(dev, "system suspend: already at deepest sleep mode\n");
> +		}
> +		device->initialized =3D false;
> +		device->pm_force_suspended =3D false;  /* Skip force_resume on resume =
*/
> +		return err;
> +	}
> +
> +	/* Force runtime-suspended state for clean resume. */
> +	ret =3D pm_runtime_force_suspend(dev);
> +	if (ret) {
> +		drm_mode_config_helper_resume(drm);
> +		return ret;
> +	}
> +	device->pm_force_suspended =3D true;  /* Resume must call force_resume =
*/
> +
> +	return 0;
> +}

[Severity: Medium]
In ssd16xx_pm_suspend(), device->deep_sleep_mode is updated to
deep_sleep_mode_level2 before calling drm_mode_config_helper_suspend(drm).
Could this cause three issues during system suspend?

1. When clear_on_disable >=3D 0, drm_mode_config_helper_suspend(drm) calls
ssd16xx_crtc_atomic_disable(), which clears the display and invokes
pm_runtime_put_sync_suspend(). Because device->deep_sleep_mode was already
set to level2, ssd16xx_pm_runtime_suspend() puts the panel into level2 sleep
and marks the device RPM_SUSPENDED. When control returns to
ssd16xx_pm_suspend(), pm_runtime_status_suspended(dev) is true, so it
assumes the panel was in level1 sleep and performs a second hardware reset
and level2 sleep command while skipping pm_runtime_force_suspend(dev).

2. If drm_mode_config_helper_suspend(drm) or pm_runtime_force_suspend(dev)
returns an error, ssd16xx_pm_suspend() exits without restoring
device->deep_sleep_mode to deep_sleep_mode_level1, leaving subsequent
runtime PM autosuspends using level2 sleep (0x03) and wiping controller RAM.

3. In the pm_runtime_status_suspended(dev) branch, if
ssd16xx_wait_for_device(), ssd16xx_send_cmd(), or ssd16xx_send_data() fails,
ssd16xx_pm_suspend() returns err without calling
drm_mode_config_helper_resume(drm) or restoring device->deep_sleep_mode,
leaving the DRM mode config suspended and leaking
drm->mode_config.suspend_state.

> +static int ssd16xx_pm_resume(struct device *dev)
> +{
> +	struct ssd16xx_device *device =3D dev_get_drvdata(dev);
> +	struct drm_device *drm =3D &device->drm;
> +
> +	dev_dbg(dev, "system resume: restoring state\n");
> +
> +	/* Only force_resume if we force_suspended; the level1=E2=86=92level2 u=
pgrade path did not. */
> +	if (device->pm_force_suspended) {
> +		pm_runtime_force_resume(dev);
> +		device->pm_force_suspended =3D false;
> +	}
> +
> +	/* Restore level1 for subsequent runtime PM cycles. */
> +	device->deep_sleep_mode =3D device->controller_cfg->deep_sleep_mode_lev=
el1;
> +
> +	return drm_mode_config_helper_resume(drm);
> +}
> +
> +static int ssd16xx_pm_runtime_suspend(struct device *dev)
> +{
> +	struct ssd16xx_device *device =3D dev_get_drvdata(dev);
> +	int err =3D 0;
> +
> +	dev_dbg(dev, "runtime suspend: entering deep sleep mode 0x%02x\n",
> +		device->deep_sleep_mode);
> +
> +	ssd16xx_send_cmd(device, SSD16XX_CMD_DEEP_SLEEP_MODE, &err);
> +	ssd16xx_send_data(device, device->deep_sleep_mode, &err);
> +	device->initialized =3D false;
> +
> +	/*
> +	 * Don't propagate SPI errors: a failure here would latch runtime_error
> +	 * and block all future resumes; the next resume resets the panel anywa=
y.
> +	 */
> +	if (err)
> +		dev_warn(dev, "failed to enter deep sleep: %d\n", err);
> +
> +	return 0;
> +}
> +
> +static int ssd16xx_pm_runtime_resume(struct device *dev)
> +{
> +	struct ssd16xx_device *device =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_dbg(dev, "runtime resume: initialized=3D%d%s\n",
> +		device->initialized,
> +		!device->initialized ? " (running hw_init)" : "");
> +
> +	/*
> +	 * pm_runtime_suspend clears initialized after sending the deep sleep
> +	 * command.  If a new app opens before the suspend fires (the put was
> +	 * cancelled), initialized is still true and hw_init is unnecessary.
> +	 */
> +	if (!device->initialized) {
> +		ret =3D ssd16xx_hw_init(device);
> +		if (ret)
> +			return ret;
> +
> +		device->initialized =3D true;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
When resuming from SSD1683_DEEP_SLEEP_MODE_2 (0x03), the controller loses
its RAM contents, including the RED RAM reference frame required by
SSD16XX_REFRESH_PARTIAL in ssd16xx_fb_dirty().

On SSD1677, deep_sleep_mode_level1 is SSD1683_DEEP_SLEEP_MODE_2 (0x03).
After runtime autosuspend fires while the CRTC remains enabled, the next
plane update calls ssd16xx_plane_atomic_update() ->
pm_runtime_resume_and_get() -> ssd16xx_pm_runtime_resume() ->
ssd16xx_hw_init() without running ssd16xx_crtc_atomic_enable(), so
init_refresh_pending remains false and ssd16xx_fb_dirty() performs a partial
refresh with ctrl1_normal against lost RED RAM.

Similarly, across system suspend and resume (which uses mode 0x03 on SSD1683
as well), if the userspace refresh_mode_init plane property is set to
disabled (-1) or partial (0) while refresh_mode is partial,
ssd16xx_pm_resume() -> drm_mode_config_helper_resume() ->
ssd16xx_crtc_atomic_enable() -> ssd16xx_plane_atomic_update() will also
execute a partial refresh with ctrl1_normal without re-establishing the RED
RAM baseline.

Should resuming from mode 0x03 sleep force a baseline full/fast refresh or
restore RED RAM before the next partial update?

[ ... ]

> --=20
> 2.34.1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019213726.4145=
532-1-devarsht@ti.com?part=3D14
