Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E014C79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C8A10EF9E;
	Wed,  9 Sep 2026 08:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mEcBBaCA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8784410EF9E;
 Wed,  9 Sep 2026 08:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788940847; x=1820476847;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=xwxFHsHn1F090XyTB1Kp1qw44FUJLR6CM2Jgj9YUKvM=;
 b=mEcBBaCAQKmVEeHSgbXg2cPWugn1WbJJfv7pq3scMk7vsIwFnQC8ny0a
 Z3Ujq0E+Xcgg7AvmcDZD/zRIf3++/xl4UxvnJegOxJeZopyTugsgojVFA
 M+TTNe486JJxKaCoRLz7btkrIou8RGCiJsYHSikzNAHbS3NI/locAJ76V
 i5ZNeWWzhW32Fhqs3jE5+Hks9ONnrrpKX8MXQmjeW+te1rvUxuYXM/Y4b
 o50TeJhetYDwE0eGvzfZjlvVdNhq/As+tVpEdyp5QOEFKKoR6bO/4PQ/c
 yEQy9S3CyJQHGVOPxyIoCTMD9dw6JAMIFhDTRgjgcA/qW6e0sZXRdiPvR g==;
X-CSE-ConnectionGUID: NoVtv1zeSf+auQttrRBCwQ==
X-CSE-MsgGUID: u5SMYUfcT7iYbNq5Z3SsCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93224303"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="93224303"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 01:00:46 -0700
X-CSE-ConnectionGUID: wgvsihG8RFujZLgo1BM+IA==
X-CSE-MsgGUID: 3VYrXyGtSOmMWnrDxP7X1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="271232236"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.245.20])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 01:00:44 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Alan Previn <alan.previn.teres.alexis@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
In-Reply-To: <20260908185609.359565-2-alan.previn.teres.alexis@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260908185609.359565-2-alan.previn.teres.alexis@intel.com>
Date: Wed, 09 Sep 2026 11:00:41 +0300
Message-ID: <04c865dcd2135c202cf604b111084fc809ae322c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 08 Sep 2026, Alan Previn <alan.previn.teres.alexis@intel.com> wrote:
> Check for overflow in udelay/usleep_range use in __xe_mmio_wait32
> and pick the correct helper according to the wait time and atomic.
> Implement a similar helper to replace DIV_ROUND_UP for 32-bit CPUs.
> Avoid growing delays becoming intollerably large by capping the
> in-loop wait time.

I think it might be a better idea to remove the exponentially growing
wait time instead. It might have seemed good on paper, but you should do
the math in typical use cases and see how it actually behaves. (Spoiler:
Lots of useless back-to-back reads in the beginning, and then quickly
increasing to waits beyond the timeout and delay maximums.)

This is code that should be possible to understand. I'd suggest
simplifying the whole thing instead of making it more complex.

I think it would be much better to migrate xe mmio to use
poll_timeout_us() and poll_timeout_us_atomic() instead. For the rare
cases that actually need the quick hammering followed by slower waits,
you can trivially do two calls with delays and timeouts considered for
*that* particular use case.

I also think it's a mistake (copy-pasted from i915) to specify "atomic"
as a parameter. They should be separate functions all the way from the
caller.


BR,
Jani.


>
> v2: - Fixed checkpatch failure.
>     - Added helper for 64-bit DIV_ROUND_UP on 32-bit CPU (Shasiko
>       review). Fixed bug max range in usleep_range(Shasiko review)
>
> Fixes: 5c09bd6ccd41 ("drm/xe/mmio: Move xe_mmio_wait32() to xe_mmio.c")
> Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
> Assisted-by: Github-Copilot:Claude-Sonnet-5-0
> ---
>  drivers/gpu/drm/xe/xe_mmio.c | 50 ++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
> index 7fa18dfcb5a2..1ae382f009de 100644
> --- a/drivers/gpu/drm/xe/xe_mmio.c
> +++ b/drivers/gpu/drm/xe/xe_mmio.c
> @@ -7,6 +7,8 @@
>  
>  #include <linux/delay.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/math.h>
> +#include <linux/math64.h>
>  #include <linux/minmax.h>
>  #include <linux/pci.h>
>  
> @@ -320,6 +322,30 @@ u64 xe_mmio_read64_2x32(struct xe_mmio *mmio, struct xe_reg reg)
>  	return (u64)udw << 32 | ldw;
>  }
>  
> +/**
> + * __div_round_up64() - alternative to DIV_ROUND_UP for use by __xe_mmio_wait32
> + * @dividend: 64 bit positive number to divide
> + * @divisor: 64 bit positive divisor
> + *
> + * DIV_ROUND_UP() relies on plain '/' and '%' operators, which for 64-bit
> + * operands on a 32-bit CPU get turned into calls to libgcc's __divdi3()/
> + * __moddi3(), routines the kernel does not link against. Provide a
> + * do_div()-based equivalent that works for signed 64-bit inputs on any
> + * architecture.
> + *
> + * Returns: rounded up division result
> + */
> +static inline s64 __div_round_up64(s64 dividend, s64 divisor)
> +{
> +	u64 abs_dividend = abs(dividend);
> +	u64 abs_divisor = abs(divisor);
> +	u64 result = abs_dividend + abs_divisor - 1;
> +
> +	do_div(result, abs_divisor);
> +	/* dont check for negative values as local caller only uses positive numbers */
> +	return (s64)result;
> +}
> +
>  static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val,
>  			    u32 timeout_us, u32 *out_val, bool atomic, bool expect_match)
>  {
> @@ -349,11 +375,25 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u
>  		if (ktime_after(ktime_add_us(cur, wait), end))
>  			wait = ktime_us_delta(end, cur);
>  
> -		if (atomic)
> -			udelay(wait);
> -		else
> -			usleep_range(wait, wait << 1);
> -		wait <<= 1;
> +#define __XE_MMIO_WAIT_MAX_INLOOP_100MS (100 * USEC_PER_MSEC)
> +		if (atomic) {
> +			if (wait <= MAX_UDELAY_MS * USEC_PER_MSEC)
> +				udelay(wait);
> +			else if (BITS_PER_LONG == 32)
> +				mdelay(DIV_ROUND_UP(wait, USEC_PER_MSEC));
> +			else
> +				mdelay(__div_round_up64(wait, USEC_PER_MSEC));
> +		} else {
> +			usleep_range(wait, wait + (wait >> 2)); /* range till wait + 25% */
> +		}
> +		/*
> +		 * As we keep doubling the wait time for every check that fails, cap the
> +		 * in-loop delay-or-sleep to less than 2x 100 milliseconds to prevent from
> +		 * expanding 'wait' into exponentially longer wait times per loop that
> +		 * end up delaying the next completion check way later than tolerable.
> +		 */
> +		wait = wait < __XE_MMIO_WAIT_MAX_INLOOP_100MS >> 1 ?
> +		       wait << 1 : __XE_MMIO_WAIT_MAX_INLOOP_100MS;
>  	}
>  
>  	if (ret != 0) {

-- 
Jani Nikula, Intel
