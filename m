Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E72EC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4859210E647;
	Tue,  4 Aug 2026 04:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bj74eKjs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E1210E647
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 04:26:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B83E2600AE;
 Tue,  4 Aug 2026 04:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8B81F00A3A;
 Tue,  4 Aug 2026 04:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785817586;
 bh=pXSBbb1WvPsZsDWyET2RSIQbypHdm+UROrygwL/BMXM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bj74eKjsehq7+mmwM8eB6dfmKKOm0/8gic19G1BrptLZGoifS95cq2jN9z0XAF/e4
 +06HCn2XQcfroipYQrUIaJtjPKPcUAVWI8FpnMyuXPzK3HB9M525OaDubEUy8+btKZ
 066oPN15OxSFAx2l0foJbnuybNS9Mvyaz9UL4ioVpzej3sxr6sglswGuBYFoxZfmVD
 pDHBiJ4skARpxLv4CpGAVz2iiGcffULUEBE2sTppjSZgA8Fd8um/bxLp7loGI8J3da
 bTaeajQwgm2JAGDIDbJb0TSX6EkYAgZ8Oi/687dYdIrHotgGmkN/TceZoIMAZ213k6
 BKbWD3ldQoPXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] backlight: aw99706: Validate all DT property
 values consistently
To: "Junjie Cao" <junjie.cao@linux.dev>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260803141310.1379194-3-junjie.cao@linux.dev>
References: <20260803141310.1379194-1-junjie.cao@linux.dev>
 <20260803141310.1379194-3-junjie.cao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 04:26:25 +0000
Message-Id: <20260804042626.3B8B81F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] The driver attempts to communicate with the hardware via I2C befor=
e obtaining and asserting the hardware enable GPIO, which will cause probe =
to fail if the device is not powered on by default.
- [High] The driver never applies the initial brightness state to the hardw=
are during probe, leaving the backlight hardware off or in an undefined sta=
te until userspace explicitly updates it.
--

--- Patch [2]: [PATCH v2 2/3] backlight: aw99706: Validate all DT property =
values consistently ---
commit 7ade0b3839909ff086334534c2c53128a09d10da
Author: Junjie Cao <junjie.cao@linux.dev>

backlight: aw99706: Validate all DT property values consistently

The lookup helpers for dim-mode and ramp-ctl accept any u32 value without
range-checking when lookup_tbl is NULL. This adds a field-width check for
the NULL-table case to reject out-of-range values. It also switches the
error returns to -EINVAL for consistency.

> diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/=
aw99706.c
> index e130f164303a2..dfb4b38b5b4c7 100644
> --- a/drivers/video/backlight/aw99706.c
> +++ b/drivers/video/backlight/aw99706.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed that probe might fail if the
hardware is not already powered on.

drivers/video/backlight/aw99706.c:aw99706_probe() {
    ...
	ret =3D aw99706_chip_id_read(aw);
	if (ret !=3D AW99706_ID)
		return dev_err_probe(dev, -ENODEV,
				     "Unknown chip id 0x%02x\n", ret);

	aw99706_dt_parse(aw, &props);

	aw->hwen_gpio =3D devm_gpiod_get(aw->dev, "enable", GPIOD_OUT_LOW);
    ...
}

Will the chip ID read fail here if the bootloader left the hardware enable
GPIO deactivated? Since the enable GPIO isn't requested and asserted until
after the I2C read, the I2C communication could timeout or fail.

[Severity: High]
This is a pre-existing issue, but it looks like the initial brightness state
is never pushed to the hardware during probe.

drivers/video/backlight/aw99706.c:aw99706_probe() {
    ...
	bl_dev =3D devm_backlight_device_register(dev, "aw99706-backlight", dev,
						aw, &aw99706_bl_ops, &props);
	if (IS_ERR(bl_dev))
		return dev_err_probe(dev, PTR_ERR(bl_dev),
				     "Failed to register backlight!\n");

	aw->bl_dev =3D bl_dev;

	return 0;
}

Since devm_gpiod_get(..., GPIOD_OUT_LOW) actively toggles the hardware enab=
le
pin (resetting the hardware) and backlight_update_status() is never called
after devm_backlight_device_register(), will this leave the backlight off
until userspace explicitly updates it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803141310.1379=
194-1-junjie.cao@linux.dev?part=3D2
