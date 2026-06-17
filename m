Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0980FCD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BED10EEBA;
	Wed, 17 Jun 2026 08:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T1BKapoV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E6F10EEBA
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:18:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 08FBB600B0;
 Wed, 17 Jun 2026 08:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9D21F00A3D;
 Wed, 17 Jun 2026 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781684305;
 bh=97ZJT/CCUoabnLTNLvjmKsXlThHvT5k3+GVud78Rjgk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T1BKapoV89Crdy2R10Muwnl3oU09W9arSCS3/c/4LJnKEDSEcFbLlvfPbJVOCkgkU
 P8OmiBFxoabF5uC/4ZpD8BvTWTbvWAf7udfC2cYwmtrhO+0WcwnnVhui6hxb7FBjmZ
 jJRtcso93FIm+TM4it2/GRi6oW8GUMHeZAkLqjlClgqDV0Oj/2IzXbvmVv1U1Edo2y
 vcFnEuT8peAC6aMbewKyM4MV1i6O/VHBXsEFlt+Ygebn/+lk1HtILhHFTBK3LUjDZq
 wVSFvqA/HphDyMtg3pkkA5XcZ77WErnrq7Wn0drrz2/Bp7iMBoJTpp49NbdB6edVxx
 GTydcx8doqnJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/14] video: leds: backlight: lm3533: Support
 getting LED sources from DT
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260617080031.99156-15-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-15-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 08:18:24 +0000
Message-Id: <20260617081825.6A9D21F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Out-of-bounds bitmask shift causes regcache pollution and unnecessa=
ry I2C bus writes for LM3533_REG_OUTPUT_CONF1.
--

commit a74553be2d2b60a05a193e9dc35527d3d4a425da
Author: Svyatoslav Ryhel <clamor95@gmail.com>

video: leds: backlight: lm3533: Support getting LED sources from DT

This commit adds Control Bank to HVLED/LVLED muxing support based on
the led-sources defined in the device tree.

> diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
> index ed810c23f30f3..9e07953814fdd 100644
> --- a/drivers/leds/leds-lm3533.c
> +++ b/drivers/leds/leds-lm3533.c

[ ... ]

> @@ -623,8 +631,36 @@ static const struct attribute_group *lm3533_led_attr=
ibute_groups[] =3D {
> =20
>  static int lm3533_led_setup(struct lm3533_led *led)
>  {
> +	u32 output_cfg_shift =3D 0;
> +	u32 output_cfg_val =3D 0;
> +	u32 output_cfg_mask =3D 0;
>  	int ret;
> =20
> +	if (led->num_leds) {
> +		for (int i =3D 0; i < led->num_leds; i++) {
> +			if (led->leds[i] >=3D LM3533_LVCTRLBANK_MAX)
> +				continue;
> +
> +			output_cfg_shift =3D led->leds[i] * 2;
> +			output_cfg_val |=3D led->id << output_cfg_shift;
> +			output_cfg_mask |=3D OUTPUT_LVLED_MASK << output_cfg_shift;
> +		}
> +
> +		/* LVLED1, LVLED2 and LVLED3 */
> +		ret =3D regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF1,
> +					 output_cfg_mask << OUTPUT_CONF1_SHIFT,
> +					 output_cfg_val << OUTPUT_CONF1_SHIFT);

[Severity: Low]
Can this shift cause bits to fall outside the 8-bit register width?

When led-sources specifies LVLED4 or LVLED5, output_cfg_mask accumulates
bits that, when shifted left by OUTPUT_CONF1_SHIFT (which is 2), will exceed
8 bits (for example, forming masks like 0x300 or 0xC00).

Because regmap_update_bits operates on unsigned int internally, these
out-of-bounds bits are applied to the cached register value. This causes
the internal comparison (tmp !=3D orig) to incorrectly evaluate to true,
triggering an unnecessary I2C write.

Although the I2C subsystem harmlessly truncates the value to 8 bits so the
hardware state is not corrupted, does it make sense to apply an explicit
8-bit mask (e.g., & 0xFF) before passing the shifted mask and value to
regmap_update_bits() to prevent regcache pollution and redundant bus traffi=
c?

> +		if (ret)
> +			return ret;
> +
> +		/* LVLED4 and LVLED5 */
> +		ret =3D regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF2,
> +					 output_cfg_mask >> OUTPUT_CONF2_SHIFT,
> +					 output_cfg_val >> OUTPUT_CONF2_SHIFT);
> +		if (ret)
> +			return ret;
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617080031.9915=
6-1-clamor95@gmail.com?part=3D14
