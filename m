Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06F1CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D19610F5B2;
	Fri, 26 Jun 2026 12:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SK4q9IfR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A1810F5B2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782476629; x=1814012629;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=wCsEapXgJ6j0IzYX0QqS6bCUf4OhIkDzGupdQn6gFNo=;
 b=SK4q9IfRi2rMA8+qDpnKAthRY5IIuZc32Xao2cmaGWZXXFKRksn9Dnok
 1EH6CnfbqndUJtAt2Lt55P/c6IhhyfimyFajNgfneJtVWZBu0UKhUGihO
 KNXneJ3ZNHVqWPIXhyAivUcxzN6v4iL71RJeKQcuP3uoNnzFFykw6dukO
 xh9opVmEWc1JFRUP4k45fH2Z9BRoAiBXX1ZEr/cYkB7nZaFdWulyjrzJu
 wKt1hmWwJAhGajmoZeANrDE9z3cN9dsbNtMjDuNp/eMPrni8YFEydHCqA
 i5xS5shnPh/xQog0iLCc3l4LQa7vcRffpRGknj8X7dG2UGjOjJWQhNwfr A==;
X-CSE-ConnectionGUID: SUAg+3PiRgSi8/uDk1QMlw==
X-CSE-MsgGUID: S0uvkRk7ST2BpT2q6diJNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="86947529"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="86947529"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 05:23:49 -0700
X-CSE-ConnectionGUID: Hr5DbzKkTJeEnXxrPVaphg==
X-CSE-MsgGUID: NNTVQMAERh+nuRJq6IBnRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="253227496"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 05:23:47 -0700
Date: Fri, 26 Jun 2026 15:23:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joyeta Modak <joyetamdk@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: use ARRAY_SIZE() in NUMARGS macro
Message-ID: <aj5vUDuzh67hkJjp@ashevche-desk.local>
References: <20260624073804.4391-1-joyetamdk@gmail.com>
 <ajvAGK-0kCfkThcs@ashevche-desk.local>
 <CAN3JnUCem3Mw17e5D9b-aX58_ZaAvC6GZ-sBPEQfTTTP=o-WHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN3JnUCem3Mw17e5D9b-aX58_ZaAvC6GZ-sBPEQfTTTP=o-WHA@mail.gmail.com>
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

On Fri, Jun 26, 2026 at 02:27:25PM +0530, Joyeta Modak wrote:

Please, do not top-post!

> Thank you for the feedback and the question.
> 
> I checked every write_reg() across all fbtft drivers and found that
> the largest number of arguments is 129 in write_reg(par,
> MIPI_DCS_WRITE_LUT,...)
> As COUNT_ARGS() in args.h only supports up to 15, it is not a safe fit here.
> 
> However, the kernel test robot reported a problem with my
> implementation as the __must_be_array() check in ARRAY_SIZE() requires
> the array to be a compile time constant expression and thus breaks the
> call at several places.(example par->bgr)
> 
> I tried to reproduce this locally on my system using both GCC and
> Clang with ARCH=um on x86_64 but could not reproduce the build
> failure.

How "um" is anyhow related to the real world cases? Try to compile your stuff
with real ARCH settings, like x86_64.

> Since the original sizeof() based approach had no such errors flagged,
> I am thinking of dropping the ARRAY_SIZE() approach.
> 
> Any other feedback is appreciated. Thanks again.

> On Wed, Jun 24, 2026 at 5:01 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Wed, Jun 24, 2026 at 01:08:04PM +0530, Joyeta Modak wrote:
> > > NUMARGS() computes the number of arguments by dividing the size of a
> > > temporary int array by sizeof(int). Using the standard ARRAY_SIZE()
> > > macro is the correct way to count array elements in the kernel, and
> > > ARRAY_SIZE() also provides a __must_be_array() compile time check. There
> > > are no functional changes.

...

> > > -#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
> > > +#define NUMARGS(...)  ARRAY_SIZE(((int[]){__VA_ARGS__}))
> > >
> > >  #define write_reg(par, ...)                                            \
> > >       ((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
> >
> > What is the maximum parameters .write_register() takes in practice in the
> > fbtft drivers? If it's less than or equal to 15, we may use args.h instead.

-- 
With Best Regards,
Andy Shevchenko


