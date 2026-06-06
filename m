Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAC5CD6E55
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D38810E230;
	Sat,  6 Jun 2026 05:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JaAazTYw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F9110E230
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 05:21:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E44140592;
 Sat,  6 Jun 2026 05:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0AD1F00893;
 Sat,  6 Jun 2026 05:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780723279;
 bh=XO29lp4DIKtLpHy11y3aMvZyk+ugcHbeFFI4txRjcMY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JaAazTYwVVuzx4fSXTWh9/BjDSppL84lNog9wG94phil+nPV59C8b7TLJj66Mq0VY
 6m9GqCvvCaGtAn55WeDkkv4t78YWK+4OQ/PnDOOiffrUWn/wfkbh1RGhY4T7pQjBjs
 ZW5IYBtFm9mJLtfxYlmHf80DZNK3xYx4ZeYLZjnpuPKKEeQbsMp4zi1nlhAI37Bm9R
 sx+aTkGRVoaDuGxJWQ+1TnomwxqruusXHOCU4euVAAz49hJ7cWugR/p/8Qlv0Ykljn
 6BwAtYI2FZVxbUql9wnuP0GLMrGO60pF0zEowOT4Sly7dv0BnnBCFagC091wphn7MH
 /Ablb9lbP86bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/14] video: leds: backlight: lm3533: Support
 getting LED sources from DT
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260606045738.21050-15-clamor95@gmail.com>
References: <20260606045738.21050-15-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 05:21:18 +0000
Message-Id: <20260606052118.EE0AD1F00893@smtp.kernel.org>
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
- [High] Probe returns 0 on failure during LED sources validation, causing =
a double-free on removal.
- [High] Out-of-bounds bitmask calculation for LM3533_REG_OUTPUT_CONF1 corr=
upts regcache and causes probe failures on SMBus.
- [Medium] Probe returns a positive integer on failure, violating the drive=
r core API and generating an incorrect error code.
- [Low] Negative error codes from missing properties are evaluated as true,=
 causing redundant regmap operations.
--

commit a17954bc9b86db17d86986ace3623a64fc46dd3b
Author: Svyatoslav Ryhel <clamor95@gmail.com>

video: leds: backlight: lm3533: Support getting LED sources from DT
   =20
Add Control Bank to HVLED/LVLED muxing support based on the led-sources
defined in the device tree.

> diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
> index a661aedcdc60a..fe3e01b265e10 100644
> --- a/drivers/leds/leds-lm3533.c
> +++ b/drivers/leds/leds-lm3533.c
[ ... ]
> @@ -623,7 +631,35 @@ static const struct attribute_group *lm3533_led_attr=
ibute_groups[] =3D {
> =20
>  static int lm3533_led_setup(struct lm3533_led *led)
>  {
> -	int ret;
> +	u32 output_cfg_shift =3D 0;
> +	u32 output_cfg_val =3D 0;
> +	u32 output_cfg_mask =3D 0;
> +	int ret, i;
> +
> +	if (led->num_leds) {

[Severity: Low]
If the led-sources property is not present, device_property_count_u32()
returns a negative error code. Does this cause the condition to evaluate
to true, skipping the loop but triggering an unnecessary regmap_update_bits=
()
with a 0 mask?

> +		for (i =3D 0; i < led->num_leds; i++) {
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

[Severity: High]
For LVLED4 and LVLED5, output_cfg_mask could have bits 6 or 8 set. When
shifted left by OUTPUT_CONF1_SHIFT (2), the mask exceeds 8 bits. Since
LM3533_REG_OUTPUT_CONF1 is an 8-bit register, does this corrupt the regmap
cache or cause SMBus probe failures by passing a mask larger than 0xFF?

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
> @@ -700,6 +736,26 @@ static int lm3533_led_probe(struct platform_device *=
pdev)
>  	led->pwm =3D 0;
>  	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
> =20
> +	led->num_leds =3D device_property_count_u32(&pdev->dev, "led-sources");
> +	if (led->num_leds > LM3533_LVCTRLBANK_MAX) {
> +		dev_err(&pdev->dev, "num of LED sources exceeds max %d: %d\n",
> +			LM3533_LVCTRLBANK_MAX, led->num_leds);
> +		goto err_deregister;

[Severity: High]
Since led_classdev_register() was already called earlier in this function a=
nd
returned 0, ret is still 0 here. Will jumping to err_deregister return 0 on
failure, leading to a double-free on driver removal when
led_classdev_unregister() is called again and corrupting leds_list?

> +	}
[ ... ]
> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backligh=
t/lm3533_bl.c
> index 2aa4b86042ff2..ed358fb3c7596 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
[ ... ]
> @@ -232,13 +237,30 @@ static struct attribute_group lm3533_bl_attribute_g=
roup =3D {
>  static int lm3533_bl_setup(struct lm3533_bl *bl)
>  {
>  	int ctrlbank =3D lm3533_bl_get_ctrlbank_id(bl);
> -	int ret;
> +	u32 output_cfg_val =3D 0;
> +	u32 output_cfg_mask =3D 0;
> +	int ret, i;
> =20
>  	ret =3D regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
>  				 CTRLBANK_AB_BCONF_MODE(ctrlbank), bl->linear);
>  	if (ret)
>  		return ret;
> =20
> +	if (bl->num_leds) {

[Severity: Low]
Similar to lm3533_led_setup(), if the led-sources property is absent,
device_property_count_u32() returns a negative error code. Will this cause
the condition to evaluate to true and trigger an unnecessary I2C write with
a 0 mask?

> +		for (i =3D 0; i < bl->num_leds; i++) {
> +			if (bl->led_strings[i] >=3D LM3533_HVCTRLBANK_COUNT)
> +				continue;
[ ... ]
> @@ -316,6 +338,25 @@ static int lm3533_bl_probe(struct platform_device *p=
dev)
> =20
>  	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
> =20
> +	bl->num_leds =3D device_property_count_u32(&pdev->dev, "led-sources");
> +	if (bl->num_leds > LM3533_HVCTRLBANK_COUNT)
> +		return dev_err_probe(&pdev->dev, bl->num_leds,
> +				     "num of LED sources exceeds max %d\n",
> +				     LM3533_HVCTRLBANK_COUNT);

[Severity: Medium]
Because bl->num_leds is strictly positive here, does returning it via
dev_err_probe() violate the driver core API which expects a negative error
code? The driver core negates positive return values, which could result in=
 an
unrelated error code like -ESRCH.

> +
> +	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606045738.2105=
0-1-clamor95@gmail.com?part=3D14
