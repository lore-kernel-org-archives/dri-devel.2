Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1A3C4450E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FE710F2B9;
	Thu, 16 Jul 2026 11:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BIKg0OPe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF0410F2B9
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:43:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C72F6001A;
 Thu, 16 Jul 2026 11:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF901F00A3E;
 Thu, 16 Jul 2026 11:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784202193;
 bh=ZeTjdwzbut0/wxl8O0oT1KYtFQgAbA19n1Cg7HFYukQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BIKg0OPeKWYf8KXwariUb4/wT4pnwNMycysqoeDmZdTXdcetUkFb7UolUsJkJO0Z/
 A/o/iqYrFCEZMhQMScF6/BaEKvmiFzFc1m3OVVzgSpMYv7W70hOta+j8yJXGkfHD1I
 BJswaVLXOP7SZrrEZJWU00nU9/Eq+PQJ7jJx4mcLu9rhJ89R13jGLpi31B+CdQy4pv
 H+PNSOUDjV8s4PT8B8Jmub+GKXoEhzBUWgvDoNWWojqQz9muci4WcHhcxRF4Q31790
 k+VC4SJpqUhL9cwccvY7gDENFmV8nwhZIvmgtyk5mRDUy2ZVpHbrf0lbzIz6lvIXDv
 fUbWfu+EGKM3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] drm/bridge: Add Lontium LT9609C(EX/UXD) MIPI DSI
 to HDMI driver
To: mohit.dsor@oss.qualcomm.com
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260716-lt9611c-v7-v7-2-7553a14735fc@oss.qualcomm.com>
References: <20260716-lt9611c-v7-v7-0-7553a14735fc@oss.qualcomm.com>
 <20260716-lt9611c-v7-v7-2-7553a14735fc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 11:43:12 +0000
Message-Id: <20260716114312.DCF901F00A3E@smtp.kernel.org>
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
- [High] Missing `disable_irq()` in `lt9611c_remove()` creates a race condi=
tion leading to Use-After-Free and unpowered hardware access.
- [High] Stack buffer overflow in `lt9611c_hdmi_write_hdmi_infoframe` due t=
o unchecked `len` parameter.
- [High] Permanent module reference leak due to unbalanced `drm_bridge_get(=
)` in `lt9611c_parse_dt()`.
- [High] Self-deadlock in `lt9611c_hdmi_audio_prepare` due to double lockin=
g of `ocm_lock` via nested DRM helper callbacks.
- [High] Erratic interrupt clearing sequence can permanently lock up the ed=
ge-triggered interrupt line and lose events.
- [High] Ignored return value of `devm_drm_bridge_add()` can lead to succes=
sful probe with an unregistered bridge.
- [High] Missing `cancel_work_sync()` in `lt9611c_bridge_suspend()` allows =
the HPD work to execute while the hardware is powered off.
- [High] Race condition between sysfs file creation and initialization of `=
clientdata` causes a NULL pointer dereference.
- [Medium] Synchronous firmware loading while holding a hardware mutex (`oc=
m_lock`).
- [Medium] Ignored flash erase timeout allows firmware upgrade to silently =
corrupt device flash.
--

--- Patch [2]: [PATCH v7 2/2] drm/bridge: Add Lontium LT9609C(EX/UXD) MIPI =
DSI to HDMI driver ---
commit b64f10044aaf95610928583023bd2bc668abab4e
Author: Sunyun Yang <syyang@lontium.com>
Subject: drm/bridge: Add Lontium LT9609C(EX/UXD) MIPI DSI to HDMI driver

This commit introduces the driver for the Lontium LT9611C DSI to HDMI bridg=
e.=20
It adds support for configuring video timing, reading EDID, handling HPD=20
interrupts, and managing firmware upgrades.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/b=
ridge/lontium-lt9611c.c
> new file mode 100644
> index 0000000000000..e8bb385d15206
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> @@ -0,0 +1,1293 @@

[ ... ]

> +static void lt9611c_block_erase(struct lt9611c *lt9611c)
> +{
> +	struct device *dev =3D lt9611c->dev;
> +	int i;
> +	unsigned int block_num;
> +	unsigned int flash_status =3D 0;
> +	u32 flash_addr =3D 0;
> +
> +	for (block_num =3D 0; block_num < 2; block_num++) {
> +		flash_addr =3D (block_num * 0x008000);
> +		lt9611c_erase_op(lt9611c, flash_addr);
> +		msleep(100);
> +		i =3D 0;
> +		while (1) {
> +			read_flash_reg_status(lt9611c, &flash_status);
> +			if ((flash_status & 0x01) =3D=3D 0)
> +				break;
> +
> +			if (i > 50)
> +				break;

[Severity: Medium]
Does this ignore the flash erase timeout? If the polling loop in=20
lt9611c_block_erase() times out, it breaks out silently. Since this functio=
n=20
has no return value, lt9611c_firmware_upgrade() will proceed to write the n=
ew=20
firmware over an unerased block, which could corrupt the device firmware.

> +
> +			i++;
> +			msleep(50);
> +		}
> +	}
> +
> +	dev_dbg(dev, "erase flash done.\n");
> +}

[ ... ]

> +static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
> +{
> +	struct lt9611c *lt9611c =3D dev_id;
> +	struct device *dev =3D lt9611c->dev;
> +	int ret;
> +	unsigned int irq_status;
> +	u8 cmd[5] =3D {0x52, 0x48, 0x31, 0x3a, 0x00};
> +	u8 data[5];
> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret =3D regmap_read(lt9611c->regmap, 0xe084, &irq_status);
> +	if (ret) {
> +		dev_err(dev, "failed to read irq status: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (!(irq_status & BIT(0)))
> +		return IRQ_HANDLED;

[Severity: High]
Could this early return permanently lock up the edge-triggered interrupt li=
ne?
If another status bit triggered the interrupt, this bails out without writi=
ng=20
to the clear register (0xe0df). Because the interrupt line is configured as=
=20
IRQF_TRIGGER_FALLING, leaving it asserted prevents any future falling edges=
=20
and permanently locks up all future hardware interrupts.

> +
> +	msleep(100);
> +
> +	ret =3D lt9611c_read_write_flow(lt9611c, cmd, ARRAY_SIZE(cmd), data, AR=
RAY_SIZE(data));

[ ... ]

> +static int lt9611c_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
> +					     const u8 *buffer, size_t len)
> +{
> +	struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> +	u8 cmd[5 + LT9611C_INFOFRAME_MAX_SIZE];
> +	u8 data[5];
> +	int ret;
> +
> +	cmd[0] =3D 0x57;
> +	cmd[1] =3D 0x48;
> +	cmd[2] =3D 0x35;
> +	cmd[3] =3D 0x3a;
> +	cmd[4] =3D 0x04;/*write vsif*/
> +	memcpy(cmd + 5, buffer, len);

[Severity: High]
Is it possible to overflow the cmd stack buffer here? The cmd array is=20
allocated with a fixed size of 37 bytes (5 + LT9611C_INFOFRAME_MAX_SIZE).=20
Because the len parameter is passed directly to memcpy without validation,=
=20
passing an infoframe larger than 32 bytes would corrupt the stack.

> +
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret =3D lt9611c_read_write_flow(lt9611c, cmd, 5 + len,
> +				      data, ARRAY_SIZE(data));

[ ... ]

> +static int lt9611c_hdmi_write_audio_infoframe(struct drm_bridge *bridge,
> +					      const u8 *buffer, size_t len)
> +{
> +	struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> +	u8 *cmd;
> +	u8 data[5];
> +	int ret;
> +
> +	guard(mutex)(&lt9611c->ocm_lock);

[ ... ]

> +static int lt9611c_hdmi_audio_prepare(struct drm_bridge *bridge,
> +				      struct drm_connector *connector,
> +				      struct hdmi_codec_daifmt *fmt,
> +				      struct hdmi_codec_params *hparms)
> +{
> +	struct lt9611c *lt9611c =3D bridge_to_lt9611c(bridge);
> +	u8 audio_cmd[6] =3D {0x57, 0x48, 0x36, 0x3a};
> +	u8 data[5];
> +	int ret;
> +
> +	if (hparms->sample_width =3D=3D 32)
> +		return -EINVAL;
> +
> +	switch (fmt->fmt) {
> +	case HDMI_I2S:
> +		audio_cmd[4] =3D 0x01;
> +		break;
> +	case HDMI_SPDIF:
> +		audio_cmd[4] =3D 0x02;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	audio_cmd[5] =3D hparms->channels;
> +	guard(mutex)(&lt9611c->ocm_lock);
> +
> +	ret =3D lt9611c_read_write_flow(lt9611c, audio_cmd, sizeof(audio_cmd),
> +				      data, sizeof(data));
> +	if (ret < 0) {
> +		dev_err(lt9611c->dev, "set audio info failed!\n");
> +		return ret;
> +	}
> +
> +	return drm_atomic_helper_connector_hdmi_update_audio_infoframe(connecto=
r,
> +									&hparms->cea);

[Severity: High]
Will this cause a self-deadlock? The ocm_lock is acquired here in=20
lt9611c_hdmi_audio_prepare(). We then call=20
drm_atomic_helper_connector_hdmi_update_audio_infoframe(), which internally=
=20
invokes the connector's write_infoframe hook mapped to=20
lt9611c_hdmi_write_audio_infoframe(). That inner function attempts to acqui=
re=20
ocm_lock again. Since Linux mutexes are not recursive, this guarantees a=20
deadlock.

> +}

[ ... ]

> +static int lt9611c_parse_dt(struct device *dev,
> +			    struct lt9611c *lt9611c)
> +{
> +	int ret;
> +
> +	lt9611c->dsi0_node =3D of_graph_get_remote_node(dev->of_node, 0, -1);
> +	if (!lt9611c->dsi0_node)
> +		return dev_err_probe(dev, -ENODEV, "failed to get remote node for prim=
ary dsi\n");
> +
> +	lt9611c->dsi1_node =3D of_graph_get_remote_node(dev->of_node, 1, -1);
> +
> +	ret =3D drm_of_find_panel_or_bridge(dev->of_node, 2, -1, NULL, &lt9611c=
->bridge.next_bridge);
> +	if (ret) {
> +		of_node_put(lt9611c->dsi1_node);
> +		of_node_put(lt9611c->dsi0_node);
> +		return ret;
> +	}
> +	drm_bridge_get(lt9611c->bridge.next_bridge);

[Severity: High]
Does this code leak a module reference to the next bridge? The reference=20
acquired by drm_bridge_get() here is never released. The driver's=20
lt9611c_remove() function does not call drm_bridge_put() to balance this,=20
meaning every unbind/rebind cycle leaks a reference.

> +	return 0;
> +}

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

[Severity: Medium]
Is it safe to hold ocm_lock during a synchronous firmware load?=20
lt9611c_firmware_upgrade() calls request_firmware(), which can block for up=
 to=20
60 seconds on VFS and user-mode helpers. While blocked, the IRQ threaded=20
handler and atomic commit callbacks will be starved as they contend for the=
=20
same mutex.

> +	if (ret < 0)
> +		dev_err(dev, "upgrade failure\n");
> +
> +	lt9611c_unlock(lt9611c);
> +
> +	return ret < 0 ? ret : len;
> +}
> +
> +static ssize_t lt9611c_firmware_show(struct device *dev, struct device_a=
ttribute *attr, char *buf)
> +{
> +	struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "0x%04x\n", lt9611c->fw_version);

[Severity: High]
Can dev_get_drvdata(dev) return NULL here? Sysfs attributes are added via t=
he=20
dev_groups member of the i2c_driver struct, meaning the driver core creates=
=20
them before the probe function finishes. In lt9611c_probe(),=20
i2c_set_clientdata() is called very late. If userspace reads this attribute=
=20
concurrently before probe completes, this will dereference a NULL pointer.

> +}

[ ... ]

> +static int lt9611c_probe(struct i2c_client *client)
> +{

[ ... ]

> +	lt9611c->bridge.hdmi_audio_max_i2s_playback_channels =3D 8;
> +	lt9611c->bridge.hdmi_audio_dai_port =3D 2;
> +
> +	devm_drm_bridge_add(dev, &lt9611c->bridge);

[Severity: High]
Shouldn't we check the return value of devm_drm_bridge_add()? If devres=20
allocation fails, the bridge won't be added to the DRM bridge chain, but pr=
obe=20
will continue and return success. This leaves the subsystem in an inconsist=
ent=20
state.

> +
> +	/* Attach primary DSI */
> +	lt9611c->dsi0 =3D lt9611c_attach_dsi(lt9611c, lt9611c->dsi0_node);
> +	if (IS_ERR(lt9611c->dsi0)) {

[ ... ]

> +static void lt9611c_remove(struct i2c_client *client)
> +{
> +	struct lt9611c *lt9611c =3D i2c_get_clientdata(client);
> +
> +	cancel_work_sync(&lt9611c->work);
> +	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies=
);
> +	of_node_put(lt9611c->dsi1_node);
> +	of_node_put(lt9611c->dsi0_node);
> +}

[Severity: High]
Does this leave a race condition leading to a use-after-free? The IRQ was=20
registered via devm_request_threaded_irq(). Because there is no explicit=20
disable_irq() call here, the interrupt line remains active until devres=20
cleanup runs after remove() returns. If an interrupt fires after=20
cancel_work_sync(), the threaded handler will run, re-queue the work item, =
and=20
attempt I2C access while the device is unpowered.

> +
> +static int lt9611c_bridge_suspend(struct device *dev)
> +{
> +	struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_dbg(lt9611c->dev, "suspend\n");
> +	disable_irq(lt9611c->client->irq);
> +
> +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> +
> +	ret =3D regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->=
supplies);

[Severity: High]
Should this flush the workqueue before disabling regulators? If an interrup=
t=20
fired and scheduled lt9611c->work right before disable_irq() was called, th=
e=20
work item stays in the queue. When it executes, it will trigger an I2C read=
 in=20
lt9611c_bridge_detect() while the device regulators are disabled, leading t=
o=20
timeouts or a kernel panic.

> +	if (ret)
> +		dev_err(lt9611c->dev, "regulator bulk disable failed.\n");
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-lt9611c-v7=
-v7-0-7553a14735fc@oss.qualcomm.com?part=3D2
