Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064D1CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C9D10EA23;
	Tue, 23 Jun 2026 09:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YZTPqk47";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E2210EA23
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 09:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782205394; x=1813741394;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PPCpMq7lYRc/Iu6FOHaKbGMIYgwijB1RSueN/w0Qn5M=;
 b=YZTPqk47brywJZQzIPjKthF0j58+ifHQAdNgNGI79qIH/Ff9g5TEsuyJ
 ORiyhMOzsFAQd6H/Mkd6nEtrnfs7V8p0AWkmeQXU3Xn5qTd7ROR6CHL9q
 Y8DADY2fwD4bmk9gD+U6t8J6FFP+mAy/9q3J9413uPz6N9yyYw5PNUKlq
 jbrEjo/GSbkEBH1ga0Tt79OncL0GBwoZA2/aE6zv+OoxJqpiOAUdMmdSH
 oyvVK4rGlOpqKhXRFC780XXaz28go/IqGeRIo04dnZ7NEspPNPxNaVQ8F
 LNSBaACw2SpvMg3uOfwv7fk54mcgBZ4K+iFAuCRIBxQSKW5ak9fdI4DrR g==;
X-CSE-ConnectionGUID: CJSeRtgaT0OEuRQqHNI4rA==
X-CSE-MsgGUID: NcjEA2OCRyKmtckqQ0z1lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="93307768"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="93307768"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 02:03:13 -0700
X-CSE-ConnectionGUID: NBgyK0lZRCGMzmoTmLttMQ==
X-CSE-MsgGUID: +5fEtc7WSbOdM/6RvOjruw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="287598339"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.7])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 02:03:08 -0700
Date: Tue, 23 Jun 2026 12:03:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andy@kernel.org, gregkh@linuxfoundation.org,
 deller@gmx.de, azuddinadam@gmail.com, chintanlike@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/4] drm/ssd130x: Add RGB565 support to SSD133X family
Message-ID: <ajpLyronl7a-yxh-@ashevche-desk.local>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
 <20260622152506.78627-3-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622152506.78627-3-amit.barzilai22@gmail.com>
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

On Mon, Jun 22, 2026 at 06:25:04PM +0300, Amit Barzilai wrote:
> SSD133X screens were getting 8bpp (RGB332) instead of the 16bpp
> (RGB565) that they support. This change adds a boolean to the
> deviceinfo struct selecting whether the variant is driven at
> DRM_FORMAT_RGB565.
> 
> Changed SSD133X to now utilize 65k color (RGB565).

...

> -	 * Each Segment has a 8-bit pixel and each Common output has a
> -	 * row of pixels. When using the (default) horizontal address
> -	 * increment mode, each byte of data sent to the controller has
> -	 * a Segment (e.g: SEG0).
> +	 * Each Segment holds one pixel and each Common output has a row
> +	 * of pixels. A pixel is 8 bits (one byte) in the 256 color
> +	 * (RGB332) format or 16 bits (two bytes) in the 65k color
> +	 * (RGB565) format. When using the (default) horizontal address
> +	 * increment mode, the pixel data is sent Segment by Segment
> +	 * (e.g: SEG0 first).
>  	 *
>  	 * When using the 256 color depth format, each pixel contains 3
>  	 * sub-pixels for color A, B and C. These have 3 bit, 3 bit and
>  	 * 2 bits respectively.

Something wrong with the plural. There is a difference between "3-bit" and
"3 bits", but "3 bit" is odd.

> +	 *
> +	 * When using the 65k color depth format, each pixel contains 3
> +	 * sub-pixels for color A, B and C. These have 5 bit, 6 bit and
> +	 * 5 bits respectively.

Same mistake is repeated here.

...

> +	/*
> +	 * Per-variant output format selector for the SSD133X data path. The
> +	 * hardware can drive the panel in RGB332 (1 byte/pixel) or RGB565
> +	 * (2 bytes/pixel); this is a policy choice per variant, not a

In other comments it was spelled fully, be consistent "1 byte per pixel",
"2 bytes per pixel".

> +	 * capability probe. When set, the variant is driven at RGB565.
> +	 */

-- 
With Best Regards,
Andy Shevchenko


