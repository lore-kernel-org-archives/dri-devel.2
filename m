Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FADFCD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB36B10EF8E;
	Wed, 17 Jun 2026 10:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kAlEW2mZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B80F10EFA0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781692377; x=1813228377;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=X3winq5qm2HIT6UC0/yxmrF0jTAu33Gl4aE30OAa1oI=;
 b=kAlEW2mZ3uZngNOBMtaNvhBeyWkA7uhdlSO9KJL000T459Mmv8rJphOs
 76D+hamhhVKLHIoWzEDkbwOzahCRV4UH1lCrVtOKpWI8WnFATq3M6t04E
 s3XVML4tSvItwDI7cHgG/dwTXeKu4KKXrcjUblZk/gGZ1VK5DANfj/N4o
 +zxN+MD962PFEEF9bcVVPkl7EmS9j0u5q4WroC+BG4fA9n2SxhCgYUoqz
 IK3eH3jdhv38N8Yrm2CPRFCpyJYD2w3E6G/aQDFiDiQhor1aEm3RyzMbm
 CUwyOY8oyCRqgJZ+tqSUziZ/OX7WZHNicSY6inVqZXd1Wx4mtk5KsSAFl Q==;
X-CSE-ConnectionGUID: QO79Bz4/Qbyn8LUlxdLKyw==
X-CSE-MsgGUID: 8xVzI4t/Qby/tZA7X++Dgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93594473"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="93594473"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 03:32:57 -0700
X-CSE-ConnectionGUID: leLgKuVYTtSbL+4Q82bKlQ==
X-CSE-MsgGUID: Uko2CTWXRUGLJxZ5qEEMcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="247139272"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.245.69])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 03:32:53 -0700
Date: Wed, 17 Jun 2026 13:32:50 +0300
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
Subject: Re: [PATCH v5 02/14] mfd: lm3533: Remove driver specific regmap
 wrappers
Message-ID: <ajJ30lHG5lEXri7I@ashevche-desk.local>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-3-clamor95@gmail.com>
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

On Wed, Jun 17, 2026 at 11:00:19AM +0300, Svyatoslav Ryhel wrote:
> Remove driver-specific regmap wrappers in favor of using regmap helpers
> directly.

OK, let's go with this variant.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Some side notes below for the record.

...

>  	struct lm3533_led *led = to_lm3533_led(led_cdev);
>  	unsigned enable;

Oh, besides using the old way of declaring unsigned int, it most likely
just needs to be kstrtobool().

>  	u8 reg;
> -	u8 mask;
> -	u8 val;
>  	int ret;
>  
>  	if (kstrtouint(buf, 0, &enable))
>  		return -EINVAL;

We should unshadow error codes (it may return more than -EINVAL).

>  	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
> -	mask = LM3533_REG_CTRLBANK_BCONF_ALS_EN_MASK;
>  
> -	if (enable)
> -		val = mask;
> -	else
> -		val = 0;
> -

...

> -	if (kstrtou8(buf, 0, &val))
> +	if (kstrtou32(buf, 0, &val))
>  		return -EINVAL;

Like in the previous case we should unshadow error codes.

-- 
With Best Regards,
Andy Shevchenko


