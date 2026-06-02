Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687ADC5DF71
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891ED113901;
	Tue,  2 Jun 2026 08:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gRru3k6D";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF24A113901
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 08:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780388641; x=1811924641;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6mIZQksu9gsOvaTRiSt+HQWtZhwTIx9SmiAsWepUatk=;
 b=gRru3k6D0IMRTyInP3SLrGyNQECSLRfn1ew6YY+pvTimk6ktJO/gpt/O
 unTYcYEwDliL1O/PnyVBqDwzyU0TIY20nnJ/Xu2WsJfK6iCcLELiY55km
 DB0Oqdy/rDvvRKzgs/441sVb70DV7/PIsFpFrpKDFW3C9MKKA+4bbH1Rl
 e/bFVEvNwf6pebGBLhUuEbydxEjxc5ZuzphcOG63ZU311PpDKE9LTn+sj
 xeo7k/zb32HfPLhKEQ9E8c2tNmykb0YtvHbUvbExwoXa7AogH+B2BLTTm
 zC4P8rtbAN7Fn4+xWtNfcNQUeJ5eJ9g1C3P0ncB0d0rqjvN+hKzvXsGvH w==;
X-CSE-ConnectionGUID: G+KEUoWFTeSk76dCCqpdig==
X-CSE-MsgGUID: 1uH+yfyhSDqzaJ3novX8/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81195635"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="81195635"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 01:24:01 -0700
X-CSE-ConnectionGUID: yEgoAATaT6q0PeBlcsXiag==
X-CSE-MsgGUID: qzCimZX+SwK+A2t6n47VrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; d="scan'208";a="245647814"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.229])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 01:23:56 -0700
Date: Tue, 2 Jun 2026 11:23:54 +0300
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
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
Message-ID: <ah6TGjRNnDpQGO60@ashevche-desk.local>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-6-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601151831.76350-6-clamor95@gmail.com>
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

On Mon, Jun 01, 2026 at 06:18:25PM +0300, Svyatoslav Ryhel wrote:
> Since there are no users of this driver via platform data, remove the
> platform data support and switch to using Device Tree bindings.

...

> @@ -57,6 +60,9 @@ struct lm3533_als {
>  
>  	atomic_t zone;
>  	struct mutex thresh_mutex;
> +
> +	bool pwm_mode;
> +	u32 r_select;
>  };

Have you run `pahole`? Does it agree with the layout you made here?

...

> -	als->irq = lm3533->irq;
> +	als->irq = platform_get_irq_optional(pdev, 0);

> +

Redundant blank line.

> +	if (als->irq == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

What about other error codes when IRQ is found by can't be retrieved for some
reasons? IIRC we check against ENXIO in similar cases

	als->irq = platform_get_irq_optional(pdev, 0);
	if (als->irq == -ENXIO)
		als->irq = 0;
	if (als->irq < 0)
		return als->irq;

...

> +	led->pwm = 0;

Isn't it 0 by zalloc ?

> +	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);

...

>  #define LM3533_BOOST_FREQ_MASK		0x01
>  #define LM3533_BOOST_FREQ_SHIFT		0
> +#define LM3533_BOOST_FREQ_MIN		500000
> +#define LM3533_BOOST_FREQ_MAX		1000000

HZ_PER_KHZ  (since you included units.h)?

...

> +	nchilds = device_get_child_node_count(dev);
> +	if (!nchilds || nchilds > LM3533_CELLS_MAX) {
> +		dev_err(dev, "num of child nodes is not supported\n");
> +		return -ENODEV;

Why not dev_err_probe() here and elsewhere? It looks inconsistent with this
patch.

>  	}

...

> +	device_for_each_child_node_scoped(lm3533->dev, child) {

> +		if (!fwnode_device_is_available(child))
> +			continue;

Do we need this check?

...

> +				dev_err(dev, "invalid LED node %s\n",
> +					fwnode_get_name(child));

%pfw

...

> +	ret = sysfs_create_group(&dev->kobj, &lm3533_attribute_group);

No way. You should use .dev_groups.

> +	if (ret) {
> +		dev_err(dev, "failed to create sysfs attributes\n");
>  		goto err_unregister;
>  	}

...

Can you think on how to split this change to smaller steps? I believe it's
possible.

-- 
With Best Regards,
Andy Shevchenko


