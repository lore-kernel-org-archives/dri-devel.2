Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22333C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 08:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6437110E0B6;
	Sat,  8 Aug 2026 08:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UB05PEDz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE94810E0B6
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 08:27:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E25E437E7;
 Sat,  8 Aug 2026 08:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127D91F000E9;
 Sat,  8 Aug 2026 08:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786177656;
 bh=bfQYD07G80iMm47omQSXfNz888c470ESmjnZlKV0sDk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UB05PEDzOUHEH0Ci21H9hG5VW6wg5O4vyydpk8hzthfTzmm4Dit4IpTswVUvre+B8
 A097hkF8LKVvHwmxOtDzHtZ4MJWYrBzmNA0AiJsi25xTlTMzT9FDmOvT11Whp6PXyK
 SKIZ8V5GvTpTnG1QO5O8joejJzf8HOAYQTadbgRCXTXv+CHp/Hg/YeHjY5/xFj51mz
 Wp3PTSAsDEFOfBo6ESxq0FO1JnAIl6SiMWOrXGn0bWIKT4NWNVwj+qRp1itxs1VT6h
 BxfyHHy3/U+xz+qtaSx6aDSG/z/sx4v6xV5fw0A/uBvNlqpIYO3y2gfKVktiPoBN3u
 Y+ADhvYbKsGfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
To: mohit.dsor@oss.qualcomm.com
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260808-lt9611c-v7-v10-2-ee90a136d82a@oss.qualcomm.com>
References: <20260808-lt9611c-v7-v10-0-ee90a136d82a@oss.qualcomm.com>
 <20260808-lt9611c-v7-v10-2-ee90a136d82a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 08:27:35 +0000
Message-Id: <20260808082736.127D91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Synchronous request_firmware() in probe() blocks kernel boot proce=
ss.
- [Medium] Unintended interrupt clearing and potential permanent disablemen=
t due to flawed bitwise logic in IRQ handler.
--

--- Patch [2]: [PATCH v10 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI=
 DSI to HDMI driver ---
commit 22bb13157654c71d5954095ae3d49cee54e072dd
Author: Sunyun Yang <syyang@lontium.com>
Subject: drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

This commit adds the driver for the Lontium LT9611C, LT9611EX, and
LT9611UXD MIPI DSI to HDMI bridge chips. It converts single or dual MIPI
DSI and I2S signals to HDMI 1.4 or 2.0 output.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/b=
ridge/lontium-lt9611c.c
> index 0000000000000..e6887f2c89a6c 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c

[ ... ]

> +static int lt9611c_firmware_upgrade(struct lt9611c *lt9611c)
> +{
> +	struct device *dev =3D lt9611c->dev;
> +	const struct firmware *fw;
> +	u8 *buffer;
> +	size_t total_size =3D FW_SIZE - 1;
> +	u8 fw_crc;
> +	int ret;
> +
> +	/* load firmware =E2=80=94 must happen outside the mcu_lock */
> +	ret =3D request_firmware(&fw, FW_FILE, dev);

[Severity: High]
Does this synchronous firmware load risk stalling the kernel boot process?

If the chip's firmware version reads as 0 during lt9611c_probe(), it
directly invokes lt9611c_firmware_upgrade(), triggering this synchronous
request_firmware() call.

If the firmware is not built-in or the root filesystem is not mounted
yet, this could block the I2C bus probe queue and delay boot for up to
60 seconds (the default loader timeout) or even cause a deadlock.

Could request_firmware_nowait() be used instead when triggered from
the probe path, or could the firmware update be deferred to a worker?

> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to load '%s'\n", FW_FILE);

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
Will this second write unintentionally assert the clear register for
other pending interrupts?

The handler attempts to clear BIT(0) by writing irq_status & BIT(0)
(which sets bit 0), waiting, and then writing irq_status & (~BIT(0)).
If irq_status contains any other active bits (for example, BIT(1)),
the second write will push a 1 to those bits in the clear register.

Since there is no subsequent write to reset those bits to 0, does
this leave the clear signal for those other interrupts permanently
asserted?

> +
> +	schedule_work(&lt9611c->work);
> +
> +	return IRQ_HANDLED;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808-lt9611c-v7=
-v10-0-ee90a136d82a@oss.qualcomm.com?part=3D2
