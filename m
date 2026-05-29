Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386C2CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C57610FD11;
	Fri, 29 May 2026 11:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="jAsUQYmy";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5822F10FD11
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:00:18 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-45eec22fab7so866860f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780052417; x=1780657217;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=18we3XaF38yQ3wAMs5IOP6Gxb6jY92eB45OuWFEEzvE=;
 b=jAsUQYmyUfCA3vkB3VT3VEwg1sde9TRQOYQ7BZlO5Abbq+KHeb0S5kjGhrmkZDYkfy
 GnscPNCcCjlrKTvB9MTwvphj+2KjWmqwG1Dw1HPJ7XXf0DvP1uuwlsqbnwvlafFf1+IP
 lKJu2TG4/DHn/65p5dz8Rsn17LUV7Jaer6GFTHxhX4L6mi+gpKvsxnYUPwHEqOW//AwI
 la5hd4JbwEEUFVEqwA2hvjrihgP5tUzvuGOJt8kY6eY+C8kNmsTIOe9ukl65ewcgjeWH
 8p95MYqOSglgJJSzIvRVINiWWFChli/0j9tTtqoaVjSKJovamwDYKmDCdt8twGYWGOf8
 2fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780052417; x=1780657217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18we3XaF38yQ3wAMs5IOP6Gxb6jY92eB45OuWFEEzvE=;
 b=IcZA3IhkdCIPjKA8p6RDmBHIuxtNKfOJDyVZjRg2+6JQbPqUk+CGH5U24mbdMLp951
 YlYkRXpJIWnbGOcAtPz7XlCMrV04jvaeX4bEWjUQ14RDVyokbow/B6U6Tp2rYxFSTugX
 psIXrvOM3yQP3p3fuhn9QZ+nQ8rqL9obNScz7hT8krsNaxGPap6Y9kH5rCEbXiVMHJus
 +5uPfbsucAB4aZl/37wlIu1V2NnkF9OKTeKb0wKo1q0isCc8JJfxaSMURKOkmhBB3LC6
 r0/2/ErDk9kdR2Sg7ieMxWM26+Lkys8LwIHjNHYvyI6k0n5vPmWZlcD3a6AGs4udeHty
 4wtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+F/jzLRYlEE7GHRxplpEG9zrCsEJGIfURJ4akh2kPupfMXyzbEaNZG/5gEXrcTKKm11WCbscQEJpU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXrdt8f8YEWt3/HGrikJur04wpZZ7OYosGnWnOHmWNxyvRBESg
 eiRHg/qPWkoQwX1tqcUoGJbC9ANNhKAHoFOMe7oiSIZdlshbF151zWTAwy3tzoQ9/3s=
X-Gm-Gg: Acq92OG48LDCFYT3jnX+LSFKYElal4m2i9gtle8MIrcuM92JUqjIyVxYy/5bbjK6AiJ
 4PA/L76Qi7cihmsw/LPQczeL7gAc519/d092gMvIwNeeMsWkssqFC7muuJjR5XMj1FPiZP6p3Tz
 NSnnVtMgWwZ5fYTNIMBtF6PeuNkmSJUpIHghmbt9Cg1FKYgj2/cdCg5eD1kBGq3ei/Kmo2pX//9
 jC5jW+fOYk6ODmjDkWtAZja9FnQ8OUB+qfbVlOBz7STsN7G+WDRRTwx6GVX91xspMXDLDHKkU2e
 5M4j1vsVjChG8Ye20Ye17px33FgH8n6GhBrVvlo2eHh9FIn1cuEL7cjwxegqbjVQLv1aN1Ywmt+
 tebhHXXcyAUSIMkDA5sgfDNCz6gi7QY5YVmvSdsOJu9T3t4Yld8+0SsZ+XqV4uJKdW77ZWQus/1
 9t8RpAzHOaNks1goA4bj+rZ++ACFX5yXW+D9H/91Jk6pFu4JMk2yxuC9OYT/NRwkLvl58pNr+7h
 f0uSRDcoFMbcNscMylJN6vjTik2fPVjy569BL4zHrneylsH1Kl85Krdl6EsPE10/KQAYhV1EfTb
 JcMNoj4L+zbniWHvIEV/m4nAfHgLnA==
X-Received: by 2002:a05:600c:630f:b0:490:845d:652d with SMTP id
 5b1f17b1804b1-4909c0ba3dbmr44464495e9.15.1780052415386; 
 Fri, 29 May 2026 04:00:15 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6975e2sm49548585e9.6.2026.05.29.04.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:00:15 -0700 (PDT)
Date: Fri, 29 May 2026 12:00:12 +0100
From: Daniel Thompson <daniel@riscstar.com>
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
Subject: Re: [PATCH v2 2/6] mfd: lm3533: Convert to use OF bindings
Message-ID: <ahlxvGRVFDFrTUN3@aspen.lan>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528135123.103745-3-clamor95@gmail.com>
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

On Thu, May 28, 2026 at 04:51:19PM +0300, Svyatoslav Ryhel wrote:
> Since there are no users of this driver via platform data, remove the
> platform data support and switch to using Device Tree bindings.
> Additionally, optimize functions used only by platform data.

The last sentence is a little vague and makes us have to hunt for the
changes in a relatively large patch. If it is referring to the change to
common up the init and update code then it's would better to say that
explicitly!

> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/iio/light/lm3533-als.c      |  95 ++++------
>  drivers/leds/leds-lm3533.c          |  51 ++++--
>  drivers/mfd/lm3533-core.c           | 268 ++++++++++------------------
>  drivers/video/backlight/lm3533_bl.c |  52 ++++--
>  include/linux/mfd/lm3533.h          |  51 +-----

Just one comment for backlight, below:

> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> index babfd3ceec86..42da652df58d 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -295,13 +293,20 @@ static int lm3533_bl_probe(struct platform_device *pdev)
>  	bl->cb.id = lm3533_bl_get_ctrlbank_id(bl);
>  	bl->cb.dev = NULL;			/* until registered */
>
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d",
> +			      pdev->name, pdev->id);
> +	if (!name)
> +		return -ENOMEM;
> +
>  	memset(&props, 0, sizeof(props));
>  	props.type = BACKLIGHT_RAW;
>  	props.max_brightness = LM3533_BL_MAX_BRIGHTNESS;
> -	props.brightness = pdata->default_brightness;

Given the big changes to the driver is there any chance of putting a
good value in props.scale (BACKLIGHT_SCALE_LINEAR or
BACKLIGHT_SCALE_NON_LINEAR)?

If the difference between 50% and 100% *looks* like 50% then the scale is
non-linear (since humn perception of brightness is not linear).


Daniel.
