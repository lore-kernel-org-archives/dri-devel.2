Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17599CA5FFC
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FFA10E1D3;
	Mon,  5 Oct 2026 16:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lp6GjOcm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54A8C10E1D3
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 16:51:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23B44405AE;
 Mon,  5 Oct 2026 16:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AF21F000FF;
 Mon,  5 Oct 2026 16:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791219103;
 bh=3Whrln9LOAw8/a2JMzdAcPZXBf7EPG/WFgkqCPKUIwE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Lp6GjOcmtDXkEe2gDrQwHn5woWvg1KY6ZGJL3mN+zML1y3zKxXrqD3onyvkIlmorw
 kPM1nIxsOxwSVZaPUwFvuZiFvxqF63V+K1Q/DDF/wtMdBsZoHBP6SFSHaBbao3PETE
 8d9mddECP3WinQqRmwapKZSvp63i4vOJfw8oTdfGrXYlPly8ukAebtu7fHsrgSqylY
 3NuZBjrXf4sqAgcgwvfHWwO11+BKDApT+V3uWcntzJdmXxbEBLBpYoWnEmXTg03zPk
 4Hv5QXzxxhs5N0xOztmCXTrYBhvFWV0u+q97llihsZtHebONew8Mxe0XVoqNKn29Ut
 Q8c21D0sypx3A==
Date: Mon, 5 Oct 2026 17:51:37 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/3] mfd: aat2870: Convert to use OF bindings
Message-ID: <asPVmbvyslGgEsjk@aspen.lan>
References: <20261004164121.193514-1-clamor95@gmail.com>
 <20261004164121.193514-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004164121.193514-3-clamor95@gmail.com>
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

On Sun, Oct 04, 2026 at 07:41:20PM +0300, Svyatoslav Ryhel wrote:
> Conversion of the AAT2870 driver to use OF bindings requires a few complex
> changes that should be done simultaneously.
>
> The AAT2870 essentially provides two functions via child devices:
> backlight and regulators. Both functions are fairly self-sufficient and
> may not be populated on the final board. Consequently, the MFD
> registration API was replaced with of_platform_populate(), and each
> sub-device was given its own compatible string.
>
> Additionally, aat2870-core utilizes an enable GPIO. Obtaining this GPIO
> was converted to use modern gpiod/OF helpers, allowing the redundant
> aat2870_enable() and aat2870_disable() helpers to be removed.
>
> The aat2870-regulator driver was updated to register each of the four LDOs
> from a dedicated OF node.
>
> The aat2870-backlight driver was changed to populate all required
> properties from a dedicated Device Tree node. Its channel map was updated
> to use u8 instead of int. Furthermore, because the maximum current is now
> parsed as an absolute value rather than an enum entry, the calculation and
> application of the maximum current were updated accordingly.
>
> All of the changes above allow platform data to be removed entirely.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/mfd/aat2870-core.c            | 115 ++++++--------------------
>  drivers/regulator/aat2870-regulator.c |  76 ++++++++++++-----
>  drivers/video/backlight/aat2870_bl.c  |  55 ++++++------
>  include/linux/mfd/aat2870.h           |  95 +--------------------
>  4 files changed, 111 insertions(+), 230 deletions(-)
>
> [snip]
>
> diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
> index 8b790df1e842b..933a8f728f66a 100644
> --- a/drivers/video/backlight/aat2870_bl.c
> +++ b/drivers/video/backlight/aat2870_bl.c
> @@ -15,11 +15,19 @@
>  #include <linux/backlight.h>
>  #include <linux/mfd/aat2870.h>
>
> +/* Backlight has 8 channels, each bit represents one channel */
> +#define AAT2870_BL_CH_ALL	0xff
> +
> +/* Backlight current magnitude (uA), 450uA current is eq to 0 */
> +#define AAT2870_CURRENT_MIN	450
> +#define AAT2870_CURRENT_MAX	27900
> +#define AAT2870_CURRENT_STEP	900
> +
>  struct aat2870_bl_driver_data {
>  	struct platform_device *pdev;
>  	struct backlight_device *bd;
>
> -	int channels;
> +	u8 channels;
>  	int max_current;
>  	int brightness; /* current brightness */
>  };
> @@ -30,7 +38,7 @@ static inline int aat2870_brightness(struct aat2870_bl_driver_data *aat2870_bl,
>  	struct backlight_device *bd = aat2870_bl->bd;
>  	int val;
>
> -	val = brightness * (aat2870_bl->max_current - 1);
> +	val = brightness * aat2870_bl->max_current;
>  	val /= bd->props.max_brightness;

What is the purpose of max_brightness?

Normally it is used to limit brightness but max_current is already doing
that. Is it just being used to reduce the number of steps in the
brightness scale (and if so, why is that useful)?


>
>  	return val;
> @@ -42,7 +50,7 @@ static inline int aat2870_bl_enable(struct aat2870_bl_driver_data *aat2870_bl)
>  			= dev_get_drvdata(aat2870_bl->pdev->dev.parent);
>
>  	return aat2870->write(aat2870, AAT2870_BL_CH_EN,
> -			      (u8)aat2870_bl->channels);
> +			      aat2870_bl->channels);
>  }
>
>  static inline int aat2870_bl_disable(struct aat2870_bl_driver_data *aat2870_bl)
> @@ -96,24 +104,12 @@ static const struct backlight_ops aat2870_bl_ops = {
>
>  static int aat2870_bl_probe(struct platform_device *pdev)
>  {
> -	struct aat2870_bl_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct aat2870_bl_driver_data *aat2870_bl;
>  	struct backlight_device *bd;
>  	struct backlight_properties props;
> +	u32 max_brightness = 0;
>  	int ret = 0;
>
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "No platform data\n");
> -		ret = -ENXIO;
> -		goto out;
> -	}
> -
> -	if (pdev->id != AAT2870_ID_BL) {
> -		dev_err(&pdev->dev, "Invalid device ID, %d\n", pdev->id);
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
>  	aat2870_bl = devm_kzalloc(&pdev->dev,
>  				  sizeof(struct aat2870_bl_driver_data),
>  				  GFP_KERNEL);
> @@ -140,18 +136,18 @@ static int aat2870_bl_probe(struct platform_device *pdev)
>
>  	aat2870_bl->bd = bd;
>
> -	if (pdata->channels > 0)
> -		aat2870_bl->channels = pdata->channels;
> -	else
> -		aat2870_bl->channels = AAT2870_BL_CH_ALL;
> +	aat2870_bl->channels = AAT2870_BL_CH_ALL;
> +	device_property_read_u8(&pdev->dev, "skyworks,channels", &aat2870_bl->channels);
>
> -	if (pdata->max_current > 0)
> -		aat2870_bl->max_current = pdata->max_current;
> -	else
> -		aat2870_bl->max_current = AAT2870_CURRENT_27_9;
> +	device_property_read_u32(&pdev->dev, "led-max-microamp", &aat2870_bl->max_current);
> +	aat2870_bl->max_current = clamp(aat2870_bl->max_current, AAT2870_CURRENT_MIN,
> +					AAT2870_CURRENT_MAX);
> +	aat2870_bl->max_current /= AAT2870_CURRENT_STEP;
>
> -	if (pdata->max_brightness > 0)
> -		bd->props.max_brightness = pdata->max_brightness;
> +	/* If max-brightness property is missing or set to zero, use chip's max value */
> +	device_property_read_u32(&pdev->dev, "max-brightness", &max_brightness);
> +	if (max_brightness)
> +		bd->props.max_brightness = max_brightness;
>  	else
>  		bd->props.max_brightness = 255;

IIUC max_current can be zero (since AAT2870_CURRENT_MIN <
AAT2870_CURRENT_STEP). Since that means aat2870_brightness() will
always return 0 then there might need to be a special case
max_brightness for this case.


> @@ -181,9 +177,16 @@ static void aat2870_bl_remove(struct platform_device *pdev)
>  	backlight_update_status(bd);
>  }
>
> +static const struct of_device_id aat2870_bl_match_table[] = {
> +	{ .compatible = "skyworks,aat2870-backlight" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, aat2870_bl_match_table);
> +
>  static struct platform_driver aat2870_bl_driver = {
>  	.driver = {
>  		.name	= "aat2870-backlight",
> +		.of_match_table = aat2870_bl_match_table,
>  	},
>  	.probe		= aat2870_bl_probe,
>  	.remove		= aat2870_bl_remove,


Daniel.
