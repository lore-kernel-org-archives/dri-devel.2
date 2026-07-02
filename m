Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52745C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 965AD10EA45;
	Thu,  2 Jul 2026 16:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iGC65vUG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D4010EA45
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:12:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D39242A03;
 Thu,  2 Jul 2026 16:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CEC1F000E9;
 Thu,  2 Jul 2026 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783008777;
 bh=jgZ5PGASijShP5pC5l8zHhdOpozcuS9KxV5TuCHWvA4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iGC65vUGDqogOIGJx6iAzvePK4nQgsbNW6n2puBfcxRlF/iW6l85Ti0n4337btxCs
 AAhgmXx0m+4kppoTDcvJUeuFBYvHbveuMHtPWIDt/aLgi/W5g766w4uHI4NCNLbY+Y
 o55EovSIK51IrXtGhUckpB+JwHC/yjMiyxVG9I3HanKrV69OXNsstHmewI3Lk7N+9H
 pr04fOotyHQtLJ29VRJPP56stS74kaIr7IL2eOM6AeMlWINKJJ75OVokh38/8Auf08
 9hDw9O4qyE8W2H15CY0fDS69UReoN+tPNueMI79ooE1XbbQNBgcic36HvhYi35cUzn
 8Vdoq7K2fGplg==
Date: Thu, 2 Jul 2026 17:12:51 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 Daniel Thompson <danielt@kernel.org>,
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
Message-ID: <20260702161251.GA2108533@google.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-3-clamor95@gmail.com>
 <ajJ30lHG5lEXri7I@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajJ30lHG5lEXri7I@ashevche-desk.local>
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

On Wed, 17 Jun 2026, Andy Shevchenko wrote:

> On Wed, Jun 17, 2026 at 11:00:19AM +0300, Svyatoslav Ryhel wrote:
> > Remove driver-specific regmap wrappers in favor of using regmap helpers
> > directly.
> 
> OK, let's go with this variant.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Some side notes below for the record.
> 
> ...
> 
> >  	struct lm3533_led *led = to_lm3533_led(led_cdev);
> >  	unsigned enable;
> 
> Oh, besides using the old way of declaring unsigned int, it most likely
> just needs to be kstrtobool().
> 
> >  	u8 reg;
> > -	u8 mask;
> > -	u8 val;
> >  	int ret;
> >  
> >  	if (kstrtouint(buf, 0, &enable))
> >  		return -EINVAL;
> 
> We should unshadow error codes (it may return more than -EINVAL).

Right, this masks -ERANGE.

We should fix that.

> >  	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
> > -	mask = LM3533_REG_CTRLBANK_BCONF_ALS_EN_MASK;
> >  
> > -	if (enable)
> > -		val = mask;
> > -	else
> > -		val = 0;
> > -
> 
> ...
> 
> > -	if (kstrtou8(buf, 0, &val))
> > +	if (kstrtou32(buf, 0, &val))
> >  		return -EINVAL;
> 
> Like in the previous case we should unshadow error codes.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Lee Jones
