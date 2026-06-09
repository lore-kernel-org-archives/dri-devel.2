Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA28FCD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB2AD10E5CB;
	Tue,  9 Jun 2026 19:10:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FtoAE7Bi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD2810E5CB
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781032212; x=1812568212;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WS6JfaEA3BwmbJKvOhjIvyQekZrai9npTeo54lk95W0=;
 b=FtoAE7BiPJ6knMitI9bTu7lKOsLqd5Xt/uu/aI2Er+VgNZkQu68B77ks
 PuB5FJqGhFRXsD7cjzjKsdd70NLWvUTctQZbpt6OE4bN43Og936XDlKQC
 Cru0rD85vlfadwEQt+ppdFVfyhIH1UPoS3xXspuGBWx5mkw5QGa7cJWTt
 p2xGdbOVTl4FVTK8jh0X8eTB6Z448SLY1OLvFIwXOkpGk+qNJ/6SDJFW1
 4vXvr6IEvbx4XL8Lj64ip30onSeBz3fIUVLw2TwT4k0nT6yBjrTjMEn5N
 dwNwgP4SsaARfaNhFVchjfAU6lW+HTrpCI1dr+NH96h2elVSnHIpDLTSV g==;
X-CSE-ConnectionGUID: P8Wzyk60Tla4dZi0/rsRpA==
X-CSE-MsgGUID: 3jqWAtQVTZChcNaxws754w==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92374867"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="92374867"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 12:10:12 -0700
X-CSE-ConnectionGUID: mIKaIEDCTdGpbdmVntiHWA==
X-CSE-MsgGUID: N/5hmFWRSF2cAslIVueonw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="269960410"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.162])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 12:10:07 -0700
Date: Tue, 9 Jun 2026 22:10:04 +0300
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
Subject: Re: [PATCH v4 05/14] iio: light: lm3533-als: Remove redundant pdata
 helpers
Message-ID: <aihlDGNZRuHI-vMR@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-6-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606045738.21050-6-clamor95@gmail.com>
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

On Sat, Jun 06, 2026 at 07:57:29AM +0300, Svyatoslav Ryhel wrote:
> The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
> used only in lm3533_als_setup. Incorporate their code into
> lm3533_als_setup directly to simplify driver readability.

Use func() when referring to a function in the commit message.

...

>  static int lm3533_als_setup(struct lm3533_als *als,
>  			    const struct lm3533_als_platform_data *pdata)
>  {
> +	struct device *dev = &als->pdev->dev;
>  	int ret;
>  
> -	ret = lm3533_als_set_input_mode(als, pdata->pwm_mode);
> +	ret = regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
> +				 LM3533_ALS_INPUT_MODE_MASK, pdata->pwm_mode);
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, ret, "failed to set input mode %d\n",
> +				     pdata->pwm_mode);
>  
>  	/* ALS input is always high impedance in PWM-mode. */
>  	if (!pdata->pwm_mode) {
> -		ret = lm3533_als_set_resistor(als, pdata->r_select);
> +		if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> +		    pdata->r_select > LM3533_ALS_RESISTOR_MAX)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid resistor value\n");
> +
> +		ret = regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
> +				   pdata->r_select);
>  		if (ret)
> -			return ret;
> +			return dev_err_probe(dev, ret, "failed to set resistor\n");
>  	}
>  
>  	return 0;

Wondering if it would be better to

	/* Bail out when in PWM-mode */
	if (pdata->pwm_mode)
		return 0;

	/* ALS input is always high impedance in PWM-mode. */
	...

as the above changes almost every line in that conditional.

-- 
With Best Regards,
Andy Shevchenko


