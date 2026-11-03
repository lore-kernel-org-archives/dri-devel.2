Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E36606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7yYtvK7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD1A10E582;
	Tue,  3 Nov 2026 14:15:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B1510E582
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:15:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AE5840344;
 Tue,  3 Nov 2026 14:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73541F000C1;
 Tue,  3 Nov 2026 14:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793715351;
 bh=xEksWo7GlN0d12eDs55ivgjRN/CX83ariJNLMru8Xao=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=H7yYtvK7aiFHZiEDq2B8+XBZxTL5hcX2J5E3lKDaz+oUGpAZ8w2BTdCkjxlubDD8w
 FQaOfbZgLqYNhAJrkNBn2y04FSKLxN6L7aZwz8sLNnnvowKwBP29B2+1PS0y4vMwru
 UEThurXYzWSMZL56avKMLMW9UMlLe3iTAoBOOhFCL/NcgHDg0HM1y0p+vCKyxKyhw3
 Tcwa1MbEWcg8oZ0a2zVIAPnxiMFL9ugNlbyQ/k7Su8tdwmFjiYKVx0fSJf/zBETIQ2
 1z0rTqmP00tHQ8QynWCbg9ivUr/o5kd5C/78Enu7fc6+QVhiFyoNntfTPaaoEvUu3K
 DVNRuTMD09Mqg==
Date: Tue, 3 Nov 2026 14:15:46 +0000
From: Daniel Thompson <danielt@kernel.org>
To: rva333@protonmail.com
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: add ktd3137 support
Message-ID: <aunskqwg_CbpBL49@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
 <20261102-6768-ktd3137-v1-2-b5b4f903c56e@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-6768-ktd3137-v1-2-b5b4f903c56e@protonmail.com>
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 09:58:49PM +0200, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
>
> Add support for the KTD3137 display backlight IC. It's used in various
> Xiaomi phones, such as Xiaomi Redmi Note 9.
>
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  MAINTAINERS                       |   1 +
>  drivers/video/backlight/Kconfig   |  11 ++
>  drivers/video/backlight/Makefile  |   1 +
>  drivers/video/backlight/ktd3137.c | 262 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 275 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 24dd5b43f167..23114fd09445 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14622,6 +14622,7 @@ KTD3137 BACKLIGHT DRIVER
>  M:	Roman Vivchar <rva333@protonmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml
> +F:	drivers/video/backlight/ktd3137.c
>
>  KTEST
>  M:	Steven Rostedt <rostedt@goodmis.org>
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 7c66b8840d88..0196b8597367 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -199,6 +199,17 @@ config BACKLIGHT_KTD2801
>  	  Say Y to enable the backlight driver for the Kinetic KTD2801 1-wire
>  	  GPIO-controlled backlight found in Samsung Galaxy Core Prime VE LTE.
>
> +config BACKLIGHT_KTD3137
> +	tristate "Backlight Driver for Kinetic KTD3137"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable the backlight driver for the Kinetic KTD3137
> +	  found in various Xiaomi smartphones.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ktd3137.
> +
>  config BACKLIGHT_KTZ8866
>  	tristate "Backlight Driver for Kinetic KTZ8866"
>  	depends on I2C
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index 34469711c6cd..b2d3b69e9e32 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_BACKLIGHT_HP700)		+= jornada720_bl.o
>  obj-$(CONFIG_BACKLIGHT_IPAQ_MICRO)	+= ipaq_micro_bl.o
>  obj-$(CONFIG_BACKLIGHT_KTD253)		+= ktd253-backlight.o
>  obj-$(CONFIG_BACKLIGHT_KTD2801)		+= ktd2801-backlight.o
> +obj-$(CONFIG_BACKLIGHT_KTD3137)		+= ktd3137.o
>  obj-$(CONFIG_BACKLIGHT_KTZ8866)		+= ktz8866.o
>  obj-$(CONFIG_BACKLIGHT_LM3509)		+= lm3509_bl.o
>  obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
> diff --git a/drivers/video/backlight/ktd3137.c b/drivers/video/backlight/ktd3137.c
> new file mode 100644
> index 000000000000..a3ff334b8d46
> --- /dev/null
> +++ b/drivers/video/backlight/ktd3137.c
> @@ -0,0 +1,262 @@
> <snip>
> +static int ktd3137_init(struct ktd3137 *ktd)
> +{
> +	u32 val = KTD3137_CONTROL_DEFAULT | KTD3137_CONTROL_LINEAR;
> +	int ret;
> +
> +	ret = regmap_write(ktd->regmap, KTD3137_REG_CONTROL, val);

Nitpicking but val seems a bit pointless here.


> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(ktd->regmap, KTD3137_REG_PWM, KTD3137_PWM_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(ktd->regmap, KTD3137_REG_RAMP_ON, KTD3137_RAMP_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(ktd->regmap, KTD3137_REG_TRANS_RAMP, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(ktd->regmap, KTD3137_REG_MODE,
> +				  KTD3137_MODE_CURRENT_MASK, ktd->led_current);
> +}
> <snip>
> +static int ktd3137_probe(struct i2c_client *client)
> +{
> +	struct backlight_device *backlight_dev;
> +	struct backlight_properties props = { };
> +	struct ktd3137 *ktd;
> +	u32 val;
> +	int ret;
> +
> +	ktd = devm_kzalloc(&client->dev, sizeof(*ktd), GFP_KERNEL);
> +	if (!ktd)
> +		return -ENOMEM;
> +
> +	ktd->dev = &client->dev;
> +
> +	ret = devm_regulator_get_enable(ktd->dev, "vin");
> +	if (ret)
> +		return dev_err_probe(ktd->dev, ret, "failed to power up\n");
> +
> +	ktd->enable_gpio = devm_gpiod_get_optional(ktd->dev, "enable",
> +						   GPIOD_OUT_HIGH);
> +	if (IS_ERR(ktd->enable_gpio))
> +		return dev_err_probe(ktd->dev, PTR_ERR(ktd->enable_gpio),
> +				     "failed to get enable gpio\n");
> +
> +	/* HWEN should stay HIGH for at least 150us before I2C can be used */
> +	fsleep(150);
> +
> +	ktd->regmap = devm_regmap_init_i2c(client, &ktd3137_regmap_config);
> +	if (IS_ERR(ktd->regmap))
> +		return dev_err_probe(ktd->dev, PTR_ERR(ktd->regmap),
> +				     "failed to init regmap\n");
> +
> +	ret = regmap_read(ktd->regmap, KTD3137_REG_DEV_ID, &val);
> +	if (ret)
> +		return dev_err_probe(ktd->dev, ret, "failed to read chip id\n");
> +
> +	if (val != KTD3137_DEV_ID_A && val != KTD3137_DEV_ID_B)
> +		return dev_err_probe(ktd->dev, -ENODEV,
> +				     "unsupported chip id: 0x%02x\n", val);
> +
> +	ret = ktd3137_parse_dt(ktd);
> +	if (ret)
> +		return ret;
> +
> +	ret = ktd3137_init(ktd);
> +	if (ret)
> +		return dev_err_probe(ktd->dev, ret, "failed to init chip\n");
> +
> +	props.type = BACKLIGHT_RAW;
> +	props.max_brightness = KTD3137_MAX_BRIGHTNESS;
> +	props.brightness = KTD3137_DEFAULT_BRIGHTNESS;

No need for KTD3137_DEFAULT_BRIGHTNESS. Just use KTD3137_MAX_BRIGHTNESS.


> +	props.scale = BACKLIGHT_SCALE_LINEAR;
> +	device_property_read_u32(ktd->dev, "default-brightness", &props.brightness);
> +
> +	backlight_dev = devm_backlight_device_register(ktd->dev,
> +						       "ktd3137-backlight",
> +						       ktd->dev, ktd,
> +						       &ktd3137_backlight_ops,
> +						       &props);
> +	if (IS_ERR(backlight_dev))
> +		return dev_err_probe(ktd->dev, PTR_ERR(backlight_dev),
> +				     "failed to register backlight device\n");

dev_err_cast_probe()


> +
> +	i2c_set_clientdata(client, backlight_dev);
> +	return backlight_update_status(backlight_dev);
> +}
> +
> +static void ktd3137_remove(struct i2c_client *client)
> +{
> +	struct backlight_device *backlight_dev = i2c_get_clientdata(client);
> +	struct ktd3137 *ktd = bl_get_data(backlight_dev);
> +
> +	backlight_dev->props.brightness = 0;
> +	backlight_update_status(backlight_dev);
> +
> +	gpiod_set_value_cansleep(ktd->enable_gpio, 0);

Is this needed?

> +}


Daniel.
