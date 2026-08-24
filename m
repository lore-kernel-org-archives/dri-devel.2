Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C008C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 09:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5365410E6AF;
	Mon, 24 Aug 2026 09:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="NOe53Yts";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2192610E6AF
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 09:17:21 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so2848148f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787563039; x=1788167839;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1KWOdEO9XQSV3ds07vANFxSNMOkEh8mcBPlw2ud0ZcY=;
 b=NOe53YtsO41SlU8zQunmkiwfR2hZHnXmchi3nPrPc1GG4pXoLqVn21v1Y/0Akh8h3J
 64hnetjvmgtVc8zazKkILZnlrkRmPQyuLeTQX9rLSOTow09S8mUUYNhSSwmMX2Oh+6YI
 5nz5tPO15I3p710TU04vfz3J0HAf7KnKSQ1pSqEpLPCNkAnhf7uAl5teF3uTSSkcXYjv
 2NzuT0puOcgKyFyXugsXm5355VqnmQeYTAzjb2/j1W+ndPw+GgyFqRgVo06bVsn8ZhbK
 Nyr6xy5xX4UVFq3ANP7v0hU4yMJqyYUV1fGpE0ZEKBMhMtn9X/4e5FtkIpjZqE59nbUZ
 uvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787563039; x=1788167839;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1KWOdEO9XQSV3ds07vANFxSNMOkEh8mcBPlw2ud0ZcY=;
 b=ay0oVYgeYWxhI5Ov4sbGfcrtSp6LLTLETl0bO3QZNAyGn6P2g4ELaHD5wl9JjBJ2S/
 khn8FTARAHHYGKHCL3cLpZ2n6e+wDV9/aMvS2dosYaG/pH93mkJI2uxdaGXo30vF2+33
 sR90aFs6DyUp80XKPuROk10+GRF2ra21WodK1JJGFzkTC/a7SFqc4HR8x/yFSVewIgU3
 3vp1zNGLpcyKRmn0jvS2Yp3lmWivWXT7Fu/Z6bG/CGCklk5aVC7NO6UbqhqKJ0jgsi5Y
 ykN6EIVlVE8+bzaiR0i+GopA2qQCYd+TK3qIE+u+cs7UWhuQKeHu0y0jJcYcggPHNcKb
 EFJg==
X-Gm-Message-State: AFuF++nHhOlUzPb9SSqLUO7VTRP24WqdHnYZIJJTIojoBP1kuQd4zdng
 cUrioBp6u3ShawqylX5ftXNGhjPpTXuyVW3tXK8az6A7cD0C60VNqD1N7F/hdKRc69w=
X-Gm-Gg: AR+sD13mWbib4oPzLNqdjmovqSYSI31Obh7tdsDPaAr2uCeCD/oON13kE+DnRDmDs0A
 9irSU/e1kCm2L2bMr7VCcTJBgqGnae9fPSKZuRBOaPW2pJZsQI364Fqa77MGqKF3jTtA8CCaviz
 Moueq0unGtbeAtuaYOWeZirvtJBhRkZVEmHGgDKHGhpcKjsxiagUtrD9SuULG5ImTyaOdJA29N4
 gdJUT79ajIGigQteeztz2u9luHaJNukgCDzxBBVjIkv2CFCD4XcKViC1SVdS+LChpdh1aNng5vF
 7HoLVFZ4mpedjlVqitFU2vIg8Ti27tzbqT3kgfbM3eXInWVqk2HBiTBapgWktYLUdkH8ItDsFYR
 EOIL1uiDvAIAsadw2wwuiLssEJFYqjHCgLmjwud0Ug4u3ncfEMU97HoW1f8bhqGBW8K+4HOKIEo
 PIVqbEIL+h+Hj0rN8lIuaXGcmK5fGsxkdhkEk2RyBrT04vphEyOpBv4F0t9fpueXZYN4deIEYDG
 +tCzRKKPmsWiXrV5B9MReMxiVdSq6GMSKOM7eCr5c0QDL8nRUvVx39doHOnULTM9y7MGKo7cLcV
 nrgTcVAqg02l0X7IzGh4Wg/SVSHAo19H400hpxKZgguPKTwBnf6xSEe+
X-Received: by 2002:a5d:59c6:0:b0:47f:773f:2d68 with SMTP id
 ffacd0b85a97d-482c0ba3307mr32820982f8f.16.1787563039461; 
 Mon, 24 Aug 2026 02:17:19 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9bfd2bbsm7567131f8f.18.2026.08.24.02.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 02:17:18 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:17:17 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: led_bl: Add devm_led_backlight_register()
 helper
Message-ID: <aowMHRSOg82oSBmV@aspen.lan>
References: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
 <20260817170817.1933046-2-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817170817.1933046-2-alexander.sverdlin@siemens.com>
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

On Mon, Aug 17, 2026 at 07:08:14PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> The led-backlight driver could so far only be instantiated from a
> device-tree node with the "led-backlight" compatible. This makes it
> impossible for a self-contained LED provider (e.g. a hot-pluggable I2C
> LED controller) to expose a backlight interface tied to its own
> lifetime.
>
> Factor the actual backlight registration out of the probe path into a
> shared led_bl_register() helper and export devm_led_backlight_register(),
> which registers a backlight class device driven by a single LED, without
> device tree and bound to the caller's device lifetime. The backlight
> device and the LED sysfs handover are now devres-managed, so the probe
> path shrinks and the explicit .remove callback is no longer needed.

Please can you split this patch into two pieces to make review easier.
One to introduce make the backlight device and LED sysfs handover devre
-managed and the other to introduce devm_led_backlight_register().


> diff --git a/include/linux/led_bl.h b/include/linux/led_bl.h
> new file mode 100644
> index 0000000000000..e38e4d62bf653
> --- /dev/null
> +++ b/include/linux/led_bl.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_LED_BL_H
> +#define _LINUX_LED_BL_H
> +
> +#include <linux/kconfig.h>
> +
> +struct device;
> +struct led_classdev;
> +
> +#if IS_REACHABLE(CONFIG_BACKLIGHT_LED)
> +int devm_led_backlight_register(struct device *dev, struct led_classdev *led);
> +#else
> +static inline int devm_led_backlight_register(struct device *dev,
> +					      struct led_classdev *led)
> +{
> +	return 0;

This should not return success; it has not succeeded in registering a
backlight.
> +}
> +#endif


Daniel.
