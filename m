Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF3CCD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 07:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C33F10E1A7;
	Sun, 17 May 2026 07:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YNDxb9WS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB4110E1A7
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 07:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779004759; x=1810540759;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RCztGsesV7QNXwOx6El2gib8koFC1gVYlbosBrs9hB4=;
 b=YNDxb9WSZmdjmNUum8BR14IvD3MBggsiV19f+RwWU9Dgb3SnjvlufJrb
 6PZgRGETM2R95PLg1qZYQ4YZffMlnvWviAXrh72L966Ijzf6FeaTfX2oM
 PyGM7Tu9WYOH4hS4uxgGBMrklxOHgxzQEeGhucJRl0xr5yDRuFA9u+c6u
 VcUSErpPOlB4mkxPm4jFZs+tK0uJJmvvptblbc3gXkZIXatMfIFLE8tae
 Eccu0ksb04qHFhAsOTjFxOIFqhGqcVbuyaSX0qC5wF4B00IBAZVmlFOVL
 UPYklh4dY6RF8JAwkXN6bo1OPTynr9wWC1PY3shZChLIdCm0fUGCoNivf g==;
X-CSE-ConnectionGUID: DrBgJTqKScGWs9TdX2lUTA==
X-CSE-MsgGUID: hl+aiHwxR9yTR7Po6veVIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="90995772"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; d="scan'208";a="90995772"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2026 00:59:19 -0700
X-CSE-ConnectionGUID: fEhjprTLT9GHbm5HCE3P9Q==
X-CSE-MsgGUID: 632bb8nxSsKUq/xhD4M5Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; d="scan'208";a="232733648"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.182])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2026 00:59:14 -0700
Date: Sun, 17 May 2026 10:59:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 0/6] mfd: lm3533: convert to OF bindings, improve
 support
Message-ID: <agl1T8O6kwP7SFZ1@ashevche-desk.local>
References: <20260517074306.30937-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517074306.30937-1-clamor95@gmail.com>
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

On Sun, May 17, 2026 at 10:43:00AM +0300, Svyatoslav Ryhel wrote:
> Convert LM3533 to OF bindings, add missing VIN supply, add support for
> setting mapping mode and LED sources based on device tree. 

How is this being different to
https://lore.kernel.org/lkml/20250218132702.114669-1-clamor95@gmail.com/
?

What about this comment
https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
? Have you talked to Bjorn A and Johan?

-- 
With Best Regards,
Andy Shevchenko


