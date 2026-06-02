Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4FBCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E3D010F12D;
	Tue,  2 Jun 2026 13:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QkQaNHIK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7801210F12D
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 13:42:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2721B43AA2;
 Tue,  2 Jun 2026 13:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6291F00893;
 Tue,  2 Jun 2026 13:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780407754;
 bh=+NOwv3nIu/Ot0KxPJsgbaT8KLyjfpqdRwQOPFZyGDyo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=QkQaNHIKyHnxMEEHWFbu6OWHwnFZgNn0fwEiT2qDWJ5O1QLY9A3iMv7cwzbppdQoN
 820Oo4HpnFSOU0L/FP6lp/cFc3ZUXGm/X520P0Gke8BIFOJkMqHe3yveARrrH6irRh
 39y3QNs6j0FZIs6sy9U1ulKhOrUvnOMKLbuEiBTfm5nWAN3J3xn6Yi0gbnna0gh1D9
 TQg/YW88ip7M0Cki+Jpdo/nJtZ3KeRpp7h7gi9kEYi+sydK5gPl//Eo9iu8jSrSZyL
 vE+KhsNX+C5rkpNSQWADDGZY4KOfKXZQFs8Imh0rVGTOg8OpdamhgQxy/oIt3cwxlt
 OyVgr5uekFYEg==
Date: Tue, 2 Jun 2026 14:42:22 +0100
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
Subject: Re: [PATCH v3 03/11] iio: light: lm3533-als: Remove redundant pdata
 helpers
Message-ID: <20260602144222.7a50a041@jic23-huawei>
In-Reply-To: <20260601151831.76350-4-clamor95@gmail.com>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-4-clamor95@gmail.com>
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

On Mon,  1 Jun 2026 18:18:23 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
> used only in lm3533_als_setup. Incorporate their code into
> lm3533_als_setup directly to simplify driver readability.
Minor stuff inline.


> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/iio/light/lm3533-als.c | 61 +++++++++-------------------------
>  1 file changed, 16 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index fb61904f110f..52136ca1abc9 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c

>  static int lm3533_als_setup(struct lm3533_als *als,
>  			    const struct lm3533_als_platform_data *pdata)
>  {
> +	struct device *dev = &als->pdev->dev;
>  	int ret;
>  
> -	ret = lm3533_als_set_input_mode(als, pdata->pwm_mode);
> +	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,

Maybe a local struct regmap pointer given dereferenced in a couple of places.

> +				 LM3533_ALS_INPUT_MODE_MASK,
> +				 pdata->pwm_mode ? LM3533_ALS_INPUT_MODE_MASK : 0);

Andy raised this in previous patch but in the interests of being specific
regmap_assign_bits() is going to be cleaner here.

>  	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, ret, "failed to set input mode %d\n",
> +				     pdata->pwm_mode);
> +
>  
>  	/* ALS input is always high impedance in PWM-mode. */
>  	if (!pdata->pwm_mode) {
> -		ret = lm3533_als_set_resistor(als, pdata->r_select);
> +		if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> +		    pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
> +			dev_err(&als->pdev->dev, "invalid resistor value\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = regmap_write(als->lm3533->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
> +				   pdata->r_select);
>  		if (ret)
> -			return ret;
> +			return dev_err_probe(dev, ret, "failed to set resistor\n");
>  	}
>  
>  	return 0;

