Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B80E7E37F
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 12:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0DE10E340;
	Fri,  3 Apr 2026 12:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DpMFor8c";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23C810E340
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 12:30:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D24260125
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 12:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E3AC19421
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775219425;
 bh=sOPOma5JvgHlPD8EHyYQ81EIK530Cc/jdeno4e8nfuA=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
 b=DpMFor8cI1LYDodeElPr7jO9CQYKRo4ViqX9CVGXZqf2J3yKh2EUqDCThBwZG3jhe
 gQ5QlYteTvi6uPeQNJCl/hIv4UiDsJhUpmuOAiH/vQ2iP6Grfa3LlPN+g9TUR+KcDg
 rfZfqGdqut8yrDgnXydpv/R2xKrFchPCG+TvxQGA072PHr2vBGqcE13YNX4VBOgcEu
 WsgVHHo96f2GRlj8gDG0Rm8dwavFEJB31Mi87J7MWqyD7i1CRKP/lCVt07VCw9rzp5
 705L+wMOqRrSsowNQkjUPrYFXBJDOfFWJaB7KS1GQAF1u/m9CdP7idXxD7KXbH8d4O
 jpfOZfPMydpdQ==
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-38dd5f28a4cso3478481fa.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 05:30:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YzGtXfRNm9cMG4gcsd3KBDpRPq3zrv5KYs5CMrrz2zOiU7DaEEq
 oehC9pQlMGOSM88RAt5s6rSyXqNjdalqYDn6AXIZy9SpwtYDSlH24SCKXsQEq5An5IM+jkUbsqU
 hc9bIbonfz128keLfOVNmFc0ifgLnjf5c1z+NI567Tg==
X-Received: by 2002:a2e:b8cc:0:b0:38a:c9f3:557c with SMTP id
 38308e7fff4ca-38d8d37c9fdmr8372031fa.4.1775219423794; Fri, 03 Apr 2026
 05:30:23 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Apr 2026 08:30:22 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Apr 2026 08:30:22 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-19-5e9119b5a014@oss.qualcomm.com>
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-19-5e9119b5a014@oss.qualcomm.com>
Date: Fri, 3 Apr 2026 08:30:22 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mcusnm-k76e6jTiwrw5xJL7f-nWBsg4=QpD08cv8pPgMw@mail.gmail.com>
X-Gm-Features: AQROBzBFOBsqk3csaKGEG_opTJgFQ4S2aNRzfCekYFtcmXKCuuraYlP8uaLIZPE
Message-ID: <CAMRc=Mcusnm-k76e6jTiwrw5xJL7f-nWBsg4=QpD08cv8pPgMw@mail.gmail.com>
Subject: Re: [PATCH 19/19] gpio: add GPIO controller found on Waveshare DSI
 TOUCH panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>, Jagan Teki <jagan@edgeble.ai>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 1 Apr 2026 09:26:38 +0200, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> said:
> The Waveshare DSI TOUCH family of panels has separate on-board GPIO
> controller, which controls power supplies to the panel and the touch
> screen and provides reset pins for both the panel and the touchscreen.
> Also it provides a simple PWM controller for panel backlight. Add
> support for this GPIO controller.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpio/Kconfig              |  10 ++
>  drivers/gpio/Makefile             |   1 +
>  drivers/gpio/gpio-waveshare-dsi.c | 220 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 231 insertions(+)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 4c3f6ec336c1..f0bb5cdebf9b 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -804,6 +804,16 @@ config GPIO_VISCONTI
>  	help
>  	  Say yes here to support GPIO on Tohisba Visconti.
>
> +config GPIO_WAVESHARE_DSI_TOUCH
> +	tristate "Waveshare GPIO controller for DSI panels"
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Enable support for the GPIO and PWM controller found on Waveshare DSI
> +	  TOUCH panel kits. It provides GPIOs (used for regulator control and
> +          resets) and backlight support.
> +
>  config GPIO_WCD934X
>  	tristate "Qualcomm Technologies Inc WCD9340/WCD9341 GPIO controller driver"
>  	depends on MFD_WCD934X
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 20d4a57afdaa..75ce89fc3b93 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -207,6 +207,7 @@ obj-$(CONFIG_GPIO_VIRTUSER)		+= gpio-virtuser.o
>  obj-$(CONFIG_GPIO_VIRTIO)		+= gpio-virtio.o
>  obj-$(CONFIG_GPIO_VISCONTI)		+= gpio-visconti.o
>  obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
> +obj-$(CONFIG_GPIO_WAVESHARE_DSI_TOUCH)	+= gpio-waveshare-dsi.o
>  obj-$(CONFIG_GPIO_WCD934X)		+= gpio-wcd934x.o
>  obj-$(CONFIG_GPIO_WHISKEY_COVE)		+= gpio-wcove.o
>  obj-$(CONFIG_GPIO_WINBOND)		+= gpio-winbond.o
> diff --git a/drivers/gpio/gpio-waveshare-dsi.c b/drivers/gpio/gpio-waveshare-dsi.c
> new file mode 100644
> index 000000000000..30fe7569c150
> --- /dev/null
> +++ b/drivers/gpio/gpio-waveshare-dsi.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Waveshare International Limited
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/err.h>
> +#include <linux/fb.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +/* I2C registers of the microcontroller. */
> +#define REG_TP		0x94
> +#define REG_LCD		0x95
> +#define REG_PWM		0x96
> +#define REG_SIZE	0x97
> +#define REG_ID		0x98
> +#define REG_VERSION	0x99
> +
> +enum {
> +	GPIO_AVDD = 0,
> +	GPIO_PANEL_RESET = 1,
> +	GPIO_BL_ENABLE = 2,
> +	GPIO_IOVCC = 4,
> +	GPIO_VCC = 8,
> +	GPIO_TS_RESET = 9,
> +	NUM_GPIO = 16,

Why is this part of an enum?

> +};
> +
> +struct waveshare_gpio {
> +	struct mutex dir_lock;
> +	struct mutex pwr_lock;
> +	struct regmap *regmap;
> +	u16 poweron_state;
> +
> +	struct gpio_chip gc;
> +};
> +
> +static const struct regmap_config waveshare_gpio_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = REG_PWM,
> +};
> +
> +static int waveshare_gpio_get(struct waveshare_gpio *state, unsigned int offset)
> +{
> +	u16 pwr_state;
> +
> +	mutex_lock(&state->pwr_lock);
> +	pwr_state = state->poweron_state & BIT(offset);
> +	mutex_unlock(&state->pwr_lock);
> +
> +	return !!pwr_state;
> +}
> +
> +static int waveshare_gpio_set(struct waveshare_gpio *state, unsigned int offset, int value)
> +{
> +	u16 last_val;
> +
> +	mutex_lock(&state->pwr_lock);

Can you use guards for locks?

> +
> +	last_val = state->poweron_state;
> +	if (value)
> +		last_val |= BIT(offset);
> +	else
> +		last_val &= ~BIT(offset);
> +
> +	state->poweron_state = last_val;
> +
> +	regmap_write(state->regmap, REG_TP, last_val >> 8);
> +	regmap_write(state->regmap, REG_LCD, last_val & 0xff);

I2C regmap writes can fail and their return value should be checked.

> +
> +	mutex_unlock(&state->pwr_lock);
> +
> +	return 0;
> +}
> +
> +static int waveshare_gpio_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
> +{
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static int waveshare_gpio_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct waveshare_gpio *state = gpiochip_get_data(gc);
> +
> +	return waveshare_gpio_get(state, offset);
> +}
> +
> +static int waveshare_gpio_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
> +{
> +	struct waveshare_gpio *state = gpiochip_get_data(gc);
> +
> +	return waveshare_gpio_set(state, offset, value);
> +}
> +
> +static int waveshare_gpio_update_status(struct backlight_device *bl)
> +{
> +	struct waveshare_gpio *state = bl_get_data(bl);
> +	int brightness = backlight_get_brightness(bl);
> +
> +	waveshare_gpio_set(state, GPIO_BL_ENABLE, brightness);
> +
> +	return regmap_write(state->regmap, REG_PWM, brightness);
> +}
> +
> +static const struct backlight_ops waveshare_gpio_bl = {
> +	.update_status = waveshare_gpio_update_status,
> +};
> +
> +static int waveshare_gpio_i2c_read(struct i2c_client *client, u8 reg, unsigned int *buf)
> +{
> +	int val;
> +
> +	val = i2c_smbus_read_byte_data(client, reg);
> +	if (val < 0)
> +		return val;
> +
> +	*buf = val;
> +
> +	return 0;
> +}
> +
> +static int waveshare_gpio_probe(struct i2c_client *i2c)
> +{
> +	struct backlight_properties props = {};
> +	struct waveshare_gpio *state;
> +	struct device *dev = &i2c->dev;
> +	struct backlight_device *bl;
> +	struct regmap *regmap;
> +	unsigned int data;
> +	int ret;
> +
> +	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return -ENOMEM;
> +
> +	ret = devm_mutex_init(dev, &state->dir_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_mutex_init(dev, &state->pwr_lock);
> +	if (ret)
> +		return ret;
> +
> +	i2c_set_clientdata(i2c, state);
> +
> +	regmap = devm_regmap_init_i2c(i2c, &waveshare_gpio_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to allocate register map\n");
> +
> +	ret = waveshare_gpio_i2c_read(i2c, REG_ID, &data);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to read register\n");
> +
> +	dev_dbg(dev, "waveshare panel hw id = 0x%x\n", data);
> +
> +	ret = waveshare_gpio_i2c_read(i2c, REG_SIZE, &data);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to read register\n");
> +
> +	dev_dbg(dev, "waveshare panel size = %d\n", data);
> +
> +	ret = waveshare_gpio_i2c_read(i2c, REG_VERSION, &data);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to read register\n");
> +
> +	dev_dbg(dev, "waveshare panel mcu version = 0x%x\n", data);
> +
> +	state->poweron_state = BIT(GPIO_TS_RESET);
> +	regmap_write(regmap, REG_TP, state->poweron_state >> 8);
> +	regmap_write(regmap, REG_LCD, state->poweron_state & 0xff);
> +	msleep(20);
> +
> +	state->regmap = regmap;
> +	state->gc.parent = dev;
> +	state->gc.label = i2c->name;
> +	state->gc.owner = THIS_MODULE;
> +	state->gc.base = -1;
> +	state->gc.ngpio = NUM_GPIO;
> +
> +	/* it is output only */
> +	state->gc.get = waveshare_gpio_gpio_get;
> +	state->gc.set = waveshare_gpio_gpio_set;
> +	state->gc.get_direction = waveshare_gpio_gpio_get_direction;
> +	state->gc.can_sleep = true;
> +
> +	ret = devm_gpiochip_add_data(dev, &state->gc, state);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to create gpiochip\n");
> +

This driver looks like it could be easily converted to use gpio-regmap and
become much shorter in the process. Could you please take a look at
linux/gpio/regmap.h?

> +	props.type = BACKLIGHT_RAW;
> +	props.max_brightness = 255;
> +	props.brightness = 255;
> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, state,
> +					    &waveshare_gpio_bl, &props);
> +	return PTR_ERR_OR_ZERO(bl);
> +}
> +
> +static const struct of_device_id waveshare_gpio_dt_ids[] = {
> +	{ .compatible = "waveshare,dsi-touch-gpio" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, waveshare_gpio_dt_ids);
> +
> +static struct i2c_driver waveshare_gpio_regulator_driver = {
> +	.driver = {
> +		.name = "waveshare-regulator",
> +		.of_match_table = of_match_ptr(waveshare_gpio_dt_ids),
> +	},
> +	.probe = waveshare_gpio_probe,
> +};
> +
> +module_i2c_driver(waveshare_gpio_regulator_driver);
> +
> +MODULE_DESCRIPTION("GPIO controller driver for Waveshare DSI touch panels");
> +MODULE_LICENSE("GPL");
>
> --
> 2.47.3
>
>

Bart
