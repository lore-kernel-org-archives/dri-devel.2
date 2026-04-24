Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3413FE51F3
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 224A310F47E;
	Fri, 24 Apr 2026 09:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O+R98wwJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ABDE10F47E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777024035; x=1808560035;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aPZVVYExj8rGj87x79G1gLFlc2CTnEiwGYRXX2rdONg=;
 b=O+R98wwJRIUYpq3w+bATkte7vBKdvOLKbI849eRDygaYZK+chaZWkB/R
 97ROtJH38Y9ktUp9ERxxAFhC0uSWMuEfO6mg74SMtS+yA6U1ExEn9cV7f
 UlOBYFggArZonmTrVtUDqbmvXfrQcELyNqbLuFLEosofLscYbCYdnhBwA
 dbTZx3OyBv87jdvde/avYMGYiyYAbprf7rTHHFA8G7Jim1dF/sVqu9DTm
 POtRIg5lvI0sxZtBWiGyEJwrZjlY2Wg5+skLxyz4WXBx8dV+hfnVNicOY
 Dv32Q99qlg8us/dGPOmwNNqNXVDjKBiGYnZFPS84VADuOUXYf7KP5MRWQ g==;
X-CSE-ConnectionGUID: mgSIIxYPSbOym9eL6AHqHw==
X-CSE-MsgGUID: GhRLUrU7R3Sg1bRI6g0Q7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77989075"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="77989075"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 02:47:14 -0700
X-CSE-ConnectionGUID: scq+gQnQRFyvh1xiinS6CA==
X-CSE-MsgGUID: B2qnFBHfQpmKXHizg2k0GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="237912542"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.71])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 02:47:12 -0700
Date: Fri, 24 Apr 2026 12:47:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fbtft-bus: replace function-defining
 macro with concrete functions
Message-ID: <aes8Hql5Y6MrRD-l@ashevche-desk.local>
References: <20260424092818.3322248-1-hossu.alexandru@gmail.com>
 <aes6JY3Ht6p1VpFa@ashevche-desk.local>
 <69eb3b01.5d0a0220.3c3ebd.f35b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69eb3b01.5d0a0220.3c3ebd.f35b@mx.google.com>
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

On Fri, Apr 24, 2026 at 09:40:48AM -0000, Alexandru Hossu wrote:
> On Fri, Apr 24, 2026 at 12:38:45PM +0300, Andy Shevchenko wrote:
> > I'm not sure this patch improves the code. What I see it's harder to follow.
> > NAK.
> 
> Fair point. Three near-identical functions hide the pattern the macro
> makes explicit. I'll drop this approach.
> 
> If there's appetite for a minimal fix, I can send a v2 that moves
> EXPORT_SYMBOL() outside the macro body only, leaving the function
> definition untouched. Otherwise I'll leave it as-is and wait for
> Greg's take.

You can try that, as I said it would be a compromise because at least I agree
with the awkwardness of having EXPORT_*() be hidden by the macro.

-- 
With Best Regards,
Andy Shevchenko


