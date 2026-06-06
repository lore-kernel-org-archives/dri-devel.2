Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C0FCD8C8B
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 06:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8283710E73D;
	Sat,  6 Jun 2026 06:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mpLqdlFU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5323310E73D
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 06:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780728788; x=1812264788;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ua+pmOUdH0hE2qHl0EeTA3y+RmonfwXBwqAa6siD2hA=;
 b=mpLqdlFUT3eMM0L9voL5G93YOgaOunuJKEk+Vucmt7hY2xo0QW8vTQqV
 zL0ukgaNwF2QnUtq99B/NO2+PxsQ3xL/seAdVUo1W4fq8dIyIrk2aYP1H
 VRBXOEE+F9KYs4Sdh/p2V1icthl8vyqbHk4k9vy50lMeLjO9m7046LoCI
 vqjY5a2d0abZmkWBxg/tNqi1giIReAP0UXagIJ8TMnfIwjR25aZlK1WPJ
 Oly87teoyPZZ3mARDEoaSPfzfzO8h9UaTedlbq2mOeuzLpZ6ab677AQZO
 SvPi1qGkN9b40PIybsQ5O5Eh8LwES1tMWXIlmD66hmEJmMpeToAnciZ0i w==;
X-CSE-ConnectionGUID: uwmUrqpwQyay5TkjoaQYXQ==
X-CSE-MsgGUID: qO9gzU7DQ/Cw1vx6GpUENA==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="81673448"
X-IronPort-AV: E=Sophos;i="6.24,190,1774335600"; d="scan'208";a="81673448"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 23:53:08 -0700
X-CSE-ConnectionGUID: HqwNvrRRQwmj9tyigOeqwQ==
X-CSE-MsgGUID: rJRg2daYSVaIxT3DdqeZmA==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.57])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 23:53:03 -0700
Date: Sat, 6 Jun 2026 09:53:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 02/14] mfd: lm3533: Remove driver specific regmap
 wrappers
Message-ID: <aiPDzdKuccdLIvlF@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606045738.21050-3-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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

On Sat, Jun 06, 2026 at 07:57:26AM +0300, Svyatoslav Ryhel wrote:
> Remove driver-specific regmap wrappers in favor of using regmap helpers
> directly.

I like the idea of this patch. Nevertheless I have some suggestions below.

...

>  {
>  	struct lm3533_als *als = iio_priv(indio_dev);
>  	u8 reg;
> -	u8 val;
> +	u32 val;

Strictly speaking this should be unsigned int. The regmap API use unsigned int.

...

>  static int lm3533_als_set_int_mode(struct iio_dev *indio_dev, int enable)
>  {
>  	struct lm3533_als *als = iio_priv(indio_dev);
> -	u8 mask = LM3533_ALS_INT_ENABLE_MASK;
> -	u8 val;
>  	int ret;
>  
> -	if (enable)
> -		val = mask;
> -	else
> -		val = 0;
> -
> -	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_ZONE_INFO, val, mask);
> +	ret = regmap_assign_bits(als->lm3533->regmap, LM3533_REG_ALS_ZONE_INFO,
> +				 LM3533_ALS_INT_ENABLE_MASK, enable);

In cases like this perhaps leaving mask would be fine and together with

	struct regmap *map = als->lm3533->regmap;

this be nice one-liner:

	ret = regmap_assign_bits(map, LM3533_REG_ALS_ZONE_INFO, mask, enable);

>  	if (ret) {
>  		dev_err(&indio_dev->dev, "failed to set int mode %d\n",
>  								enable);

In many cases it won't increase LoC count.

...

>  extern int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u8 val);
> -extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u8 *val);
> +extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);

>  extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val);
> -extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u8 *val);
> +extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);

Now they become asymmetrical. Perhaps to replace setters, but be careful about
upper bits.

-- 
With Best Regards,
Andy Shevchenko


