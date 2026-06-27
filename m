Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950E5C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 20:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D1410E308;
	Sat, 27 Jun 2026 20:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IeTPp4+a";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95FFF10E308
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:54:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3EC1C43A66;
 Sat, 27 Jun 2026 20:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEDC1F000E9;
 Sat, 27 Jun 2026 20:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782593683;
 bh=Y8auQex1QydmfoQJ1L6kFVe4F0h9A8KnXtX//iH/J3I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IeTPp4+ag3oQVAf7dZzzLl930pk26toV2FiPg22rJgxRw/YvLMS1By6HModS0/Vbd
 i2ombo7EtsK2W/9axHKrhDUUitTIbdCgICxsMIfSIcTiNkqAbV5QFBQPqzSGfbi5dC
 bqJJJeE/rDnt++Kk8Gu3OQ2PIFKIu/H7+hIHdED3c/Zte8+IE/zoMZJzCouVvBpqOA
 WPvijBItjQ0F2i7x8UrQz0gxBAZztMICztVEEua5aC1rSp+JEHZqL+yX1FuxXjGy3K
 VUAM/tBTLh0YZ+40Ngg3jQpC4Yd6Fcpx0P+DHgDrsTxD7CPgITGSlpQ1+5tH41kBh/
 dMSIFDxetdBRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: bridge: add support for lontium LT9611UXD bridge
To: mohit.dsor@oss.qualcomm.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627204125.3334834-2-mohit.dsor@oss.qualcomm.com>
References: <20260627204125.3334834-1-mohit.dsor@oss.qualcomm.com>
 <20260627204125.3334834-2-mohit.dsor@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 20:54:42 +0000
Message-Id: <20260627205442.EFEDC1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] Missing error checks for `regmap_bulk_read()` cause the driver=
 to leak uninitialized kernel stack memory to userspace.
- [High] Requesting the threaded IRQ before `drm_bridge_add()` creates a ra=
ce condition where the IRQ handler triggers a hotplug notification on an un=
initialized mutex.
- [High] The driver blocks the probe thread with an arbitrary 3-second slee=
p and synchronous firmware request.
- [High] Missing MCU pause sequence and inconsistent locking during multi-r=
egister I2C flows causes hardware protocol violations.
- [High] The hardware reset sequence incorrectly assumes `gpiod_set_value_c=
ansleep(..., 1)` implies physical high, permanently holding the chip in res=
et if configured as active-low.
- [High] Concurrent sysfs writes to the firmware store can cause a race con=
dition leading to a Use-After-Free of the `firmware` object.
- [High] The sysfs interface allows access to a destroyed mutex and powered=
-down device during driver removal.
- [Medium] The driver leaks the loaded `struct firmware` object when firmwa=
re size validation fails.
- [Medium] Device tree node references for primary and secondary DSI interf=
aces are leaked on error paths during probe.
- [Medium] The `edid_read` boolean flag is never cleared, causing hotplug e=
vents to skip waiting for the new EDID.
--

commit 437e6d5b427406deebe87f22d20ccf090df265b9
Author: Mohit Dsor <mohit.dsor@oss.qualcomm.com>

drm: bridge: add support for lontium LT9611UXD bridge

This commit introduces the driver for the Lontium LT9611UXD HDMI bridge.
It supports DSI and I2S ports as input and an HDMI port as output.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxd.c b/drivers/gpu/drm=
/bridge/lontium-lt9611uxd.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxd.c
[ ... ]
> +static int lt9611uxd_i2c_read_write_flow(struct lt9611uxd *lt9611uxd, u8=
 *params,
[ ... ]
> +	regmap_bulk_read(lt9611uxd->regmap, 0xe085, return_buffer, return_count=
);
> +
> +	return 0;
> +}

[Severity: Critical]
Does this code leak uninitialized stack memory to userspace? The return val=
ue
of regmap_bulk_read() is discarded and 0 is unconditionally returned. If the
I2C read fails, the uninitialized memory in return_buffer (such as the pack=
et
array in lt9611uxd_get_edid_block()) could be copied to the EDID buffer.

[ ... ]
> +static int lt9611uxd_prepare_firmware_data(struct lt9611uxd *lt9611uxd)
> +{
[ ... ]
> +	/* ensure filesystem ready */
> +	msleep(3000);
> +	ret =3D request_firmware(&lt9611uxd->fw, FW_FILE, dev);

[Severity: High]
Does this synchronous sleep and firmware request block the probe thread?
Delaying the probe by 3 seconds could significantly slow down boot, or cause
a deadlock if the filesystem containing the firmware is not mounted yet.

[ ... ]
> +	if (lt9611uxd->fw->size > FW_SIZE - 1) {
> +		dev_err(dev, "firmware too large (%zu > %d)\n", lt9611uxd->fw->size, F=
W_SIZE - 1);
> +		lt9611uxd->fw =3D NULL;
> +		return -EINVAL;
> +	}

[Severity: Medium]
Does this code leak the struct firmware object? The pointer is nullified
before a call to release_firmware() can occur.

[ ... ]
> +static int lt9611uxd_wait_for_edid(struct lt9611uxd *lt9611uxd)
> +{
> +	return wait_event_interruptible_timeout(lt9611uxd->wq, lt9611uxd->edid_=
read,
> +			msecs_to_jiffies(500));
> +}
[ ... ]
> +static irqreturn_t lt9611uxd_irq_thread_handler(int irq, void *dev_id)
> +{
[ ... ]
> +	/* Check for EDID ready */
> +	if (irq_status & BIT(0)) {
> +		lt9611uxd->edid_read =3D true;
> +		wake_up_all(&lt9611uxd->wq);
> +	}

[Severity: Medium]
Is the edid_read flag ever cleared back to false? If a monitor is unplugged
and replugged, this flag might remain true, causing lt9611uxd_wait_for_edid=
()
to skip waiting for the new EDID.

[ ... ]
> +static void lt9611uxd_hpd_work(struct work_struct *work)
> +{
[ ... ]
> +	drm_bridge_hpd_notify(&lt9611uxd->bridge, connected ?
> +			      connector_status_connected :
> +			      connector_status_disconnected);
> +}

[Severity: High]
Can this notify the DRM core before the bridge is fully initialized? The
threaded IRQ is requested early in probe, potentially triggering this work
before drm_bridge_add() initializes the bridge mutex.

[ ... ]
> +static void lt9611uxd_reset(struct lt9611uxd *lt9611uxd)
> +{
> +	gpiod_set_value_cansleep(lt9611uxd->reset_gpio, 1);
> +	msleep(20);
> +	gpiod_set_value_cansleep(lt9611uxd->reset_gpio, 0);
> +	msleep(20);
> +	gpiod_set_value_cansleep(lt9611uxd->reset_gpio, 1);
> +	msleep(400);
> +}

[Severity: High]
Does this sequence incorrectly assume that 1 implies a physical high signal?
If the GPIO is configured as active-low, leaving it at 1 will permanently
assert the reset line.

[ ... ]
> +static int lt9611uxd_get_edid_block(void *data, u8 *buf,
> +				  unsigned int block, size_t len)
> +{
[ ... ]
> +	for (i =3D 0; i < 4; i++) {
> +		cmd[4] =3D block * 4 + i;
> +		ret =3D lt9611uxd_i2c_read_write_flow(lt9611uxd, cmd, sizeof(cmd),
> +						    packet, sizeof(packet));

[Severity: High]
Should this call to lt9611uxd_i2c_read_write_flow() be protected by
mutex_lock(&lt9611uxd->ocm_lock)? Other callers hold this lock to pause
the MCU and prevent concurrent access violations.

[ ... ]
> +static int lt9611uxd_parse_dt(struct device *dev,
> +			    struct lt9611uxd *lt9611uxd)
> +{
[ ... ]
> +	return drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &lt9611ux=
d->next_bridge);
> +}

[Severity: Medium]
Does this code leak the device tree node references acquired earlier by
of_graph_get_remote_node()?

[ ... ]
> +static ssize_t lt9611uxd_firmware_store(struct device *dev, struct devic=
e_attribute *attr,
[ ... ]
> +out:
> +	lt9611uxd_unlock(lt9611uxd);
> +	lt9611uxd_reset(lt9611uxd);
> +	if (lt9611uxd->fw) {
> +		release_firmware(lt9611uxd->fw);
> +		lt9611uxd->fw =3D NULL;
> +	}
> +
> +	return ret < 0 ? ret : len;
> +}

[Severity: High]
Can a concurrent write to this sysfs attribute cause a Use-After-Free?
The firmware pointer is evaluated and released outside the protection of
lt9611uxd->ocm_lock, meaning another thread could be using it.

[ ... ]
> +static int lt9611uxd_probe(struct i2c_client *client)
> +{
[ ... ]
> +	ret =3D lt9611uxd_parse_dt(dev, lt9611uxd);
> +	if (ret) {
> +		dev_err(dev, "failed to parse device tree\n");
> +		return ret;
> +	}

[Severity: Medium]
Does this early return bypass the cleanup path that releases the DT nodes?

[ ... ]
> +static void lt9611uxd_remove(struct i2c_client *client)
> +{
> +	struct lt9611uxd *lt9611uxd =3D i2c_get_clientdata(client);
> +
> +	free_irq(client->irq, lt9611uxd);
> +	cancel_work_sync(&lt9611uxd->work);
> +	drm_bridge_remove(&lt9611uxd->bridge);
> +	mutex_destroy(&lt9611uxd->ocm_lock);
> +	regulator_bulk_disable(ARRAY_SIZE(lt9611uxd->supplies), lt9611uxd->supp=
lies);
> +	of_node_put(lt9611uxd->dsi1_node);
> +	of_node_put(lt9611uxd->dsi0_node);
> +}

[Severity: High]
Is it safe to destroy the mutex and disable regulators here while sysfs
attributes are still active? Because the sysfs attributes are registered via
dev_groups, they are not removed until after lt9611uxd_remove() completes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627204125.3334=
834-2-mohit.dsor@oss.qualcomm.com?part=3D1
