Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BA1C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC2B710E28E;
	Wed, 26 Aug 2026 08:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="M+oINuky";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A3610E281;
 Wed, 26 Aug 2026 08:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787733314; x=1819269314;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Kz168AtLmlRcggGQwFRg/7YFC2pWvXjQBuHjsCPkXSw=;
 b=M+oINukyM8Q8G9Mp/ts71VS2cmhyeYJ7KpiOIObRf7l5jPi0JplMcqMl
 Dic7EJxK22bFsvfA3zklU4WQcGr03d7oLtdYaOpWQNkOALahAVXbQ+RU+
 8I4A8azkTeMUxPwi3G7jvbbCj0lsqWc8//w/DX4qNTaTkiSkcEuYQdMHk
 ehMAA6XzkrSW+AYy1M/YbVed8JeAY6hSmUnpEF+/TKoZ0+Rct2rjZPKt9
 NdZPDnd17+C6nUwPgzSVTFnZGGbBwm/CUjF1aPVTR034E9sqQk+RpiZBO
 kmCWonYOzvN/UfVTnMCN/c9NAfNMVIvmuwJQULDYVuAgP27Euz1mltvHt A==;
X-CSE-ConnectionGUID: sCXW3SH4S8+tanDrgrT9sg==
X-CSE-MsgGUID: a6BvEMAwQMuo1NCeZ6XjGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88237341"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="88237341"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 01:35:13 -0700
X-CSE-ConnectionGUID: k+pPWYKQTD2IpaS0xJ7ZwA==
X-CSE-MsgGUID: m0JrqszvQSaDDVkln2MI/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="266228480"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.235])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 01:35:10 -0700
Date: Wed, 26 Aug 2026 11:35:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm/i915/gem: Use simpler versions of min*()
Message-ID: <ao6lOyo5abFmwpN9@ashevche-desk.local>
References: <20260825093552.4088094-1-andriy.shevchenko@linux.intel.com>
 <ao2bfCVRT8LuOJCb@zenone.zhora.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao2bfCVRT8LuOJCb@zenone.zhora.eu>
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

On Tue, Aug 25, 2026 at 03:44:40PM +0200, Andi Shyti wrote:
> On Tue, Aug 25, 2026 at 11:35:52AM +0200, Andy Shevchenko wrote:

...

> > -		nr_pages = min_array(((unsigned long[]) {
> > -					folio_nr_pages(folio),
> > -					page_count - i,
> > -					max_segment / PAGE_SIZE,
> > -				      }), 3);
> > +		nr_pages = min3(folio_nr_pages(folio),
> > +				page_count - i, max_segment / PAGE_SIZE);
> 
> thanks for your patch, but there is another patch involving (and
> fixing) this line of code[*]. You are welcome to join the review.

Thanks for pointing this out! Do you prefer my to be rebased on top?
Otherwise one can apply this patch first.

> [*] https://patchwork.freedesktop.org/patch/746877/?series=172332&rev=1

Note, my patch doesn't change existing behaviour.

-- 
With Best Regards,
Andy Shevchenko


