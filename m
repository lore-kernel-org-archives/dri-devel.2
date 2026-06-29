Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A075DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 06:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C2210E6DC;
	Mon, 29 Jun 2026 06:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WoKj80MP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC8110E032
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782713995; x=1814249995;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=M+CVXNbFxnYVUHiLO8p1f8U/Oa8yWKHeFEwwNFbVCw8=;
 b=WoKj80MPsCjuynuPYxwQfWg1HcpFMk+/4dryM/rOBrxPr3jNsIRzoLav
 JCxR/ZTc1PnX4R3nEBLH72Y+nH8i/ZxT0hsYTMGxzxUbml0nhD56T5ILf
 V1TYp8/uQW9x7IV+Bdd+m1+EzvCgGOxvvAl0R1GQE58W0Bl7H7Yv1Ot7J
 oOJeZe5lAQcBzEBObcvY4DFHwWQDPiVJSmhZVRK7BbRIFniHEDqHjlDtV
 P7ewzLVr2KwddTX7Q27yzOxgDV5a16IpmptJBFQVxTr7D0WIBXpkfKlBO
 /JVIQC+aqTVyTDE/gJArkYOAjj02SJR/FTfAIjyn/jUDDl/YCHGUzCuV6 A==;
X-CSE-ConnectionGUID: UHECHQ+dRz2U/1y8TzXFPA==
X-CSE-MsgGUID: xjMctChxRp+V6pzEyUu+vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="94544386"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="94544386"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2026 23:19:55 -0700
X-CSE-ConnectionGUID: WCXRpK0OR/W1yR4qCMVJog==
X-CSE-MsgGUID: JolV0ZvlTbKLpzL6HNcWGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="256271508"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.207])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2026 23:19:50 -0700
Date: Mon, 29 Jun 2026 09:19:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: airlied@gmail.com, andy@kernel.org, azuddinadam@gmail.com,
 chintanlike@gmail.com, conor+dt@kernel.org, deller@gmx.de,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, javierm@redhat.com, krzk+dt@kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v2 3/4] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Message-ID: <akIOhFZbATDY2vRf@ashevche-desk.local>
References: <ajpLyronl7a-yxh-@ashevche-desk.local>
 <20260628154312.46185-1-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628154312.46185-1-amit.barzilai22@gmail.com>
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

On Sun, Jun 28, 2026 at 06:43:12PM +0300, Amit Barzilai wrote:
> On Tue, 23 Jun 2026 12:37:31 +0300, Andy Shevchenko wrote:

...

> >> +	const u8 cmds[] = {
> >
> > Why not static?
> 
> This array can't be made static. It is initialised with runtime values
> (ssd130x->width - 1 and ssd130x->height - 1), so it is not a compile-time
> constant and a static/file-scope definition wouldn't compile.
> The other ssd13xx_init() functions are non-static for exactly the same
> reason.

Ah, I see. Thanks for pointing out.

> >> +		4, SSD135X_SET_CONTRAST, 0xc8, 0x80, 0xc8,
> >> +		2, SSD135X_SET_CONTRAST_MASTER, 0x0f,
> >> +		2, SSD135X_SET_PRECHARGE2, 0x01,
> >> +		1, SSD135X_SET_DISPLAY_NORMAL,
> >> +		2, SSD13XX_SET_SEG_REMAP, remap,
> >
> >> +		0,
> >
> > No trailing comma for the terminator entry.
> 
> Removing it in v3. The other init arrays in drm-misc-next still carry the
> terminator comma, but that's pre-existing code outside this series -- I've left
> it alone to avoid unrelated churn. Happy to send a separate cleanup if you'd
> prefer.

You can issue a separate cleanup patch for those.

> >> +	};

...

> >> +	/*
> >> +	 * ssd130x_power_on() issues a short reset pulse, but the SSD1351 is not
> >> +	 * ready to accept commands immediately afterwards. Give the controller
> >> +	 * time to settle before sending the init sequence.
> >> +	 */
> >
> > Any reference to the datasheet?
> 
> It's not a datasheet figure. fb_ssd1351 doesn't do it in init_display() either;
> it inherits it from the shared fbtft_reset() helper, which deasserts reset and
> then does msleep(120) before any command is sent. The 120 ms is a generic fbtft
> blanket value, not an SSD1351 number -- the SSD1351 datasheet's reset timing is
> microsecond-scale.
> 
> I removed the msleep() and retested this on the hardware. The panel still 
> initialises reliably.
> I'll drop the msleep() in v3.

Yeah, I truly believe that this long delay is for the parallel type of IO, where
data and control signals are usually connected to a quite low speed GPIOs.

But I suggest to leave some comment in the code.

-- 
With Best Regards,
Andy Shevchenko


