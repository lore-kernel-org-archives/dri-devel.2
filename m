Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBE6C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1993110E0C0;
	Mon, 24 Aug 2026 14:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WVJ26So0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A9B10E0C0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:21:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2281143B60;
 Mon, 24 Aug 2026 14:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B655A1F00A3A;
 Mon, 24 Aug 2026 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787581286;
 bh=21exBnjwsDW+R/kDKogTAsBJW33Mxny+2PiJ5JKiHAA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WVJ26So0gbfQe1fHJZkzHihJ1shO1BSqxSBzd83FbcSmrIZ519/nf60Uzbcd48FND
 2QyKAFYJu1E9enMNT5ghNqjLpNt3jJpm+xjfk31Qk+UyWW8rf0RFHeLQMwbZJ/aJKb
 91bwbuoYc5UqsnAqQapIVrVbpG/wvFIHs7Ox12fyDQlrzz1t1gtV1ANTWjotFI6LW9
 2DofZG5Oys5bJxy8bMs5Ahiu7FDMtnMZ8DN6esLvm3zZzXJ9/B8ZOnhdexfUKGUDxs
 FWsEGQhRCxRmRhGRPSX1AcfFM0w5dx+94YrEuejsYwmjugHU0bNiERDf1q0aeb2unb
 mVT5phtnz+fVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
To: mohit.dsor@oss.qualcomm.com
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260824-lt9611c-v7-v11-2-eb4a79cb597c@oss.qualcomm.com>
References: <20260824-lt9611c-v7-v11-0-eb4a79cb597c@oss.qualcomm.com>
 <20260824-lt9611c-v7-v11-2-eb4a79cb597c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 14:21:25 +0000
Message-Id: <20260824142125.B655A1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Incorrect HPD read response length causes HDMI to never be detecte=
d.
- [High] Sysfs attributes are accessible before drvdata is initialized, cau=
sing a NULL pointer dereference.
- [Medium] Incorrect interrupt clear sequence leaves other active interrupt=
s stuck high.
- [Medium] Global CRC table is initialized concurrently in probe(), creatin=
g a data race.
--

--- Patch [2]: [PATCH v11 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI=
 DSI to HDMI driver ---
commit 1a2f947d19c88c8a2effc903f8f83ec6e9fd330b
Author: Sunyun Yang <syyang@lontium.com>
Subject: drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

This commit introduces a new DRM bridge driver for the Lontium LT9611C=20
series chips. It provides conversion from MIPI DSI and I2S signals to=20
HDMI output, and includes firmware upgrade capability and sysfs integration.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/b=
ridge/lontium-lt9611c.c
> index 0000000000000..148da2bf5648e
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> @@ -0,0 +1,1283 @@

[ ... ]

> +static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
> +{
> +	struct lt9611c *lt9611c =3D dev_id;
> +	struct device *dev =3D lt9611c->dev;
> +	int ret;
> +	unsigned int irq_status;
> +
> +	guard(mutex)(&lt9611c->mcu_lock);
> +
> +	ret =3D regmap_read(lt9611c->regmap, 0xe084, &irq_status);
> +	if (ret) {
> +		dev_err(dev, "failed to read irq status: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (!(irq_status & BIT(0)))
> +		return IRQ_NONE;
> +
> +	/*Clear interrupt: hardware requires two writes with delay*/
> +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & BIT(0));
> +	usleep_range(10000, 12000);
> +	regmap_write(lt9611c->regmap, 0xe0df, irq_status & (~BIT(0)));

[Severity: Medium]
Could this sequence leave other active interrupts stuck in the clear state?

If irq_status contains other active interrupts (for example, bit 1 is set),
the second write will write a 1 to those bits. Since there is no subsequent
write of 0 to clear them, this appears to leave them permanently asserted.

> +
> +	schedule_work(&lt9611c->work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void lt9611c_hpd_work(struct work_struct *work)
> +{
> +	struct lt9611c *lt9611c =3D container_of(work, struct lt9611c, work);
> +	struct device *dev =3D lt9611c->dev;
> +	static const u8 hpd_data[] =3D { 0x00 };
> +	struct lt9611c_cmd cmd =3D {
> +		.hdr =3D { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x31, LT9611C_CMD_SEP=
 },
> +		.data =3D hpd_data,
> +		.data_len =3D 1,
> +	};
> +	u8 hpd_status;
> +	struct lt9611c_rsp rsp =3D { .data =3D &hpd_status, .data_len =3D 1 };

[Severity: High]
Will this ever read the actual HPD status payload?

As demonstrated by lt9611c_get_edid_block(), the LT9611C chip's read protoc=
ol
echoes the subcommand index byte (Y0) as the first byte of the response.
Because data_len is set to 1, the driver will only read this echo byte (0x0=
0)
instead of the actual HPD status in the second byte, causing hpd_status to
always evaluate to false.

This same pattern also appears in lt9611c_bridge_detect().

[ ... ]

> +static ssize_t firmware_show(struct device *dev, struct device_attribute=
 *attr, char *buf)
> +{
> +	struct lt9611c *lt9611c =3D dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "0x%04x\n", lt9611c->fw_version);

[Severity: High]
Can this result in a NULL pointer dereference?

Since the sysfs files are registered via lt9611c_driver.driver.dev_groups,
the driver core creates these groups before calling the probe() function.
However, i2c_set_clientdata() is only called at the very end of probe().

If a user accesses this sysfs file during the initialization window,
dev_get_drvdata() will return NULL, which is immediately dereferenced here.

> +}
> +
> +static DEVICE_ATTR_RW(firmware);

[ ... ]

> +static int lt9611c_probe(struct i2c_client *client)
> +{
> +	struct lt9611c *lt9611c;
> +	struct device *dev =3D &client->dev;
> +	bool fw_updated =3D false;
> +	int ret;
> +
> +	crc8_populate_msb(lt9611c_crc8_table, LT9611C_CRC_POLYNOMIAL);

[Severity: Medium]
Is it safe to unconditionally initialize the global lt9611c_crc8_table here?

If multiple LT9611C devices probe concurrently on different CPUs, this
will result in multiple threads writing to the same global array
simultaneously without synchronization.

> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return dev_err_probe(dev, -ENODEV, "device doesn't support I2C\n");

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-lt9611c-v7=
-v11-0-eb4a79cb597c@oss.qualcomm.com?part=3D2
