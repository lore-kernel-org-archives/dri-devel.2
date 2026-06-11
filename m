Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E02CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A15F10ED77;
	Thu, 11 Jun 2026 08:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="I8odrmJL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F09B910ED77
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 08:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781164996; x=1812700996;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ok2uxm/+RAQD10yVIEOzY444cIER//V8tOb/oha4UDY=;
 b=I8odrmJLrvZqVTGm0/zyZJ0r0H0FaJ6/ZAfcQlGDWNORN6wWo16MbMvc
 k7YFnWIbbrqXqyd11oKbx4K3yOxhBWDERpyBlehrdNeYx0pTE9fvi2Yrh
 H7gATaPBYs5+yu10AAI2y0OK02EcYhH9uRZrFPgx0rfGv8fMERyEu/1qZ
 8d53ufzEVBIs8vV4hGoTeFF5ArA9BWVwB1CZ3vsEFv+LVAHPQ1jXXm3nX
 NSWCHUKgQhArQzXmCteV0/7ooWo9SmJQ/FQRNOmAOlTLTzSTFswFpPlr3
 fi3tb9RYHqPhOzlw8852SSgvsUQguOf7dUbLGhhcjPHDxPjuATjk1v48D w==;
X-CSE-ConnectionGUID: Qq2c1zxdRFuyDBcPyD23Fg==
X-CSE-MsgGUID: ++bYoKaoR1GYq/IWTjOYXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85869171"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="85869171"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 01:03:15 -0700
X-CSE-ConnectionGUID: YPsm1ZJRTO28vwiL+pNZiQ==
X-CSE-MsgGUID: 6+WXQ8+JTyCDmFqo5iVVuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="248284111"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.123])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 01:03:12 -0700
Date: Thu, 11 Jun 2026 11:03:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix typo in comment in fb_upd161704.c
Message-ID: <aiprvmR0jK4B1Q68@ashevche-desk.local>
References: <20260611-upd161704-typo-v1-1-2e51387c3b28.ref@yahoo.pl>
 <20260611-upd161704-typo-v1-1-2e51387c3b28@yahoo.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-upd161704-typo-v1-1-2e51387c3b28@yahoo.pl>
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

On Thu, Jun 11, 2026 at 09:53:40AM +0200, Tomasz Unger wrote:
> Fix spelling mistake found by codespell: "cencter" -> "center".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


