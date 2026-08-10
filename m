Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C28EC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0D510E201;
	Mon, 10 Aug 2026 11:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DP5/kCLr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7AA510E201
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 11:33:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD4FB600DA;
 Mon, 10 Aug 2026 11:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8A31F000E9;
 Mon, 10 Aug 2026 11:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786361618;
 bh=hvV4eHEb4kE7ggGIwsUxzLO9pYuYceTZB7NYAKgOanQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DP5/kCLroub3+UdkErD4bO1rE8X7qHsRIKxtzuw/z8eJvodD9FC/L/IQcbf9Av3gx
 ef5DsPAmRYXEL+UScKx91q6mxNWZ8p+1Q02L5/IIrkNyZVHkQMOhYX93shtcALECQA
 4l+DNFmcGuePKJ9RrZTlZTtyC7Cny7VCbglzPoRJHXOCDtRyaPsP3qs4FFXqBz3DeE
 uAiGN4Iz7GrmCGOOmBWcMRf/o3iF8Sg2Ms0lzU8VDou1WqyrOjJcWBR4mQ1unY1zqj
 x9KRy/OMgNM+7BqAZY6BFLDrvfYTyOvFvlpSZmeop06vC2K2DjMnZyQPdjR1WN4Ghe
 0IwOorTKAoJCg==
Date: Mon, 10 Aug 2026 12:33:33 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <anm3DY86P_TGxj3a@aspen.lan>
References: <20260806201541.101304-1-wf@dewith.io>
 <20260806201541.101304-3-wf@dewith.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806201541.101304-3-wf@dewith.io>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Aug 06, 2026 at 10:15:41PM +0200, Wim de With wrote:
> diff --git a/drivers/video/backlight/ocp8178_bl.c b/drivers/video/backlight/ocp8178_bl.c

Without repeating Uwe's review...


> new file mode 100644
> index 0000000000000..4500c9d23f7ef
> --- /dev/null
> +++ b/drivers/video/backlight/ocp8178_bl.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Orient Chip OCP8178 Backlight Driver
> + *
> + * Copyright (C) 2026 Wim de With
> + *
> + * Author: Wim de With <wf@dewith.io>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/irqflags.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +#define OCP8178_MAX_BRIGHTNESS 0x1F /* 5 bits */
> +
> +#define OCP8178_DEVICE_ADDRESS 0x72
> +
> +/*
> + * We cannot set RFA (request for acknowledge) unless the GPIO pin is
> + * configured as open drain.
> + */
> +#define OCP8178_DATA_RFA BIT(7)
> +#define OCP8178_DATA_ADDR GENMASK(6, 5)
> +#define OCP8178_DATA_VALUE GENMASK(4, 0)
> +
> +#define OCP8178_1W_INIT_MAX_RETRIES 5
> +#define OCP8178_1W_INIT_SLEEP_MS 50
> +
> +#define OCP8178_T_OFF_MS 3 /* datasheet specifies at least 2.5 ms */
> +#define OCP8178_1W_T_DELAY_US (100 + 10) /* 10 us as safety factor */
> +#define OCP8178_1W_T_DETECT_US (260 + 10) /* 10 us as safety factor */
> +#define OCP8178_1W_T_START_US 2
> +#define OCP8178_1W_T_EOS_US 2
> +#define OCP8178_1W_T_WIN_NS (1000 * 1000)
> +
> +/*
> + * The datasheet specifies 1.7 Kbps to 160 Kbps.
> + * 1 / (160 Kbps) is about 6.67 us, so using 7 us per bit should be fine.
> + * T_HIGH + T_LOW = 7 us
> + * T_HIGH > 2 * T_LOW for high bits
> + * T_LOW > 2 * T_HIGH for low bits
> + */
> +#define OCP8178_1W_HIGH_BIT_T_LOW_US 2
> +#define OCP8178_1W_HIGH_BIT_T_HIGH_US 5
> +#define OCP8178_1W_LOW_BIT_T_LOW_US 5
> +#define OCP8178_1W_LOW_BIT_T_HIGH_US 2
> +
> +struct ocp8178_bl {
> +	struct device *dev;
> +	struct gpio_desc *gpiod;
> +};
> +
> +static int ocp8178_bl_enable_onewire(struct ocp8178_bl *ocp8178)
> +{
> +	u64 start, duration;
> +
> +	dev_dbg(ocp8178->dev, "enabling onewire protocol\n");
> +
> +	gpiod_set_value_cansleep(ocp8178->gpiod, 0);
> +	msleep(OCP8178_T_OFF_MS);
> +
> +	start = ktime_get_ns();
> +
> +	gpiod_set_value(ocp8178->gpiod, 1);
> +	udelay(OCP8178_1W_T_DELAY_US);
> +	gpiod_set_value(ocp8178->gpiod, 0);
> +	udelay(OCP8178_1W_T_DETECT_US);
> +	gpiod_set_value(ocp8178->gpiod, 1);
> +
> +	duration = ktime_get_ns() - start;
> +
> +	if (duration >= OCP8178_1W_T_WIN_NS) {
> +		dev_err(ocp8178->dev,
> +			"onewire detection window exceeded (%llu ns)\n",
> +			duration);
> +		return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ocp8178_bl_write_u8(struct ocp8178_bl *ocp8178, u8 value)
> +{
> +	unsigned long flags;
> +
> +	gpiod_set_value(ocp8178->gpiod, 1);
> +	udelay(OCP8178_1W_T_START_US);
> +
> +	local_irq_save(flags);
> +
> +	for (int i = 7; i >= 0; i--) {
> +		if ((value >> i) & 1) {
> +			gpiod_set_value(ocp8178->gpiod, 0);
> +			udelay(OCP8178_1W_HIGH_BIT_T_LOW_US);
> +			gpiod_set_value(ocp8178->gpiod, 1);
> +			udelay(OCP8178_1W_HIGH_BIT_T_HIGH_US);
> +		} else {
> +			gpiod_set_value(ocp8178->gpiod, 0);
> +			udelay(OCP8178_1W_LOW_BIT_T_LOW_US);
> +			gpiod_set_value(ocp8178->gpiod, 1);
> +			udelay(OCP8178_1W_LOW_BIT_T_HIGH_US);
> +		}
> +	}
> +
> +	gpiod_set_value(ocp8178->gpiod, 0);
> +
> +	local_irq_restore(flags);
> +
> +	udelay(OCP8178_1W_T_EOS_US);

Given this happens after we restore local irqs this should probably be
fsleep().


> +	gpiod_set_value(ocp8178->gpiod, 1);
> +}
> +
> +static void ocp8178_bl_set_brightness(struct ocp8178_bl *ocp8178, u8 brightness)
> +{
> +	u8 data = 0;
> +
> +	dev_dbg(ocp8178->dev, "setting brightness to %u\n", brightness);

Do we really need the dev_dbg() here?


> +
> +	data |= FIELD_PREP(OCP8178_DATA_ADDR, 0);
> +	data |= FIELD_PREP(OCP8178_DATA_VALUE, brightness);
> +
> +	ocp8178_bl_write_u8(ocp8178, OCP8178_DEVICE_ADDRESS);
> +	ocp8178_bl_write_u8(ocp8178, data);
> +}
> +
> +static int ocp8178_bl_update_status(struct backlight_device *bl)
> +{
> +	struct ocp8178_bl *ocp8178 = bl_get_data(bl);
> +	u8 brightness = backlight_get_brightness(bl);
> +
> +	/*
> +	 * Setting brightness to 0 turns the backlight off but retains the
> +	 * onewire mode. If we disable the controller, we would need to enable
> +	 * the onewire mode again.
> +	 */
> +	if (backlight_is_blank(bl))
> +		brightness = 0;

This is not needed. It will happen inside backlight_get_brightness().


> +
> +	ocp8178_bl_set_brightness(ocp8178, brightness);
> +	return 0;
> +}
> +
> +static const struct backlight_ops ocp8178_bl_ops = {
> +	.options	= BL_CORE_SUSPENDRESUME,
> +	.update_status	= ocp8178_bl_update_status,
> +};
> +
> +static int ocp8178_bl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct backlight_device *bl;
> +	struct backlight_properties props;
> +	struct ocp8178_bl *ocp8178;
> +	u32 max_brightness, brightness;
> +	int ret, retries;
> +
> +	ocp8178 = devm_kzalloc(dev, sizeof(*ocp8178), GFP_KERNEL);
> +	if (!ocp8178)
> +		return -ENOMEM;
> +
> +	ocp8178->dev = dev;
> +
> +	ret = device_property_read_u32(dev, "max-brightness", &max_brightness);
> +	if (ret)
> +		max_brightness = OCP8178_MAX_BRIGHTNESS;
> +	if (max_brightness > OCP8178_MAX_BRIGHTNESS) {
> +		dev_warn(dev, "max brightness exceeds hardware limit\n");
> +		max_brightness = OCP8178_MAX_BRIGHTNESS;
> +	}
> +
> +	ret = device_property_read_u32(dev, "default-brightness", &brightness);
> +	if (ret)
> +		brightness = max_brightness;
> +	if (brightness > max_brightness) {
> +		dev_warn(dev, "default brightness exceeds max brightness\n");
> +		brightness = max_brightness;
> +	}
> +
> +	ocp8178->gpiod = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(ocp8178->gpiod))
> +		return dev_err_probe(dev, PTR_ERR(ocp8178->gpiod),
> +				     "gpio missing or invalid\n");
> +	gpiod_set_consumer_name(ocp8178->gpiod, dev_name(dev));
> +
> +	for (retries = 0; retries < OCP8178_1W_INIT_MAX_RETRIES; retries++) {
> +		ret = ocp8178_bl_enable_onewire(ocp8178);
> +		if (!ret)
> +			break;
> +		if (ret != -EAGAIN)
> +			return ret;
> +		msleep(OCP8178_1W_INIT_SLEEP_MS);

fsleep()?


> +	}
> +	if (retries >= OCP8178_1W_INIT_MAX_RETRIES)
> +		return dev_err_probe(dev, -ETIMEDOUT,
> +				     "failed to initialize onewire protocol");
> +
> +	props = (typeof(props)){
> +		.type		= BACKLIGHT_RAW,
> +		.brightness	= brightness,
> +		.max_brightness = max_brightness,
> +		.power		= BACKLIGHT_POWER_ON,
> +		.scale		= BACKLIGHT_SCALE_NON_LINEAR,
> +	};
> +
> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ocp8178,
> +					    &ocp8178_bl_ops, &props);
> +	if (IS_ERR(bl))
> +		return dev_err_probe(dev, PTR_ERR(bl),
> +				     "failed to register backlight\n");
> +
> +	platform_set_drvdata(pdev, bl);
> +	backlight_update_status(bl);
> +
> +	dev_info(dev, "probed, brightness=%u/%u\n", brightness, max_brightness);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ocp8178_bl_of_match[] = {
> +	{ .compatible = "ocs,ocp8178" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ocp8178_bl_of_match);
> +
> +static struct platform_driver ocp8178_bl_driver = {
> +	.driver		= {
> +		.name		= "ocp8178-bl",
> +		.of_match_table	= ocp8178_bl_of_match,
> +	},
> +	.probe		= ocp8178_bl_probe,
> +};

I'm with Uwe on the indentation here. No padding needed after the
= IMHO.


Daniel.
