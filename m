Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A926CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66FC510E189;
	Thu, 25 Jun 2026 07:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nBUylVD9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A07FB10E189
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782372240; x=1813908240;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1UZvmdf4Q5tnJFY7xUSRWz7uM0sTceNWud0IQD8vJU8=;
 b=nBUylVD9hkLvFT5KmhIPoe+6zFkUgEanPGehccqxNHEB+t4UWTo7Fxl9
 sTu9wyzE0JoX2mDEINJ54kkjEBVkl4l54AJPGnYPFPc1VifnAZNZ8lJkL
 VPPoHGEYqvwMQ0AXdi2yM2oDN9fMrIOgsCdkElzBd0+Cw/PEl7A60uDNM
 82dOB3cS3pxjz3Qb1ttO5zvVQr6tPLDv6VPRrYJmhXLWDu5gG2FwsV0Km
 Uwd8DLdrbzJ4+RGEvFqkMR3Cj31gUNqw9lwKOoo0LXASm0WNB7OyEbeWD
 IbzIatQaLXIqJqGr+ir6CZAqVHLeAEvHALI5ogkPDDRRMl5MJnAR9vjZl g==;
X-CSE-ConnectionGUID: BJDQv1zUROWYInCMgVWRbg==
X-CSE-MsgGUID: LP1rti/wRg2nkrtYCBUdnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="87049971"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="87049971"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 00:24:00 -0700
X-CSE-ConnectionGUID: 4B3wNXkYTvCXf9SkCyOppQ==
X-CSE-MsgGUID: w3gGCdMqQL2K5wlStobBiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="254238373"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 00:23:56 -0700
Date: Thu, 25 Jun 2026 10:23:53 +0300
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
Subject: Re: [PATCH v5 07/14] mfd: lm3533: Use dev_groups in struct
 device_driver
Message-ID: <ajzXidQCd8pe-L5b@ashevche-desk.local>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-8-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-8-clamor95@gmail.com>
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

On Wed, Jun 17, 2026 at 11:00:24AM +0300, Svyatoslav Ryhel wrote:
> Instead of creating and removing the device sysfs attributes directly
> during probe and remove of the driver, respectively, use dev_groups in
> struct device_driver to point to the attribute definitions and let the
> core take care of creating and removing them.
> 
> No intentional functional impact.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
And thanks for doing that!

...

>  	.attrs		= lm3533_attributes
>  };
>  
> +static const struct attribute_group *lm3533_attribute_groups[] = {
> +	&lm3533_attribute_group,
> +	NULL,
> +};

We have ATTRIBUTE_GROUPS() macro.

...

> +++ b/drivers/video/backlight/lm3533_bl.c

Same as per above.


-- 
With Best Regards,
Andy Shevchenko


