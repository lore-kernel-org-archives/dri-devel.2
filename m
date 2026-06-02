Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE0FCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C209D10F165;
	Tue,  2 Jun 2026 13:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aWUHG1qS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE5910F146
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 13:46:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9037740883;
 Tue,  2 Jun 2026 13:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97DE1F00893;
 Tue,  2 Jun 2026 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780408008;
 bh=GgeCHMOQLe7sziJLA5PC7VCAR6QFsAiheuuHn0qTd64=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=aWUHG1qS7mkth6CXBwpvSXYjBb1mcBxf/mTnTn8YApkbS84Ww7v9tkqSycJnQ1FoF
 u0bJ0cITis94bgo0251eNpPSEWBBT7nStcjYqWHr2+Vi+R2xragrvI95L4n0ymf3R/
 W7MhrtQS5doAZefjwSYdVJhHIHM7YtvNDK6w6L7Hiduo602lmhZO4+eGNYmaGaxCkL
 /BsvDewnbkOgNvdOdJXQ2kyTqRGoEpl7chl+hL6jIByooAFN2QfeemARFuTLgmYKpE
 hnhQYNCwa6S0ug5OX2CCXQSd39OxKK/gAWx9JkgTHwYat7rHU57hnNeOIh3pUNYn7j
 yANrkBsMoO1Ow==
Date: Tue, 2 Jun 2026 14:46:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
Message-ID: <20260602144640.433b4d35@jic23-huawei>
In-Reply-To: <20260601151831.76350-6-clamor95@gmail.com>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-6-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon,  1 Jun 2026 18:18:25 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Since there are no users of this driver via platform data, remove the
> platform data support and switch to using Device Tree bindings.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>


> index 52136ca1abc9..55b35467a722 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -16,16 +16,19 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/mfd/core.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/units.h>
>  
>  #include <linux/mfd/lm3533.h>
>  
>  
> -#define LM3533_ALS_RESISTOR_MIN			1
> -#define LM3533_ALS_RESISTOR_MAX			127
> +#define LM3533_ALS_RESISTOR_MIN			1575
> +#define LM3533_ALS_RESISTOR_MAX			200000
>  #define LM3533_ALS_CHANNEL_CURRENT_MAX		2
>  #define LM3533_ALS_THRESH_MAX			3
>  #define LM3533_ALS_ZONE_MAX			4
> @@ -57,6 +60,9 @@ struct lm3533_als {
>  
>  	atomic_t zone;
>  	struct mutex thresh_mutex;
> +
> +	bool pwm_mode;
> +	u32 r_select;
>  };
>  
>  
> @@ -411,7 +417,7 @@ static ssize_t show_thresh_either_en(struct device *dev,
>  	int enable;
>  	int ret;
>  
> -	if (als->irq) {
> +	if (als->irq > 0) {
>  		ret = lm3533_als_get_int_mode(indio_dev, &enable);
>  		if (ret)
>  			return ret;
> @@ -716,30 +722,34 @@ static const struct attribute_group lm3533_als_attribute_group = {
>  	.attrs = lm3533_als_attributes
>  };
>  
> -static int lm3533_als_setup(struct lm3533_als *als,
> -			    const struct lm3533_als_platform_data *pdata)
> +static int lm3533_als_setup(struct lm3533_als *als)
>  {
>  	struct device *dev = &als->pdev->dev;
>  	int ret;
>  
> +	als->pwm_mode = device_property_read_bool(dev, "ti,pwm-mode");
> +
>  	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
>  				 LM3533_ALS_INPUT_MODE_MASK,
> -				 pdata->pwm_mode ? LM3533_ALS_INPUT_MODE_MASK : 0);
> +				 als->pwm_mode ? LM3533_ALS_INPUT_MODE_MASK : 0);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to set input mode %d\n",
> -				     pdata->pwm_mode);
> -
> +				     als->pwm_mode);
>  
>  	/* ALS input is always high impedance in PWM-mode. */
> -	if (!pdata->pwm_mode) {
> -		if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> -		    pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
> -			dev_err(&als->pdev->dev, "invalid resistor value\n");
> -			return -EINVAL;
> -		}
> +	if (!als->pwm_mode) {
> +		ret = device_property_read_u32(dev, "ti,resistor-value-ohms",
> +					       &als->r_select);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to ger resistor value\n");
> +
> +		als->r_select = clamp(als->r_select, LM3533_ALS_RESISTOR_MIN,
> +				      LM3533_ALS_RESISTOR_MAX);

If we are getting garbage from DT I think I'd rather error out that paper over
that problem.  So similar to before, check valid value and if not fail probe
so that hopefully someone goes and fixes it!

> +		als->r_select = DIV_ROUND_UP(2 * MICRO, 10 * als->r_select);
Why do we need this when we didn't before?  The range checks are the same
so it smells like it shouldn't need transforming. I'd also rather we didn't do
rewriting of the meaning of r_select like this.  Just use a local variable for
the intermediate result.

>  
>  		ret = regmap_write(als->lm3533->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
> -				   pdata->r_select);
> +				   als->r_select);
>  		if (ret)
>  			return dev_err_probe(dev, ret, "failed to set resistor\n");
