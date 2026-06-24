Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B02FCDB471
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786B710EED6;
	Wed, 24 Jun 2026 11:31:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jeRwc/BI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8023310EEAD
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 11:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782300701; x=1813836701;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=d5HyWw/v+MgocWmiFJGhqAbm8vl8c80N0u9O+M8mTY4=;
 b=jeRwc/BI8SgeDewSC/n9612i9u3LA8N3SVR3hv5VlZaJTUrHyH6IvKhP
 uh432QOsvxJ+7CtF48jGPJPJoIzI3B/wRTAQxNzSthQv8gLgNMJ8qy8Tt
 96npC/g5iygYulStumTLxq3i7Dr2pcDzxiYmlJ2MWMiLokCd2FZjB1ZyD
 6b1QGOk9QVUwwAj2ZmsVybPinpYtp02IAb3dLDFISN/baIN4uY0mp/mAs
 whhxOoYpW5du4LwNPwNj0EEtBJQW6aIARuuratP8Ig/2wXhe8CHwA0WYl
 ez2y1opgILbUdbCLB3U6nrF8Uwe5PeFc8lhlxg9zsS4XNXAtPMomlatdd Q==;
X-CSE-ConnectionGUID: Mbgtg+vmQAWh6PIV+3kjsQ==
X-CSE-MsgGUID: mJ9lbh1mSwqZDv0V1Fw8Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94454227"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="94454227"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 04:31:41 -0700
X-CSE-ConnectionGUID: OFM21aTwQy+Fi8Ylpx5HTw==
X-CSE-MsgGUID: GLjjPo9NSSS9kKrITL0FQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="254791087"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.156])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 04:31:39 -0700
Date: Wed, 24 Jun 2026 14:31:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joyeta Modak <joyetamdk@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: use ARRAY_SIZE() in NUMARGS macro
Message-ID: <ajvAGK-0kCfkThcs@ashevche-desk.local>
References: <20260624073804.4391-1-joyetamdk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624073804.4391-1-joyetamdk@gmail.com>
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

On Wed, Jun 24, 2026 at 01:08:04PM +0530, Joyeta Modak wrote:
> NUMARGS() computes the number of arguments by dividing the size of a
> temporary int array by sizeof(int). Using the standard ARRAY_SIZE()
> macro is the correct way to count array elements in the kernel, and
> ARRAY_SIZE() also provides a __must_be_array() compile time check. There
> are no functional changes.

...

> -#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
> +#define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
>  
>  #define write_reg(par, ...)                                            \
>  	((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))

What is the maximum parameters .write_register() takes in practice in the
fbtft drivers? If it's less than or equal to 15, we may use args.h instead.

-- 
With Best Regards,
Andy Shevchenko


