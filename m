Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905DECD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED34410E3DA;
	Tue,  9 Jun 2026 19:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IrEAeJ7j";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5572210E3DA
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 19:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781032999; x=1812568999;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=w89bLBIHCx0Hcg7oxfK3eG1Xm1bHBwPKh+bHpE29Neo=;
 b=IrEAeJ7jmllNXM/whGESOSDZnKX284l/skbQKH35xNH77adeRmjy0iSi
 S5wEcbo79byZ0eCo+E8gSFOQ6pIm97anOtiydIafA1ndGvM6x5tw1JiDE
 UNIY+TN73BA6DOEN20hdoOSfdXvxt0zRm+bTp5DTucHJYr5MOvG0vFLJz
 9YxN2Sjb3NDSO2sJ3vh2TSGaB3T73JtMpQueYfwtuHkZJXekoumq0KMAn
 ajn+e00YIKPbLB6glMEy9SSTa9sJEMoU88iTXJ/u8c13YYKwueA/eSakF
 vEeBEMcvVa6mpjBaPRhvnV6H8u1xP3dAVfGQ4aRUTt+A+9k2fwgdNXoTn g==;
X-CSE-ConnectionGUID: 9/HbpV7uTcuCIE+vBLVn5Q==
X-CSE-MsgGUID: jVCAkFdXQdu9eIDehY9BWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="104475575"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="104475575"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 12:23:19 -0700
X-CSE-ConnectionGUID: FMiw3kJQQ+GXszeXr56kVA==
X-CSE-MsgGUID: 98rDPy/aQGKFlSmg6grkhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="250236458"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.162])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 12:23:14 -0700
Date: Tue, 9 Jun 2026 22:23:11 +0300
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
Subject: Re: [PATCH v4 14/14] video: leds: backlight: lm3533: Support getting
 LED sources from DT
Message-ID: <aihoH9Pmzufa9pnE@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-15-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606045738.21050-15-clamor95@gmail.com>
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

On Sat, Jun 06, 2026 at 07:57:38AM +0300, Svyatoslav Ryhel wrote:
> Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> defined in the device tree.

...

>  static int lm3533_led_setup(struct lm3533_led *led)
>  {
> -	int ret;
> +	u32 output_cfg_shift = 0;

No need to assign the default to this.

> +	u32 output_cfg_val = 0;
> +	u32 output_cfg_mask = 0;
> +	int ret, i;

No need to add 'i'.

> +	if (led->num_leds) {
> +		for (i = 0; i < led->num_leds; i++) {

		for (unsigned int i = 0; i < led->num_leds; i++) {

> +			if (led->leds[i] >= LM3533_LVCTRLBANK_MAX)
> +				continue;
> +
> +			output_cfg_shift = led->leds[i] * 2;
> +			output_cfg_val |= led->id << output_cfg_shift;
> +			output_cfg_mask |= OUTPUT_LVLED_MASK << output_cfg_shift;
> +		}
> +
> +		/* LVLED1, LVLED2 and LVLED3 */
> +		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF1,
> +					 output_cfg_mask << OUTPUT_CONF1_SHIFT,
> +					 output_cfg_val << OUTPUT_CONF1_SHIFT);
> +		if (ret)
> +			return ret;
> +
> +		/* LVLED4 and LVLED5 */
> +		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF2,
> +					 output_cfg_mask >> OUTPUT_CONF2_SHIFT,
> +					 output_cfg_val >> OUTPUT_CONF2_SHIFT);
> +		if (ret)
> +			return ret;
> +	}

...

> +	if (led->num_leds > 0) {
> +		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
> +						     led->leds, led->num_leds);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to get led-sources\n");
> +			goto err_deregister;
> +		}
> +	}

This and other pieces may benefit from local variable

	struct device *dev = &pdev->dev;

defined at the top of the function.

...

>  static int lm3533_bl_setup(struct lm3533_bl *bl)

As per above.

-- 
With Best Regards,
Andy Shevchenko


