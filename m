Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2D5CD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB43810E5D7;
	Tue,  9 Jun 2026 19:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OCn7kXGn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 285B710E5D7
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781032679; x=1812568679;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=MTwsqfpI91yD0Y/+0nOvP+mQrtShptVr2NvwI5cxpnA=;
 b=OCn7kXGnxujXwcPmUrC2R5vyMVOlqh7IiDCko1yC/fiS325+SL1mnE7H
 sIDul9AqFTRnWZMb4bIE3Q5rsSAT5QJDB8L4OkDd/EH0mtC5pyC/trx9u
 QnnDMrd+MiYbgtZ6GczD0zfzo784Jid5Cfw4aNwmOveA15z2QDHHXjj9G
 HhsdziRc+iz4jg7lgTitzDypnHvkDs9AoqVJoXbYDfBvYzeN5/otpwVu0
 F4BcnNEYvuWmh2QFfjJAFvKdUPwNAcTckRbwhGcbCFtJ83DcmUgSqUq76
 OlmOZurFRv1/hDeLrFXyo7QXEnwKfw4lM/k7aFWUThFf9EhgsPKV4BmXD w==;
X-CSE-ConnectionGUID: rdl/z4zMRqOSoKoZUeqfHA==
X-CSE-MsgGUID: 17JB9OuuSUWBf22fEPuw5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99227007"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="99227007"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 12:17:58 -0700
X-CSE-ConnectionGUID: HucDC72aTtue2Pp5rbNfxg==
X-CSE-MsgGUID: xJ6+Pb4NQQmRtoZsYTuqNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="276140448"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.162])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 12:17:54 -0700
Date: Tue, 9 Jun 2026 22:17:51 +0300
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
Subject: Re: [PATCH v4 10/14] mfd: lm3533: Set DMA mask
Message-ID: <aihm315UtdqJclhh@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-11-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606045738.21050-11-clamor95@gmail.com>
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

On Sat, Jun 06, 2026 at 07:57:34AM +0300, Svyatoslav Ryhel wrote:
> Missing coherent_dma_mask assigning triggers the following warning in
> dmesg:
> 
> [    3.287872] platform lm3533-backlight.0: DMA mask not set
> 
> Since this warning might be elevated to an error in the future, set
> coherent_dma_mask to zero because both the core and cells do not utilize
> DMA.

Hmm... I am not sure about this. The entire kernel has only two drivers that
do that, and thanks to their commit messages one of them pointed out to the
commit from 2018. So, if no other devices suffer from this, I think it has to
be a better way of achieving the same.

-- 
With Best Regards,
Andy Shevchenko


