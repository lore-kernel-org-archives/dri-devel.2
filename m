Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9ACC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C602310E0CB;
	Mon, 29 Jun 2026 15:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MttTyO8L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81B310E0CB
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782746608; x=1814282608;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ikG8LyC1XcdBJf6tJzF7Bt/BQgmZRgtL19n+WxN3KCI=;
 b=MttTyO8L1ct2KvTGJaLRWCVwN4SGxjOmgbnzswLlWgeVBPQztTpu7zLz
 wsrnu0grXvnBch0n7/+Cl3tMFTvh7teNu57Kor2zEq2CCYhQ7XC04xx0k
 vHSJmGfmQUXLv8Z1OaqA+i3ATFtt0fC62JhMwpvPxzKzdLySvjIWWiQ5l
 dPyrrI1d27HLaE4EPVg9xSk3VpRnuCLvdNH3IZeX3b5RvXqOiUA2jphGn
 At4GQ1cJyqlQgzGB3K6rBFOMJWwyY5cZxVBdvVnnqEI4PfJ6YB752Rsl9
 utHl3TVPTXwyX9wRbZTmK+P2n+TGc58ppdron3g+Mxc36nAmsfrGGzgpe g==;
X-CSE-ConnectionGUID: MQK6hJZYTuGU/SG4TzstpQ==
X-CSE-MsgGUID: za1YIg75QSKGcTXUYLNtFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94023540"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="94023540"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 08:23:26 -0700
X-CSE-ConnectionGUID: 7N2MW441QaazjVGcO5Si8w==
X-CSE-MsgGUID: QtCGyfNORrCYVEX/UtpPDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="245635032"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.207])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 08:23:22 -0700
Date: Mon, 29 Jun 2026 18:23:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Marcel Holtmann <marcel@holtmann.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andy@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ulf Hansson <ulfh@kernel.org>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
Message-ID: <akKN59lv55CXS3HU@ashevche-desk.local>
References: <20260629135917.1308621-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629135917.1308621-1-arnd@kernel.org>
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

On Mon, Jun 29, 2026 at 03:56:29PM +0200, Arnd Bergmann wrote:

> Most remaining users of desc_to_gpio() only call it for printing debug
> information.
> 
> Replace this with a new gpiod_name() helper that returns the
> gpio_desc->name string after checking the gpio_desc pointer.

Oh, that's nice!

...

> +/**
> + * gpiod_name() - get a name to print for a gpio descriptor
> + * @desc: gpio or NULL pointer to query
> + *
> + * Returns:
> + * The desc->name field or a dummy string for unknown GPIOs.
> + */
> +const char *gpiod_name(const struct gpio_desc *desc)
> +{
> +	return desc ? desc->name : "(no gpio)";

Can we get into here with wrong (error pointer descriptor)? Shouldn't you call
one of validate_desc() / VALIDATE_DESC()?

Also not sure if "(no gpio)" is a good choice. "not requested"? "not provided"?

> +}

...

> +static inline const char *gpiod_name(const struct gpio_desc *desc)
> +{
> +	WARN_ON(desc);
> +	return "(no gpio)";

Hmm... This will be a second copy with a slight potential of going apart from
the other case. Perhaps a #define? (Yes, yes, I understand that there are pros
and cons, in particular readability with define is questionable.)

> +}

-- 
With Best Regards,
Andy Shevchenko


