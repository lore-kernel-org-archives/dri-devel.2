Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68919C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A08F410E53E;
	Tue,  4 Aug 2026 04:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WGwEyWWa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE67410E53E
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 04:23:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90B7340106;
 Tue,  4 Aug 2026 04:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA921F000E9;
 Tue,  4 Aug 2026 04:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785817418;
 bh=PYTJtFjJtERzTTlZBn5ixKjxVY9QAibf93e9MUXOT0I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WGwEyWWah84geYju64Ox7o3z1NM5c9DA5mkUx4G63ComPrvXNb8u5wdO7iOGsZ4ky
 TFv9tf8AWTYW6CWCdM/b3/0omIvVjSFu1NRiGeusfbaBneh6ovye4vkX/UIl68TTrm
 x1sc3LdUCOaEIW8s/VgkpkEl5hBKCTjh9eXKVQWCnOSgZ+/Cof8aSlVAgUMioI+bmM
 YsgtVxaSfDIemIMuDls7b9mPUATEiXBPgOw4cBxgQTeMYZwt8PnTGxJrK4OnqJ+twF
 L4T/rTQaKDR6c0ROq6rWiWm5aSjdpAwNxLS+rbrOAV6P5f5leZlfGa5Sw/TdMsJoDH
 0kTOTMJ371+Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] backlight: aw99706: Fix DT property names to
 match binding
To: "Junjie Cao" <junjie.cao@linux.dev>
Cc: lee@kernel.org, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org
In-Reply-To: <20260803141310.1379194-2-junjie.cao@linux.dev>
References: <20260803141310.1379194-1-junjie.cao@linux.dev>
 <20260803141310.1379194-2-junjie.cao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 04:23:37 +0000
Message-Id: <20260804042338.3CA921F000E9@smtp.kernel.org>
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
- [High] The driver attempts to read the chip ID via I2C before the hardwar=
e enable GPIO is acquired and asserted.
- [High] Negative error codes from `aw99706_chip_id_read` are masked and im=
properly formatted, breaking probe deferral.
--

--- Patch [1]: [PATCH v2 1/3] backlight: aw99706: Fix DT property names to =
match binding ---
commit 9d2f2e8b6d2445c40c8f872abafa26c81384bf67
Author: Junjie Cao <junjie.cao@linux.dev>

backlight: aw99706: Fix DT property names to match binding

The driver reads four tuning properties without the unit suffixes that the
binding mandates. This commit fixes the issue by aligning the property name
strings in aw99706_dt_props[] with the binding.

> diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/=
aw99706.c
> index 18299faf06ad4..e130f164303a2 100644
> --- a/drivers/video/backlight/aw99706.c
> +++ b/drivers/video/backlight/aw99706.c
> @@ -130,23 +130,23 @@ static const struct aw99706_dt_prop aw99706_dt_prop=
s[] =3D {
>  		AW99706_CFG0_REG, AW99706_DIM_MODE_MASK, 1,
>  	},
>  	{
> -		"awinic,sw-freq", aw99706_dt_property_lookup,
> +		"awinic,sw-freq-hz", aw99706_dt_property_lookup,
>  		aw99706_sw_freq_tbl, ARRAY_SIZE(aw99706_sw_freq_tbl),
>  		AW99706_CFG1_REG, AW99706_SW_FREQ_MASK, 750000,
>  	},
>  	{
> -		"awinic,sw-ilmt", aw99706_dt_property_lookup,
> +		"awinic,sw-ilmt-microamp", aw99706_dt_property_lookup,
>  		aw99706_sw_ilmt_tbl, ARRAY_SIZE(aw99706_sw_ilmt_tbl),
>  		AW99706_CFG1_REG, AW99706_SW_ILMT_MASK, 3000000,
>  	},
>  	{
> -		"awinic,iled-max", aw99706_dt_property_iled_max_convert,
> +		"awinic,iled-max-microamp", aw99706_dt_property_iled_max_convert,
>  		NULL, 0,
>  		AW99706_CFG2_REG, AW99706_ILED_MAX_MASK, 20000,
> =20
>  	},
>  	{
> -		"awinic,uvlo-thres", aw99706_dt_property_lookup,
> +		"awinic,uvlo-thres-microvolt", aw99706_dt_property_lookup,
>  		aw99706_ulvo_thres_tbl, ARRAY_SIZE(aw99706_ulvo_thres_tbl),
>  		AW99706_CFG2_REG, AW99706_UVLOSEL_MASK, 2200000,
>  	},

[Severity: High]
This isn't a bug introduced by this patch, but does the probe function atte=
mpt
to read the chip ID via I2C before the hardware enable GPIO is acquired and
asserted?

Looking at aw99706_probe() in drivers/video/backlight/aw99706.c:

	ret =3D aw99706_chip_id_read(aw);
	if (ret !=3D AW99706_ID)
		return dev_err_probe(dev, -ENODEV,
				     "Unknown chip id 0x%02x\n", ret);

	aw99706_dt_parse(aw, &props);

	aw->hwen_gpio =3D devm_gpiod_get(aw->dev, "enable", GPIOD_OUT_LOW);

Since the hardware enable GPIO is only requested and asserted later in the
probe sequence, if the bootloader hasn't pre-enabled the hardware, the chip
will remain powered off or in reset during the earlier I2C read. This would
cause the probe function to fail to read the chip ID and abort.

[Severity: High]
This is a pre-existing issue, but does this sequence mask negative error co=
des
from aw99706_chip_id_read()?

Looking at the chip ID verification in aw99706_probe():

	ret =3D aw99706_chip_id_read(aw);
	if (ret !=3D AW99706_ID)
		return dev_err_probe(dev, -ENODEV,
				     "Unknown chip id 0x%02x\n", ret);

If the I2C controller or bus is not yet ready, it could return -EPROBE_DEFE=
R,
which is then replaced with -ENODEV. This would break the kernel's probe
deferral mechanism and cause a permanent probe failure. It also prints the
negative integer using %02x, which emits a two's complement hexadecimal val=
ue
instead of a clear error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803141310.1379=
194-1-junjie.cao@linux.dev?part=3D1
