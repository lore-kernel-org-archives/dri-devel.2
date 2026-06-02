Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD93C5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D0B81138D4;
	Tue,  2 Jun 2026 08:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="I4c0baJG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C871138C7
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 08:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780387551; x=1811923551;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2U/w7csjdBCnO9lVG6/gN+OP8Ql7e6u8LR6s0zZmkk4=;
 b=I4c0baJGIMLaxPbwvfmpsGuboJWGGTCKdSWomiqkf92FTlLb6uWA2KzJ
 MKpskwidepyQ+69yz0gEwZJTnnBu2zxSLp/ND0MmEERQMy1AIzA3yGa9u
 Wm6Pg3kEoNL0eWC54SUCPEMMeC75sK3g/xTdb/526FhQG0KU27BdogCfj
 kEs5G6rUV0ab4b2yfMgwQF+AiiPbc6VG4kfMNS1UBD43pteUlmoOhdkyV
 vcNAC1I9RYixQyyIasqOMw8OvAtGbB458BF6Cxasj+9krWBNWGwMbtxVO
 fvHYLAglG022dUMO8k3l96XnWK4wdZHV89UeSHc9tolrfvGkSFruQHk+i g==;
X-CSE-ConnectionGUID: oqUzMtr4SRW+9bUnMUF9+g==
X-CSE-MsgGUID: DVW8Z5VCR9e652wcE51lZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80196785"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="80196785"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 01:05:51 -0700
X-CSE-ConnectionGUID: 1WUP5+yARsW2RD6Qx5dHOQ==
X-CSE-MsgGUID: iNqvUy3ES+SjQm6zrzvafQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="281946170"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 01:05:45 -0700
Date: Tue, 2 Jun 2026 11:05:42 +0300
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
Subject: Re: [PATCH v3 02/11] mfd: lm3533: Remove driver specific regmap
 wrappers
Message-ID: <ah6O1h8SPwjf3rV1@ashevche-desk.local>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601151831.76350-3-clamor95@gmail.com>
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

On Mon, Jun 01, 2026 at 06:18:22PM +0300, Svyatoslav Ryhel wrote:
> Remove driver-specific regmap wrappers in favor of using regmap helpers
> directly. The wrappers are mostly equivalent to the standard helpers, with
> two exceptions: regmap_read requires an unsigned int pointer, and
> regmap_update_bits has the mask and value arguments swapped. These
> differences were accounted for and adjusted accordingly.

We refer to functions as func(), exempli gratia, regmap_read().

...

> static int lm3533_als_get_current(struct iio_dev *indio_dev, unsigned channel,
>  								int *val)
>  {
>  	u8 zone;
> -	u8 target;
> +	u32 target;
>  	int ret;

While at it, move towards reversed xmas tree order

	u32 target;
	u8 zone;
	int ret;


...

> -	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_ZONE_INFO, val, mask);
> +	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_ZONE_INFO,
> +				 val, mask);

It's better to replace this to use _set_bits()/_clear_bits() or even move from
the above conditional (not in this context) to _assign_bits().

...

>  	else
>  		val = 0;	/* analog input */
>  
> -	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, val, mask);
> +	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
> +				 mask, val);

Ditto.

>  	if (ret) {
>  		dev_err(&als->pdev->dev, "failed to set input mode %d\n",
>  								pwm_mode);

...

>  	/* Make sure interrupts are disabled. */
> -	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_ZONE_INFO, 0, mask);
> +	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_ZONE_INFO,
> +				 mask, 0);

_clear_bits().

>  	if (ret) {
>  		dev_err(&als->pdev->dev, "failed to disable interrupts\n");
>  		return ret;

...

>  	u8 mask = LM3533_ALS_ENABLE_MASK;
>  	int ret;
>  
> -	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, mask, mask);
> +	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
> +				 mask, mask);

_set_bits()

>  	if (ret)
>  		dev_err(&als->pdev->dev, "failed to enable ALS\n");
>  

...

>  	u8 mask = LM3533_ALS_ENABLE_MASK;
>  	int ret;
>  
> -	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, 0, mask);
> +	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
> +				 mask, 0);

_clear_bits()

>  	if (ret)
>  		dev_err(&als->pdev->dev, "failed to disable ALS\n");

...

>  	else
>  		val = 0;
>  
> -	ret = lm3533_update(led->lm3533, LM3533_REG_PATTERN_ENABLE, val, mask);
> +	ret = regmap_update_bits(led->lm3533->regmap,
> +				 LM3533_REG_PATTERN_ENABLE, mask, val);

_assign_bits() and so on...

>  	if (ret) {
>  		dev_err(led->cdev.dev, "failed to enable pattern %d (%d)\n",
>  							pattern, enable);

...

>  extern int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u8 val);
> -extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u8 *val);
> +extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);

We don't need to keep 'extern' for ages.

>  extern int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb,
>  								u16 imax);
>  extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val);
> -extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u8 *val);
> -
> -extern int lm3533_read(struct lm3533 *lm3533, u8 reg, u8 *val);
> -extern int lm3533_write(struct lm3533 *lm3533, u8 reg, u8 val);
> -extern int lm3533_update(struct lm3533 *lm3533, u8 reg, u8 val, u8 mask);
> +extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);

-- 
With Best Regards,
Andy Shevchenko


