Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF733CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 16:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E54D310E223;
	Fri, 15 May 2026 16:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aQrWa2oN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A3210E223
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 16:28:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C1CBC601DB;
 Fri, 15 May 2026 16:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC9CC2BCF5;
 Fri, 15 May 2026 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778862500;
 bh=fevXNOMD2wqSxfojs9FldeJgBr0Sp/Q5mbdpF+ByygA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aQrWa2oNCgb6cyENrUHkmbLCtQl2opci189wPhgJ0aXRcJPBsjgEdHbZYtGu03OeM
 ZmqrbV+Bpotd6rlwGLZvoIROgWLXDMK9c+zBvvu+yRam4SRNocCX4yYXWIw1dOjUlb
 7g8vi25C8aV0gGVYYKWzreSgCyYVdwk982rH3OP6RK00rULGKjJ0locZj7+iAzKzbG
 EKsHXKEX0Wk3075Wd4InovCyadkG9Yyg1qTvkSIXTrkQoilUoY2Na9HYK+MqZITNGy
 atHED3uLIk58X/0D5LNKotSeh27RnQbm/kAgJ4MDMVeESERuc0xqRFiFm0zz9ubfRM
 NzrGTEdH9RgyQ==
Date: Fri, 15 May 2026 17:28:14 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>
Subject: Re: [PATCH v2 2/2] backlight: Add SY7758 6-channel High Efficiency
 LED Driver support
Message-ID: <agdJnpz9O00lywRm@aspen.lan>
References: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org>
 <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-2-308140640de9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-2-308140640de9@linaro.org>
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

On Thu, Apr 30, 2026 at 11:47:16AM +0200, Neil Armstrong wrote:
> From: KancyJoe <kancy2333@outlook.com>
>
> Implement support for the Silergy SY7758 6-channel High Efficiency LED
> Driver used for backlight brightness control in the Ayaneo Pocket S2
> dual-DSI panel.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: KancyJoe <kancy2333@outlook.com>
> ---
>  drivers/video/backlight/Kconfig  |   8 +
>  drivers/video/backlight/Makefile |   1 +
>  drivers/video/backlight/sy7758.c | 311 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 320 insertions(+)
> <snip>
> diff --git a/drivers/video/backlight/sy7758.c b/drivers/video/backlight/sy7758.c
> new file mode 100644
> index 000000000000..9b2d3bbb4ded
> --- /dev/null
> +++ b/drivers/video/backlight/sy7758.c
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Silergy SY7758 6-channel High Efficiency LED Driver
> + *
> + * Copyright (C) 2025 Kancy Joe <kancy2333@outlook.com>
> + * Copyright (C) 2026 Linaro Limited
> + * Author: Neil Armstrong <neil.armstrong@linaro.org>

I'm a bit confused by this comment. The git author and the
MODULE_AUTHOR() is Kancy Joe. What does this comment signify?


> + */
> <snip>
> +/* OTP memory */
> +#define REG_OTP_CFG98 0x98
> +#define REG_OTP_CFG9E 0x9E
> +#define REG_OTP_CFG0 0xA0
> +#define REG_OTP_CFG1 0xA1
> +#define REG_OTP_CFG2 0xA2
> +#define REG_OTP_CFG3 0xA3
> +#define REG_OTP_CFG4 0xA4
> +#define REG_OTP_CFG5 0xA5
> +#define REG_OTP_CFG6 0xA6
> +#define REG_OTP_CFG7 0xA7
> +#define REG_OTP_CFG9 0xA9
> +#define REG_OTP_CFGA 0xAA
> +#define REG_OTP_CFGE 0xAE

There seems to be a lot of unused macros here, especially
combined with the unused bitfields that tell us how to interpret
the values.

Do we need them?


> <snip>
> +static int sy7758_probe(struct i2c_client *client)
> +{
> +	struct backlight_properties props = { };
> +	struct device *dev = &client->dev;
> +	struct sy7758 *sydev;
> +	unsigned int dev_id;
> +	int ret;
> +
> +	sydev = devm_kzalloc(dev, sizeof(*sydev), GFP_KERNEL);
> +	if (!sydev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, sydev);
> +
> +	/* Initialize regmap */
> +	sydev->client = client;
> +	sydev->regmap = devm_regmap_init_i2c(client, &sy7758_regmap_config);
> +	if (IS_ERR(sydev->regmap))
> +		return dev_err_probe(dev, PTR_ERR(sydev->regmap),
> +				     "failed to init regmap\n");
> +
> +	/* Get and enable regulators */
> +	ret = devm_regulator_get_enable(dev, "vddio");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get regulator\n");
> +
> +	usleep_range(100, 200);

Any reason not to use fsleep() here?


> +	/* Get enable GPIO and set to high */
> +	sydev->gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(sydev->gpio))
> +		return dev_err_probe(dev, PTR_ERR(sydev->gpio),
> +				     "failed to get enable GPIO\n");
> +
> +	/* Let some time for HW to settle */
> +	usleep_range(10000, 11000);

And here?


> +
> +	/* try read and check device id */
> +	ret = regmap_read(sydev->regmap, REG_DEV_ID, &dev_id);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to read device id\n");
> +	if (dev_id != 0x63) {
> +		dev_err(dev, "unexpected device id: 0x%02x\n", dev_id);
> +		return -ENODEV;
> +	}
> +
> +	/* Initialize and set default brightness */
> +	ret = sy7758_init(sydev);
> +	if (ret)
> +		return ret;
> +
> +	props.type = BACKLIGHT_RAW;
> +	props.max_brightness = MAX_BRIGHTNESS;
> +	props.brightness = DEFAULT_BRIGHTNESS;
> +	props.scale = BACKLIGHT_SCALE_LINEAR;
> +
> +	sydev->bl = devm_backlight_device_register(dev, "sy7758-backlight",
> +						   dev, sydev, &sy7758_backlight_ops,
> +						   &props);
> +	if (IS_ERR(sydev->bl))
> +		return dev_err_probe(dev, PTR_ERR(sydev->bl),
> +				     "failed to register backlight device\n");
> +
> +	return backlight_update_status(sydev->bl);
> +}


Daniel.
