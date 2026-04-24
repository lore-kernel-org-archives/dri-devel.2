Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A590AFE51F5
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B99D810F485;
	Fri, 24 Apr 2026 09:38:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Rw9NWs8J";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 486C010F47E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777023530; x=1808559530;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=avwJV/Zc9vgx6d4vXiWKmwklGRqAQzwWkTaaoTqstbk=;
 b=Rw9NWs8JGtRRtiD4h3ROlHFBEpnpaGNKi2c2mSu0KHi2nBsW+/O/Rhem
 mlbvHL1xX7palRJHuDFVuWLdrZKEOxr3V/yrCKlF3mF9VCIc5JBX6DpWB
 oC6OZM/tTUynKhk4YaFthi6g/Pt8OGWqWU37Py+IJeYyiwxl2zQcmh0C0
 4tF1LSpjdarV5ofiItcRkF7hAxwomTj+G+TM/wQmhCi/u7KINGPGeoxPt
 BmbZURwUYZ4PNjFwWakukMHwqIyP2ilUew4Db75NwdhnD43PhzOrQsLak
 xP+9WsbKddaIsqZOOiI6aivdKWaK1eHyzQKBjtvMuV1TTJan/KmR+XReu A==;
X-CSE-ConnectionGUID: BEKwtG04RCSFwPFUjMSNsQ==
X-CSE-MsgGUID: 9lL0rH9FQ1aRAHeZSPfxHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89385609"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="89385609"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 02:38:50 -0700
X-CSE-ConnectionGUID: Y/IR1RYtSGuwgcjP8vnOug==
X-CSE-MsgGUID: /cTZSaDwR4CzRkjjkfwQCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="271031942"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 02:38:48 -0700
Date: Fri, 24 Apr 2026 12:38:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fbtft-bus: replace function-defining
 macro with concrete functions
Message-ID: <aes6JY3Ht6p1VpFa@ashevche-desk.local>
References: <20260424092818.3322248-1-hossu.alexandru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424092818.3322248-1-hossu.alexandru@gmail.com>
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

On Fri, Apr 24, 2026 at 11:28:18AM +0200, Alexandru Hossu wrote:
> The define_fbtft_write_reg macro defines full function bodies including
> a goto statement and a trailing semicolon on EXPORT_SYMBOL(), which
> violates kernel coding style (checkpatch reports 2 ERRORs, 2 WARNINGs,
> and 5 CHECKs).

OK.

> Replace it with three concrete C functions that are semantically
> identical to the macro expansions:
>   - fbtft_write_reg8_bus8   (u8 buffer, u8 data)
>   - fbtft_write_reg16_bus8  (__be16 buffer, u16 data, cpu_to_be16)
>   - fbtft_write_reg16_bus16 (u16 buffer, u16 data)
> 
> The function declarations in fbtft.h are already present and unchanged.

I'm not sure this patch improves the code. What I see it's harder to follow.
NAK.

You can consider different approach(es), using _Generic() or so, but I forecast
that none of them will be better than the current code.

You also can address just a small chunk of that, exempli gratia, moving out
EXPORT_*() along with some wrappers leaving the main body of the macro
untouched. This might be a compromise. Dunno. If Greg has no objections, you
can try it out.

-- 
With Best Regards,
Andy Shevchenko


