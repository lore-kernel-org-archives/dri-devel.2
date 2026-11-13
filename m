Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41EC606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K63W5CrJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A0010E4D5;
	Fri, 13 Nov 2026 14:53:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5651310E7A3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:53:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E74C419A6;
 Fri, 13 Nov 2026 14:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEB61F000C4;
 Fri, 13 Nov 2026 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794581616;
 bh=J1fkTTthpSMnWf73EpC1C3Nkug0WjqfNB0G0R1Twl38=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K63W5CrJIX9LO8OBbhPZdTvrgkakrsEgTDcJLhEU9e3bRIUHyQU3CmwJhSD1mdSrh
 94spflQyvlPaPa9rMcnFj+CnbOWoNauEcSk7dI6V+GuzrghAnsIl7I+93KKpPPRfEI
 YSFQin+bzy834BqU+S/NysJ1MpdWQBBeyaK0skhJc8MzHHuCz6fRrWYf0Yd9DCWTVE
 JxiMFkW8qcaDknFDNEwwIga/CQ+D2RN7fnp4zYUpH9WpvvOweipJyE1wocar/HWNNs
 kQ/zm8tvTzNBPGm6DZJ+1bVwo5ZYQ+JT08qpjtJv1FOSy69ja4cUA99WnNzhdXXVMT
 va6JiIn6WU9OA==
Date: Fri, 13 Nov 2026 14:53:32 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Griffin Kroah-Hartman <griffin@kroah.com>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1] video: leds: backlight: lm3533: Support getting LED
 sources from DT
Message-ID: <179370032880.793788.4424159880220279586@kernel.org>
References: <20261101142435.130520-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101142435.130520-1-clamor95@gmail.com>
X-AI-Review-Draft: <20261101142435.130520-1-clamor95@gmail.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drop the 'video: ' part of the subject line.

Please review, explain or fix the Sashiko review(s).

> Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> defined in the device tree.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
> ---
> This was part of the original LM3533 controller DT/OF conversion patchset,
> but it appears to have been accidentally separated during the final iteration.
> Therefore, I am sending it as a follow-up.
> ---
>  drivers/leds/leds-lm3533.c          | 60 +++++++++++++++++++++++++++++
>  drivers/video/backlight/lm3533_bl.c | 45 ++++++++++++++++++++++

Why are these being bundled up?

What is the dependency?  If none, please separate.

>  2 files changed, 105 insertions(+)
>
> diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
> index 7259097bd6a71..a1aeff70a90fc 100644
> --- a/drivers/leds/leds-lm3533.c
> +++ b/drivers/leds/leds-lm3533.c
> @@ -26,6 +26,11 @@
>  #define LM3533_ALS_CHANNEL_LV_MIN	1
>  #define LM3533_ALS_CHANNEL_LV_MAX	2
>
> +#define LM3533_REG_OUTPUT_CONF1			0x10
> +#define   OUTPUT_CONF1_SHIFT			2
> +#define   OUTPUT_LVLED_MASK			0x3
> +#define LM3533_REG_OUTPUT_CONF2			0x11
> +#define   OUTPUT_CONF2_SHIFT			6
>  #define LM3533_REG_CTRLBANK_BCONF_BASE		0x1b
>  #define LM3533_REG_PATTERN_ENABLE		0x28
>  #define LM3533_REG_PATTERN_LOW_TIME_BASE	0x71
> @@ -54,6 +59,9 @@ struct lm3533_led {
>  	u32 max_current;
>  	u32 pwm;
>
> +	int num_leds;
> +	u32 leds[LM3533_LVCTRLBANK_MAX];
> +
>  	bool have_als;
>  };
>
> @@ -622,8 +630,36 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
>
>  static int lm3533_led_setup(struct lm3533_led *led)
>  {
> +	u32 output_cfg_shift = 0;
> +	u32 output_cfg_val = 0;
> +	u32 output_cfg_mask = 0;
>  	int ret;
>
> +	if (led->num_leds) {
> +		for (int i = 0; i < led->num_leds; i++) {
> +			if (led->leds[i] >= LM3533_LVCTRLBANK_MAX)
> +				continue;
> +
> +			output_cfg_shift = led->leds[i] * 2;
> +			output_cfg_val |= led->id << output_cfg_shift;
> +			output_cfg_mask |= OUTPUT_LVLED_MASK << output_cfg_shift;
> +		}
> +
> +		/* LVLED1, LVLED2 and LVLED3 */
> +		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF1,
> +					 output_cfg_mask << OUTPUT_CONF1_SHIFT,
> +					 output_cfg_val << OUTPUT_CONF1_SHIFT);
> +		if (ret)
> +			return ret;
> +
> +		/* LVLED4 and LVLED5 */
> +		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF2,
> +					 output_cfg_mask >> OUTPUT_CONF2_SHIFT,
> +					 output_cfg_val >> OUTPUT_CONF2_SHIFT);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
>  	if (ret)
>  		return ret;
> @@ -698,6 +734,30 @@ static int lm3533_led_probe(struct platform_device *pdev)
>
>  	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
>
> +	/*
> +	 * If led-sources property is not set then either this Control Bank uses
> +	 * its default LVLED or is not linked to any LVLED at all.
> +	 */
> +	led->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
> +	if (led->num_leds > LM3533_LVCTRLBANK_MAX) {
> +		dev_err(&pdev->dev, "num of LED sources exceeds max %d: %d\n",

"Number "

> +			LM3533_LVCTRLBANK_MAX, led->num_leds);
> +		ret = -EINVAL;
> +		goto err_deregister;
> +	}

Could we move the 'led-sources' parsing above led_classdev_register(),
or convert the driver to devm_led_classdev_register() and use 'return
dev_err_probe()' here?

> +	if (led->num_leds < 0)
> +		led->num_leds = 0;
> +
> +	if (led->num_leds > 0) {
> +		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
> +						     led->leds, led->num_leds);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to get led-sources\n");
> +			goto err_deregister;
> +		}

dev_err_probe()

> +	}
> +
>  	ret = lm3533_led_setup(led);
>  	if (ret)
>  		goto err_deregister;
> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> index adcd6ac7cf229..e8164c8528577 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -7,6 +7,7 @@
>   * Author: Johan Hovold <jhovold@gmail.com>
>   */
>
> +#include <linux/bits.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> @@ -21,6 +22,7 @@
>  #define LM3533_HVCTRLBANK_COUNT		2
>  #define LM3533_BL_MAX_BRIGHTNESS	255
>
> +#define LM3533_REG_OUTPUT_CONF1		0x10
>  #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
>  #define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
>  #define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
> @@ -35,6 +37,9 @@ struct lm3533_bl {
>  	u32 max_current;
>  	u32 pwm;
>
> +	int num_leds;
> +	u32 led_strings[LM3533_HVCTRLBANK_COUNT];
> +
>  	bool have_als;
>  	bool linear;
>  };
> @@ -236,6 +241,8 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
>  static int lm3533_bl_setup(struct lm3533_bl *bl)
>  {
>  	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
> +	u32 output_cfg_val = 0;
> +	u32 output_cfg_mask = 0;
>  	int ret;
>
>  	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
> @@ -243,6 +250,21 @@ static int lm3533_bl_setup(struct lm3533_bl *bl)
>  	if (ret)
>  		return ret;
>
> +	if (bl->num_leds) {
> +		for (int i = 0; i < bl->num_leds; i++) {
> +			if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
> +				continue;
> +
> +			output_cfg_val |= ctrlbank << bl->led_strings[i];
> +			output_cfg_mask |= BIT(bl->led_strings[i]);
> +		}

This for loop doesn't need to be in the if statement.

> +		ret = regmap_update_bits(bl->regmap, LM3533_REG_OUTPUT_CONF1,
> +					 output_cfg_mask, output_cfg_val);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
>  	if (ret)
>  		return ret;
> @@ -320,6 +342,29 @@ static int lm3533_bl_probe(struct platform_device *pdev)
>
>  	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
>
> +	/*
> +	 * If led-sources property is not set then either this Control Bank uses
> +	 * its default HVLED or is not linked to any HVLED at all.
> +	 */
> +	bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
> +	if (bl->num_leds > LM3533_HVCTRLBANK_COUNT) {
> +		dev_err(&pdev->dev, "num of LED sources %d exceeds max %d\n",
> +			bl->num_leds, LM3533_HVCTRLBANK_COUNT);
> +		return -EINVAL;
> +	}

dev_err_probe()

> +
> +	if (bl->num_leds < 0)
> +		bl->num_leds = 0;
> +
> +	if (bl->num_leds > 0) {
> +		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
> +						     bl->led_strings,
> +						     bl->num_leds);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "failed to get led-sources\n");
> +	}
> +
>  	ret = lm3533_bl_setup(bl);
>  	if (ret)
>  		return ret;
> -- 
> 2.53.0
>

-- 
Lee Jones
