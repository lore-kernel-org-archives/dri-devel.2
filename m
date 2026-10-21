Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F26606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kf7Uw51I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 104DA10E093;
	Wed, 21 Oct 2026 08:23:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68EBD10E093
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:23:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 080064028E;
 Wed, 21 Oct 2026 08:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927801F000C9;
 Wed, 21 Oct 2026 08:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792571027;
 bh=azmhn9m0ALCnnrCrGcJllYYe6RXLKcys5fGtxWrpVQY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kf7Uw51IYWkNzwnwYI1ggdSLOOC9akztpiQ2CgoO7fq6ggUyQrG9Pa5pNofKfGYy4
 jjI3qTsH+T5NeTRAGZmmRQYPXmJ7SRsd1DcJ3JK6vXfgPUm3pg7rXjSSN70s5YEGQq
 qaMym2GaduFHfIbUpFquvLiiK/Sk06jdw9fGj+sszuBDm6a0C1bTHx7PaEeOoFZ2BD
 O+h+7o2vu8I5VwgFp3lHCAwimiO/thi2TmHajdwqJCXETexW53l/LWN4E8eH0cBVeg
 R+siiYx0kO8qRfBS4u6H06S92CIZHJ9Ety9qq4iQkTdfVQXSEJDBdI8sV9JwcWkt35
 tF0PbzMyw3RcQ==
Message-ID: <sashiko-outbox-179959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
To: mohit.dsor@oss.qualcomm.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261021-lt9611c-v7-v18-2-4978b94896f1@oss.qualcomm.com>
References: <20261021-lt9611c-v7-v18-0-4978b94896f1@oss.qualcomm.com>
 <20261021-lt9611c-v7-v18-2-4978b94896f1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 08:23:47 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] drm/bridge: lt9611c: negative errno stored in fw_version corrupt=
s firmware_show()
- [Medium] drm/bridge: lt9611c: unlocked reset and power control in PM call=
backs
- [Low] drm/bridge: lt9611c: unused function warnings when CONFIG_PM_SLEEP=
=3Dn
- [Low] drm/bridge: lt9611c: missing MODULE_DEVICE_TABLE() for lt9611c_id
- [Low] drm/bridge: lt9611c: unlocked reset of hdmi_connected after bridge =
attach
--

commit 990744b0d700fbd77a4343ac0bdea653a817a6ce
Author: Sunyun Yang <syyang@lontium.com>

drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

This commit adds a DRM bridge driver for the Lontium LT9611C, LT9611EX, and
LT9611UXD MIPI DSI to HDMI bridge chips. It supports EDID reading, HPD
detection, HDMI audio over I2S, dual-DSI mode, and firmware upgrades via
sysfs.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/b=
ridge/lontium-lt9611c.c
> new file mode 100644
> index 0000000000000..8fc86c0732122
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> @@ -0,0 +1,1361 @@

[ ... ]

> +static ssize_t firmware_store(struct device *dev, struct device_attribut=
e *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!lt9611c)
> +		return -ENODEV;
> +
> +	dev_warn(dev, "starting firmware upgrade =E2=80=94 display will be disr=
upted\n");
> +
> +	ret =3D lt9611c_firmware_upgrade(lt9611c);
> +	if (ret < 0) {
> +		dev_err(dev, "upgrade failure\n");
> +		return ret;
> +	}
> +
> +	lt9611c_lock(lt9611c);
> +	WRITE_ONCE(lt9611c->fw_version, lt9611c_read_version(lt9611c));
> +	lt9611c_unlock(lt9611c);
> +
> +	if (READ_ONCE(lt9611c->fw_version) < 0)
> +		dev_warn(dev, "upgrade succeeded but failed to read new fw version\n");
> +	else
> +		dev_info(dev, "firmware upgrade succeeded, version: 0x%04x\n",
> +			 READ_ONCE(lt9611c->fw_version));
> +
> +	return len;
> +}
> +
> +static ssize_t firmware_show(struct device *dev, struct device_attribute=
 *attr, char *buf)
> +{
> +	struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> +
> +	if (!lt9611c)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "0x%04x\n", READ_ONCE(lt9611c->fw_version));
> +}

[Severity: Medium]
In drivers/gpu/drm/bridge/lontium-lt9611c.c, what happens in firmware_show()
if reading the version fails after a firmware upgrade in firmware_store()?

When regmap_write() or regmap_bulk_read() fails inside lt9611c_read_version=
(),
it returns a negative errno that firmware_store() writes directly into
lt9611c->fw_version via WRITE_ONCE().

Subsequent reads of the sysfs firmware attribute will then format that
negative errno with "0x%04x" in firmware_show(), emitting a sign-extended
32-bit hex error code (such as 0xfffffffb) to userspace instead of a 16-bit
firmware version or an error return.

Should firmware_store() only update lt9611c->fw_version when
lt9611c_read_version() succeeds, or should firmware_show() check for a
negative lt9611c->fw_version before formatting it?

[ ... ]

> +static int lt9611c_probe(struct i2c_client *client)
> +{

[ ... ]

> +	drm_bridge_add(&lt9611c->bridge);
> +
> +	/* Attach primary DSI */
> +	dsi =3D lt9611c_attach_dsi(lt9611c, dsi0_node);
> +	if (IS_ERR(dsi)) {
> +		ret =3D PTR_ERR(dsi);
> +		goto err_remove_bridge;
> +	}
> +
> +	/* Attach secondary DSI, if specified */
> +	if (dsi1_node) {
> +		dsi =3D lt9611c_attach_dsi(lt9611c, dsi1_node);
> +		if (IS_ERR(dsi)) {
> +			ret =3D PTR_ERR(dsi);
> +			goto err_remove_bridge;
> +		}
> +	}
> +
> +	lt9611c->hdmi_connected =3D false;
> +	enable_irq(client->irq);

[Severity: Low]
In lt9611c_probe() in drivers/gpu/drm/bridge/lontium-lt9611c.c, can setting
lt9611c->hdmi_connected =3D false here race with lt9611c_bridge_detect()?

Once drm_bridge_add() and lt9611c_attach_dsi() have been called, the DSI ho=
st
can bind the DRM device and run initial connector detection, which invokes
lt9611c_bridge_detect() and updates lt9611c->hdmi_connected under
lt9611c->mcu_lock:

	guard(mutex)(&lt9611c->mcu_lock);

	ret =3D lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
	if (ret)
		dev_err(dev, "failed to read HPD status (err=3D%d)\n", ret);
	else
		connected =3D (hpd_status =3D=3D 0x02);

	lt9611c->hdmi_connected =3D connected;

Writing lt9611c->hdmi_connected =3D false in lt9611c_probe() without holding
lt9611c->mcu_lock after the bridge is attached can clobber the detected sta=
te
(and lt9611c is already zero-initialized by devm_drm_bridge_alloc()). Could
this assignment be dropped or moved before drm_bridge_add()?

[ ... ]

> +static int lt9611c_bridge_suspend(struct device *dev)
> +{
> +	struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	disable_irq(lt9611c->client->irq);
> +	cancel_work_sync(&lt9611c->work);
> +
> +	gpiod_set_value_cansleep(lt9611c->reset_gpio, 1);
> +
> +	ret =3D regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->=
supplies);
> +	if (ret) {
> +		dev_err(lt9611c->dev, "regulator bulk disable failed.\n");
> +		gpiod_set_value_cansleep(lt9611c->reset_gpio, 0);
> +		msleep(400);
> +		enable_irq(lt9611c->client->irq);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lt9611c_bridge_resume(struct device *dev)
> +{
> +	struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->s=
upplies);
> +	if (ret) {
> +		dev_err(lt9611c->dev, "regulator bulk enable failed.\n");
> +		return ret;
> +	}
> +	lt9611c_reset(lt9611c);
> +	enable_irq(lt9611c->client->irq);
> +
> +	return ret;
> +}

[Severity: Medium]
In drivers/gpu/drm/bridge/lontium-lt9611c.c, should lt9611c_bridge_suspend()
and lt9611c_bridge_resume() hold lt9611c->mcu_lock while asserting reset_gp=
io,
toggling the regulators, and running lt9611c_reset()?

During system suspend and resume, disable_irq() and cancel_work_sync() only
stop the HPD interrupt and lt9611c->work. Because fw_devlink relaxes
bidirectional OF-graph links and there is no PM device link ordering this I=
2C
client against the DRM master device or audio codec, bridge callbacks such =
as
lt9611c_bridge_detect(), lt9611c_bridge_edid_read(),
lt9611c_bridge_atomic_enable(), or lt9611c_hdmi_audio_prepare() can run
concurrently.

Those callbacks serialize hardware access with lt9611c->mcu_lock, whereas
lt9611c_bridge_suspend() and lt9611c_bridge_resume() assert reset_gpio,
disable/enable the vcc and vdd supplies, and run the 400ms reset sequence
without acquiring lt9611c->mcu_lock, which could reset or power down the ch=
ip
mid-transaction in lt9611c_read_write_flow().

> +
> +static const struct dev_pm_ops lt9611c_bridge_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(lt9611c_bridge_suspend,
> +				lt9611c_bridge_resume)
> +};
> +
> +static const struct i2c_device_id lt9611c_id[] =3D {
> +	{ .name =3D "lt9611c",   .driver_data =3D (kernel_ulong_t)&lt9611c_chip=
_data[CHIP_LT9611C]   },
> +	{ .name =3D "lt9611ex",  .driver_data =3D (kernel_ulong_t)&lt9611c_chip=
_data[CHIP_LT9611EX]  },
> +	{ .name =3D "lt9611uxd", .driver_data =3D (kernel_ulong_t)&lt9611c_chip=
_data[CHIP_LT9611UXD] },
> +	{ /* sentinel */ }
> +};

[Severity: Low]
In drivers/gpu/drm/bridge/lontium-lt9611c.c, is MODULE_DEVICE_TABLE(i2c,
lt9611c_id) missing after lt9611c_id?

Without MODULE_DEVICE_TABLE(i2c, lt9611c_id), building the driver as a modu=
le
(CONFIG_DRM_LONTIUM_LT9611C=3Dm) omits the i2c:lt9611c, i2c:lt9611ex, and
i2c:lt9611uxd modalias entries from modules.alias, preventing automatic mod=
ule
loading when devices are instantiated via I2C device IDs.

> +
> +static const struct of_device_id lt9611c_match_table[] =3D {
> +	{ .compatible =3D "lontium,lt9611c",   .data =3D &lt9611c_chip_data[CHI=
P_LT9611C]   },
> +	{ .compatible =3D "lontium,lt9611ex",  .data =3D &lt9611c_chip_data[CHI=
P_LT9611EX]  },
> +	{ .compatible =3D "lontium,lt9611uxd", .data =3D &lt9611c_chip_data[CHI=
P_LT9611UXD] },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, lt9611c_match_table);
> +
> +static struct i2c_driver lt9611c_driver =3D {
> +	.driver =3D {
> +		.name =3D "lt9611c",
> +		.of_match_table =3D lt9611c_match_table,
> +		.pm =3D &lt9611c_bridge_pm_ops,
> +		.dev_groups =3D lt9611c_attr_groups,
> +	},

[Severity: Low]
In drivers/gpu/drm/bridge/lontium-lt9611c.c, will building with
CONFIG_PM_SLEEP=3Dn trigger unused-function warnings for
lt9611c_bridge_suspend() and lt9611c_bridge_resume()?

SET_SYSTEM_SLEEP_PM_OPS() expands to nothing when CONFIG_PM_SLEEP is disabl=
ed,
leaving both static functions unreferenced without __maybe_unused annotatio=
ns.

Could this use DEFINE_SIMPLE_DEV_PM_OPS(lt9611c_bridge_pm_ops,
lt9611c_bridge_suspend, lt9611c_bridge_resume) (or SYSTEM_SLEEP_PM_OPS())
along with pm_sleep_ptr(&lt9611c_bridge_pm_ops) on .pm so the compiler can
dead-code eliminate the callbacks and dev_pm_ops structure when
CONFIG_PM_SLEEP=3Dn?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-lt9611c-v7=
-v18-0-4978b94896f1@oss.qualcomm.com?part=3D2
