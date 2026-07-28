Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D174C531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 491A110E869;
	Tue, 28 Jul 2026 11:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vuiuvsoq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC7010E869
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:26:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58F1360AA1;
 Tue, 28 Jul 2026 11:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6721F000E9;
 Tue, 28 Jul 2026 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785237975;
 bh=NE3RngGDwIHYaum5JwnDCQdmMUwlN0PjlmvrHqW5IwA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vuiuvsoq8lkDEHGF4NJuRzZQAYjNKVCuD6B6Nl5MFQiRrnzQGuIb7MNVeo7fPpKDC
 WVeqLgXoHA2yZ2bLeGqdObbbuLNNbp7SACV+MvaQ8PAePWcXKOept3r6/j6kzpS7yq
 qN7rC3iThwnLKmJZo+Xtc7CTQnj8ebxM5OTj6riA97xORsvh0HMmg2UxytRvcxtZcm
 b0Ofczttl158FhpsXj8TyVQQd91OlKE4xpx4ZH0qOmTbdx4vfr0n3x8UfK0V+PFHGA
 oQkLtO7wJzeStIdUw2LuzRWNN/t9FYOnbNYRFvbx6gG9YGfFwfpR9k9d7lIWLDxuJ0
 9JEodWJQXqd+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
To: mohit.dsor@oss.qualcomm.com
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260728-lt9611c-v7-v8-2-bda216bfaf37@oss.qualcomm.com>
References: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
 <20260728-lt9611c-v7-v8-2-bda216bfaf37@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 11:26:14 +0000
Message-Id: <20260728112614.BF6721F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] Recursive locking deadlock in `lt9611c_hdmi_audio_prepare`.
- [High] The IRQ is enabled before the hardware reset is completed during r=
esume.
- [High] Premature manual teardown in remove() conflicts with devm_* APIs, =
leading to UAF and timeouts.
- [High] The IRQ handler incorrectly clears unhandled interrupts by writing=
 an inverted bitmask.
- [High] Early registration of the DRM bridge exposes it before resource in=
itialization is complete, risking use-after-free on probe failure.
- [Medium] The return value of devm_drm_bridge_add() is ignored.
- [Medium] Selecting REGMAP_I2C without a dependency on I2C causes a Kconfi=
g warning and build failure.
- [Medium] request_firmware() is called while holding the ocm_lock mutex.
- [Medium] Missing `regmap_read()` error handling causes uninitialized memo=
ry usage and broken firmware upgrade logic.
- [Medium] Incomplete error recovery in suspend callback leaves the device =
in a permanently broken state.
- [Medium] Synchronous firmware request during probe may permanently fail i=
f the root filesystem is not yet mounted.
- [Low] Firmware version is not updated in the driver state after a success=
ful sysfs upgrade.
--

--- Patch [2]: [PATCH v8 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI =
DSI to HDMI driver ---
commit d9ec2b705d140567b617d8df2b85d294039b2f5c
Author: Sunyun Yang <syyang@lontium.com>

drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

This commit adds a DRM bridge driver for the Lontium LT9611C,
LT9611EX, and LT9611UXD DSI to HDMI chips. It supports single or
dual MIPI DSI and I2S/SPDIF audio input to HDMI output. The driver
handles firmware loading, hot plug detection, and video/audio
configuration.

> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -177,6 +177,23 @@ config DRM_LONTIUM_LT9611
[ ... ]
> +config DRM_LONTIUM_LT9611C
> +	tristate "Lontium LT9611C DSI/HDMI bridge"
> +	select SND_SOC_HDMI_CODEC if SND_SOC
> +	depends on OF
> +	select CRC8
> +	select FW_LOADER
> +	select DRM_PANEL_BRIDGE
> +	select DRM_KMS_HELPER
> +	select DRM_MIPI_DSI
> +	select DRM_DISPLAY_HELPER
> +	select DRM_DISPLAY_HDMI_STATE_HELPER
> +	select REGMAP_I2C

[Severity: Medium]
Is there a missing dependency on I2C here?

Since this config selects REGMAP_I2C, if I2C is disabled, this could
violate Kconfig dependency rules and trigger an unmet direct dependencies
warning, causing build failures for the I2C subsystem functions.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/b=
ridge/lontium-lt9611c.c
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
[ ... ]
> +static void read_flash_reg_status(struct lt9611c *lt9611c, unsigned int =
*status)
> +{
[ ... ]
> +	regmap_multi_reg_write(lt9611c->regmap, seq_write, ARRAY_SIZE(seq_write=
));
> +
> +	regmap_read(lt9611c->regmap, 0xe05f, status);
> +}

[Severity: Medium]
What happens if this regmap_read() fails?

If the I2C read drops a packet, the status variable will retain its
previous value (which is 0 in the caller's initialization).

This would cause the erase loop condition in lt9611c_block_erase():
    if ((flash_status & 0x01) =3D=3D 0)
to evaluate to true immediately, potentially breaking the firmware
erase and upgrade logic.

[ ... ]
> +static int lt9611c_upgrade_result(struct lt9611c *lt9611c, u8 fw_crc)
> +{
> +	struct device *dev =3D lt9611c->dev;
> +	unsigned int crc_result;
> +
> +	regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
> +	regmap_read(lt9611c->regmap, 0xe021, &crc_result);
> +
> +	if (crc_result !=3D fw_crc) {

[Severity: Medium]
Should the return value of regmap_read() be checked here?

If the I2C read drops a packet, crc_result will contain uninitialized
memory when it is compared against fw_crc.

This could lead to a false success or failure of the upgrade check.

[ ... ]
> +static int lt9611c_firmware_upgrade(struct lt9611c *lt9611c)
> +{
> +	struct device *dev =3D lt9611c->dev;
> +	const struct firmware *fw;
[ ... ]
> +	/* 1. load firmware */
> +	ret =3D request_firmware(&fw, FW_FILE, dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to load '%s'\n", FW_FILE);

[Severity: Medium]
Will this cause permanent probe failures if the root filesystem is delayed?

When fw_version is 0, this calls request_firmware() synchronously from
lt9611c_probe(). If the firmware is not built-in and rootfs isn't
mounted yet, it fails with -ENOENT.

By propagating this error through dev_err_probe() rather than returning
-EPROBE_DEFER, the driver will fail permanently.

[Severity: Medium]
Is it safe to call request_firmware() while holding the ocm_lock?

This function is also called synchronously from lt9611c_firmware_store()
with the hardware-protecting ocm_lock held.

If the firmware file is missing, the firmware helper can block for up to
60 seconds. Holding the lock during this time will stall the device's
IRQ handler and any DRM atomic operations that need it.

[ ... ]
> +static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
> +{
[ ... ]
> +	if (!(irq_status & BIT(0)))
> +		return IRQ_HANDLED;
> +
> +	/*Clear interrupt: hardware requires two writes with delay*/
> +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & BIT(0));
> +	usleep_range(10000, 12000);
> +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & (~BIT(0)));

[Severity: High]
Could this clear sequence suppress other pending interrupts?

This writes the inverted bitmask to the clear register. If irq_status
indicates other interrupts are pending (such as bit 1), this will write
a 1 for bit 1.

Since no corresponding 0 is ever written to complete the pulse for bit 1,
its clear signal might be asserted indefinitely. This could either
improperly acknowledge it or permanently suppress it.

[ ... ]
> +static int lt9611c_hdmi_write_audio_infoframe(struct drm_bridge *bridge,
> +					      const u8 *buffer, size_t len)
> +{
[ ... ]
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	return lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +}

[ ... ]
> +static int lt9611c_hdmi_audio_prepare(struct drm_bridge *bridge,
> +				      struct drm_connector *connector,
> +				      struct hdmi_codec_daifmt *fmt,
> +				      struct hdmi_codec_params *hparms)
> +{
[ ... ]
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret =3D lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +	if (ret < 0) {
> +		dev_err(lt9611c->dev, "set audio info failed!\n");
> +		return ret;
> +	}
> +
> +	return drm_atomic_helper_connector_hdmi_update_audio_infoframe(connecto=
r,
> +									&hparms->cea);
> +}

[Severity: Critical]
Does this sequence result in a recursive locking deadlock?

In lt9611c_hdmi_audio_prepare(), guard(mutex)(&lt9611c->ocm_lock)
is acquired. While holding this lock, it calls
drm_atomic_helper_connector_hdmi_update_audio_infoframe().

That helper packs the infoframe and calls the connector's write_infoframe
hook, which routes back to lt9611c_hdmi_write_audio_infoframe().

This callback also attempts to acquire lt9611c->ocm_lock using
guard(mutex), leading to a self-deadlock since mutexes are not recursive.

[ ... ]
> +static ssize_t lt9611c_firmware_store(struct device *dev, struct device_=
attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	lt9611c_lock(lt9611c);
> +
> +	ret =3D lt9611c_firmware_upgrade(lt9611c);
> +	if (ret < 0)
> +		dev_err(dev, "upgrade failure\n");
> +
> +	lt9611c_unlock(lt9611c);
> +
> +	return ret < 0 ? ret : len;
> +}

[Severity: Low]
Should the cached firmware version be updated here?

If the firmware upgrade via sysfs succeeds, lt9611c->fw_version is
never updated.

Subsequent reads of the sysfs file will display the old version until
the device is rebound or the system is rebooted.

[ ... ]
> +static int lt9611c_probe(struct i2c_client *client)
> +{
[ ... ]
> +	lt9611c->bridge.hdmi_audio_max_i2s_playback_channels =3D 8;
> +	lt9611c->bridge.hdmi_audio_dai_port =3D 2;
> +
> +	devm_drm_bridge_add(dev, &lt9611c->bridge);

[Severity: Medium]
Should the return value of devm_drm_bridge_add() be checked?

If the devres allocation fails, it will return an error, but the
driver ignores it and continues probing. This could lead to a
silent display pipeline failure.

[Severity: High]
Could this early bridge registration cause a use-after-free?

The bridge is registered globally here before the primary and
secondary MIPI DSI interfaces are attached.

> +
> +	/* Attach primary DSI */
> +	lt9611c->dsi0 =3D lt9611c_attach_dsi(lt9611c, lt9611c->dsi0_node);
> +	if (IS_ERR(lt9611c->dsi0)) {
> +		ret =3D PTR_ERR(lt9611c->dsi0);
> +		goto err_remove_bridge;
> +	}

If lt9611c_attach_dsi() fails, the probe function errors out. However,
the bridge relies on devres to unregister it.

During this window, another display controller could discover and attach
to the visible bridge, retaining a pointer to the structure that devres
will soon free.

[ ... ]
> +static void lt9611c_remove(struct i2c_client *client)
> +{
> +	struct lt9611c *lt9611c =3D i2c_get_clientdata(client);
> +
> +	disable_irq(client->irq);
> +	cancel_work_sync(&lt9611c->work);
> +	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies=
);
> +	of_node_put(lt9611c->dsi1_node);
> +	of_node_put(lt9611c->dsi0_node);
> +}

[Severity: High]
Does this manual teardown conflict with the devm-managed bridge?

The bridge is registered with devm_drm_bridge_add(), so it is only
unregistered by devres after remove() returns. However, this function
manually calls cancel_work_sync() and regulator_bulk_disable().

If the DRM core calls .hpd_enable between remove() returning and
devres cleanup, the driver will call schedule_work() on the cancelled
workqueue.

This could cause a use-after-free when devres finally cleans up the
bridge context.

[ ... ]
> +static int lt9611c_bridge_suspend(struct device *dev)
> +{
[ ... ]
> +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> +
> +	ret =3D regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->=
supplies);
> +	if (ret)
> +		dev_err(lt9611c->dev, "regulator bulk disable failed.\n");
> +
> +	return ret;
> +}

[Severity: Medium]
What happens if regulator_bulk_disable() fails here?

If it fails, the function returns an error without reversing the
preceding state changes, such as disabling the IRQ and asserting the
reset GPIO.

The PM core will abort the suspend but won't call the resume callback
for this device, leaving it completely unresponsive.

[ ... ]
> +static int lt9611c_bridge_resume(struct device *dev)
> +{
[ ... ]
> +	ret =3D regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->s=
upplies);
> +	if (ret) {
> +		dev_err(lt9611c->dev, "regulator bulk enable failed.\n");
> +		return ret;
> +	}
> +	enable_irq(lt9611c->client->irq);
> +	lt9611c_reset(lt9611c);
> +
> +	return ret;
> +}

[Severity: High]
Should the IRQ be enabled after the hardware reset is complete?

This calls enable_irq() immediately before lt9611c_reset(). During
the 400+ ms reset sequence, the chip is held in reset and I2C is
unresponsive.

If an interrupt triggers (e.g. from power-up glitches or toggling the
reset pin), the handler will fire and try to read the status register
via I2C while the hardware is still booting, leading to bus timeouts
or lockups.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-lt9611c-v7=
-v8-0-bda216bfaf37@oss.qualcomm.com?part=3D2
