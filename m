Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D560ECCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CC210E959;
	Mon, 19 Oct 2026 09:59:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1BC10E969;
 Mon, 19 Oct 2026 09:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792403934; x=1823939934;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FCF+CStTLQKo129wcMJjO9zPQelHyhJZb6dyEUr5q7k=;
 b=e4nwNIKaUVbDN50Wdgdp0BrJANLCNqBsGbFd1NAKEl9Xv51svADuVnCB
 XQGDbPsZNsouM0xTMZOxJW+vK35MxaWif9KSH7vgbIw9RMqOJMM/sjeJF
 9yYhR8Wwoe7a79aeDD3oXjQ1WRzuIVzKSF1lfxW6TqNkt0OqxRZep5wlF
 SVHRiZY/uck9smPu5V3pRfkGhNFRr/vJ0GZsJMfO3d84LNsbXCdb/qP1I
 9Lf6b1HeDV/Mjg/9g6nrWA5YhTU0SxzfWqQZRN4h1I79NC7BTu/zGQ52J
 uQkOYO4U+bs5pl8Pj9LsP7FiZXtzf2JDEfyJyz2hHI4S1kWzHsNMVjQwM w==;
X-CSE-ConnectionGUID: ZiMtETPmTAmjF/tkxSlL4g==
X-CSE-MsgGUID: Dww92uzlR2WZQhoQxb4E6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1103099"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1103099"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 02:58:54 -0700
X-CSE-ConnectionGUID: 7uDefMOhT1e07ff2UgJhDQ==
X-CSE-MsgGUID: oZGsXOw8Qty5qXALoo+IuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4277332"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.209])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 02:58:51 -0700
Date: Mon, 19 Oct 2026 12:58:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mwwa919@gmail.com
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hans de Goede <hansg@kernel.org>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dsi: Use owned panel/backlight GPIOs in VLV
 MIPI sequences
Message-ID: <atXp2NSPKZUPj8sq@ashevche-desk.local>
References: <20261018-vlv-dsi-owned-gpios-v1-1-3ca18bcda670@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018-vlv-dsi-owned-gpios-v1-1-3ca18bcda670@gmail.com>
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

On Sun, Oct 18, 2026 at 04:12:40PM -0400, Mike Anderson via B4 Relay wrote:

> On VLV with PPS_BLC_SOC, intel_dsi_vbt_gpio_init() requests the
> backlight and panel enable GPIOs (INT33FC:01 pins 10 and 11) for i915
> itself. Since commit 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV
> GPIOs behind the driver's back") the GPIO elements of the VBT MIPI
> sequences also request their pin through gpiolib, so when a sequence
> toggles one of these two pins the request fails and the toggle is
> dropped:
> 
>   i915 0000:00:02.0: [drm] *ERROR* GPIO index 10 request failed (-EBUSY)
> 
> Before that commit the pad registers were written directly, so the
> sequences could still drive the pins i915 owned.
> 
> The Toshiba Encore 2 WT8-B (Bay Trail, DSI panel) uses pin 10 as the
> panel reset line: MIPI_SEQ_ASSERT_RESET drives it low and
> MIPI_SEQ_DEASSERT_RESET pulses it high-low-high. With every toggle
> failing, the panel is never reset after i915 sends MIPI_SEQ_DISPLAY_OFF
> during takeover and stays black, even though the backlight PWM and both
> enable GPIOs read back as on. The tablet only has a usable display
> with nomodeset.
> 
> When a VLV MIPI sequence targets pin 10 or 11 and i915 holds the
> corresponding descriptor, set it through that descriptor instead of
> requesting the pin a second time.

Ah, nice, this should be solved via using reset-gpio, which is exactly fixed
for the reset shared lines case.

-- 
With Best Regards,
Andy Shevchenko


